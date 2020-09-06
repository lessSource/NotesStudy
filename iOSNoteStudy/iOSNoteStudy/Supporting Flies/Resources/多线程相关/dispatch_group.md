## dispatch_group

例有一个A耗时操作，B和C两个网络请求和一个耗时操作C当ABC都执行完成后，刷新页面，可以用disptahc_group实现

```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    __block NSInteger number = 0;
    
    dispatch_group_t group = dispatch_group_create();
    
    // A耗时操作
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(3);
        
        number += 222;
    });
    
    // B网络请求
    dispatch_group_enter(group);
    [self sendRequestWithCompletion:^(id response) {
        number += [response integerValue];
        dispatch_group_leave(group);
    }];
    
    // C网络请求
    dispatch_group_enter(group);
    [self sendRequestWithCompletion:^(id response) {
        number += [response integerValue];
        dispatch_group_leave(group);
    }];


    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"%zd", number);
    });
    
}

- (void)sendRequestWithCompletion:(void (^)(id response))completion {
    // 模拟一个网络请求
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        sleep(2);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(@111);
            }
        });
    });
}

```

##### dispatch_group_create

```c
dispatch_group_t
dispatch_group_create(void) {
  return (dispatch_group_t)dispatch_semaphore_create(LONG_MAX);
}
```

dispatch_group_create其实就是创建一个value为LONG_MAX的dispatch_semaphore信号量

##### dispatch_group_async

```c
void 
dispatch_group_async(dispatch_group_t dg, dispatch_queue_t dq, dispatch_block_t db) {
  dispatch_group_async_f(dg, dq, _dispatch_Block_copy(db), _dispatch_call_block_and_release);
}
```

dispatch_group_async只是对dispatch_group_async_f的封装

##### dispatch_group_async_f

```c
void
dispatch_group_async_f(dispatch_group_t dg, dispatch_queue_t dq, void *ctxt, dispatch_function_t func) {
  
  dispatch_continuation_t dc;
  
  _dispatch_retain(dg);
  dispatch_grounp_enter(dg);
  
  dc = fastpath(_dispatch_continuation_alloc_cacheonly());
  if (!dc) {
    dc = _dispatch_continuation_alloc_from_heap();
  }
 
  dc ->do_vtable = (void *)(DISPATCH_OBJ_ASYNC_BIT | DISPATCH_OBJ_GROUP_BIT);
  dc ->dc_func = func;
  dc ->dc_ctxt = ctxt;
  dc ->dc_group = dg;
  
  // NO fastpath/slowpath hint because we simply don`t know
  if (dq ->dq_with != 1 && dq ->do_targetq) {
    return _dispatch_async_f2(dq, dc);
  }
  
  _dispatch_queue_push(dq, dc);
}
```

从上面的代码可以看出<font color=#ff2200>dispatch_group_async_f</font>和<font color = #ff2200>dispatch_async_f</font>相似。<font color=#ff2200>dispatch_group_async_f</font>多了<font color=#ff2200>dispatch_group_enter(dg);</font>，另外在<font color=#ff2200>do_vtable</font>的赋值中<font color=red>dispatch_group_async_f</font>多了一个<font color=red>DISPATCH_OBJ_GROUP_BIT</font>的标记符。既然添加了<font color=#ff2200>dispatch_group_enter</font>必定会存在<font color=red>dispatch_group_leave</font>。在之前《深入理解GCD之dispatch_queue》介绍<font color=#ff2200>_dispatch_continuation_pop</font>函数的源码中有一段代码如下；

```c
_dispatch_client_callout(dc -> dc_ctxt, dc -> dc_func);
if (dg) {
  // group需要进行调用dispatch_group_leave并释放信号
  dispatch_group_leave(dg);
  _dispatch_release(dg);
}
```

所以<font color=red>dispatch_group_async_f</font>函数中的<font color=red>dispatch_group_leave</font>是在<font color=red>_dispatch_continuation_pop</font>函数中调用的。

概括一下<font color=red>dispatch_group_async_f</font>的工作流程：

1. 调用<font color=red>dispatch_group_enter</font>；
2. 将block和queue等信息记录到<font color=red>dispatch_continuation_t</font>结构体中，并将它加入到group的链表中；
3. <font color=red>_dispatch_continuation_pop</font>执行时会判断任务是否为group,是的话执行完任务再调用<font color=#ff2200>dispatch_group_leave</font>以达到信号量的平衡。

##### dispatch_group_enter

```c
void
dispatch_group_enter(dispatch_group_t dg) {
  dispatch_semaphore_t dsema = (dispatch_semaphore_t)dg;
  (void)dispatch_semaphore_wait(dsema, DISOTACH_TIME_FOREVER)
}
```

<font color=#ff2200>dispatch_group_enter</font>将<font color=#ff2200>dispatch_group_t</font>转换成<font color=#ff2200>dispatch_semaphore_t</font>，并调用<font color=#ff2200>dispatch_semaphore_wait</font>，原子性减1后，进入等待状态直到有信号唤醒。所以说dispatch_group_enter就是对dispatch_semaphore_wait的封装

##### dispatch_group_leave

```c
void
dispatch_group_leave(dispatch_group_t dg) {
  dispatch_semaphore_t dsema = (dispatch_semaphore_t)dg;
  dispatch_atomic_release_barrier();
  long value = dispatch_atomic_inc2o(dsema, dsema_value); // dsema_value原子性加1
  if (slowpath(value == LONG_MIN)) {  //内存溢出，由于dispatch_group_leave在dispatch_group_enter之前调用
    DISPATCH_CLIENT_CRASH("Unbalanced call to dispatch_group_leave()");
  }
  if (slowpath(value == dsema -> dsema_orig)) { // 表示所有任务已完成，唤醒group
    (void)_dispatch_group_wake(dsema);
  }
}
```

<p>从上面的源代码中看出<font color=#ff2200>dispatch_group_leave</font>将<font color=#ff2200>dispatch_group_t</font>转换成<font color=#ff2200>dispatch_semaphore_t</font>后将<font color=#ff2200>dsema_value</font>的值原子性加1。如果<font color=#ff2200>value</font>为<font color=#ff2200>LONG_MIN</font>程序crash；如果<font color=#ff2200>value</font>等于<font color=#ff2200>dsema_orig</font>表示所有任务已完成，调用<font color=#ff2200>_dispatch_group_wake</font>唤醒group（<font color=#ff2200>_dispatch_group_wake</font>的用于和notify有关）。因为<font color=#ff2200>enter</font>的时候进行了原子性减1操作。所以在<font color=#ff2200>leave</font>的时候需要原子性加1</p>

<font color=#ff2200>enter</font>和<font color=#ff2200>leave</font>之间的关系；

1. dispatch_group_leave与dispatch_group_enter配对使用。当调用了dispatch_group_enter而没有调用dispatch_group_leave时，由于value不等于dsema_orig不会走到唤醒逻辑，dispatch_group_notify中的任务无法执行或者dispatch_group_wait收不到信号而卡住线程。
2. dispatch_group_enter必须dispatch_group_leave之前出现。当dispatch_group_leave比dispatch_group_enter多调用了一次或者在dispatch_group_enter之前被调用时候，dispatch_group_leave进行了原子性加1的操作，相当于value为LONGMAX+1，发生数据长度溢出，变成LONG_MIN，由于value == LONG_MIN 成立，程序发生crash。

##### dispatch_group_notify

```c
void
dispatch_group_notify(dispatch_group_t dg, dispatch_queue_t dq, dispatch_block_t db) {
  dispatch_group_notify_f(dg, dq, _dispatch_Block_copy(dp), _dispatch_call_block_and_release);
}
```

<font color=#ff2200>dispatch_group_notify</font>是<font color=#ff2200>dispatch_group_notify_f</font>的封装

##### dispatch_group_notify_f

```c
void
dispatch_group_notify_f(dispatch_group_t dg, dispatch_queue_t dq, void *ctxt, void (*func)(void *)) {
  dispatch_semaphore_t dsema = (dispatch_semaphore_t)dg;
  struct dispatch_sema_notify_s *dsn, *prev;
  
  // 封装disapcth_continuation_结构体
  // FIXME -- this should be updated to use the continuation cache
  while (!(dsn = calloc(1, sizeof(*dsn)))) {
    sleep(1);
  }
  dsn->dsn_queue = dq;
  dsn->dsn_ctxt = ctxt;
  dsn->dsn_func = func;
  _dispatch_retain(dq);
  dispatch_atomic_store_barrier();
  // 将结构体放到链表尾部，如果链表为空同时设置链表头部节点并唤醒group
  prev = dispatch_atomic_xchg2o(dsema, dsema_notify_tail, dsn);
  if (fastpath(prev)) {
    prev -> dsn_next = dsn;
  }else {
    _dispatch_retain(dg);
    (void)dispatch_atomic_xchg2o(dsema, dsema_notify_head, dsn);
    if (dsema -> dsema_value == dsema-> dsema_orig) { // 任务已经完成，唤醒group
      _dispatch_group_wake(dsema);
    }
  }
}
```

所以<font color=#ff2200>dispatch_group_notify</font>函数只是用链表把所有回调通知保存起来，等待调用。

##### dispatch_group_wake

```c
static long
_dispatch_group_wake(dispatch_semaphore_t dsema) {
  struct dispatch_sema_notufy_s *next, *head, *tail = NULL;
  long rval;
  // 将dsema的dsema_notify_head赋值为NULL, 同时将之前的内容赋给head
  head = dispatch_atomic_xchg2o(dsema, dsema_notify_head, NULL);
  if (head) {
    // snapshot before anything is notified/woken
    // 将dsema的dsema_notify_tail赋值为NULL,同时将之前的内容赋给tail
    tail = dispatch_atomic_xchg2o(dsema, dsema_notufy_tail, NULL);
  }
  // 将dsema的dsema_group_waiters设置为0，并返回原来的值
  rval = dispatch_atomic_xchg2o(dsema, dsema_group_waiters, 0);
  if (rval) {
    // 循环调用semaphore_signal唤醒当初等待group的信号量，使得dispatch_group_wait函数返回。
    // wake group waiters
#if USE_MACH_SEM
    _dispatch_semaphore_create_port(&dsema->dsema_waiter_port);
    do {
      kern_return_t kr = semaphore_signal(dsema->dsema_waiter_port);
      DISPATCH_SEMAPHORE_VERFY_KR(kr);
    } while (--rval);
#elif USE_POSIX_SEM
    do {
      int ret = sem_post(&dsema->dsema_sem);
      DISPATCH_SEMAPHONE_VERIFY_RET(ret);
    }while (--rval);
#endif
  }
  if (head) {
    // 获取链表，依次调用dispatch_async_f异步执行在notify函数中的任务即block。
    // async group notify block
    do {
      dispatch_async_f(head -> dsn_queue, head -> dsn_ctxt, head -> dsn_func);
      _dispatch_release(head->dsn_queue);
      next = fastpath(head -> dsn_next);
      if (!next && head != tail) {
        while (!(next = fastpath(head -> dsn_next))) {
          _dispatch_hardware_pause();
        }
      }
      free(head);
    }while ((head = next));
    _dispatch_release(dsema);
  }
  return = 0;
}
```

<font color=#ff2200>_disoatch_group_wake</font>主要的作用有两个：

1. 调用semaphore_signal唤醒当初等待group的信号量，使得dispatch_group_wait函数返回。

2. 获取链表，依次调用dispatch_async_f异步执行在notify函数中的任务即block.

   

![1966287-c64c53fd1570307b](1966287-c64c53fd1570307b.png)

##### dispatch_group_wait

```c
long
dispatch_group_wait(dispatch_group_t dg, dispatch_time_t timeout) {
  dispatch_semaphore_t dsema = (dispatch_semaphore_t)dg;
  if (dsema -> dsema_value == dsema -> dsema_orig) { //没有需要执行的任务
    return 0;
  }
  if (timeout == 0) { // 返回超市
#if USE_MACH_SEM
    return KERN_OPERATION_TIMED_OUT;
#elif USE_POSIX_SEM
    errno =ETIMEDOUT;
    return (-1);
#endif
  }
  return _dispatch_group_wait_slow(dsema, timeout);
}
```

<font color=#ff2200>disoatch_group_wait</font>用于等待group中的任务完成

##### _dispatch_group_wait_slow

```c
static long
_dispatch_group_wait_slow(diispatch_semaphore_t dsema, dispatch_time_t timeout) {
  long orig
agsin:
  // check before we cause another signal to be sent by incrementing
  // dsema -> dsema_group_waites
  if (dsema -> dsema_value == dsema -> dsema_orig) {
    return _dispatch_group_wake(dsema);
  }
  // Mach semaphores appear to sometomes spuiously wake up. Therefore
  // we keep a parallel count of the number of times a Mach semaphore is signaled
  (void)dispatch_atomic_inc2o(dsema, dsema_group_waites);
  // check the values again in case we need yo wake any threads
  if (dsama -> dsema_value == dsema -> dsema_orig) {
    return _dispatch_group_wake(dsema);
  }
#if USE_MACH_SEM
  
  mach_timespec_t _timeout;
  kern_renturn_t kr;
  
  _dispatch_semaphore_create_port(&dsema -> dsema_waiter_port);
  
  // Form xnu/osfmk/kern/sync_sema.c:
  // wait_semaphore -> count = -1 ; /* we don`t keep anactual count */
  
  // The code above does not match the documentation, and that fact is not surprosing. The documented semantics are clumsy to use in any practical way. The above hack effectively tricks the rest of the Mack semaphore logic to behave like the libdispatch algirithm.
  
  switch (timeout) {
    default:
      do {
        uint64_t nsec = _dispatch_timeout(timeout);
        _timeout.tv_sec = (typeof(_timeout.tv_sec))(nsec / NSEC_PER_SEC);
        _timeout.tv_nsec = (typeof(_timeout.tv_nsec))(nsec % NSEC_PER_SEC);
        kr = slowpath(semaphore_timedwait)(dsema->dsema_waiter_port, _timeout));
      } while (kr == KERN_ABORTED);
      
      if (kr != KERN_OPERATION_TIMED_OUT) {
        DISPATCH_SEMAPHORE_VERIFY_KR(kr);
        break;
      }
      // Fall through and try to undo the earlier change to 
      // dsema -> dsema_group_waiters
    case DISPATCH_TIME_NOW:
      while ((orig = dseam -> dsema_group_waiters)) {
        if (dispatch_atomic_cmpxchg2o(dsema, dsema_gropu_waiters, orig, orig - 1)) {
          return KERN_OPERATION_TIMED_OUT;
        }
      }
      
      // Another thread called semaphore_signal().
      // Fall through and drain the wakeup
      
    case DISPATCH_TIME_FOREVER:
      do {
        kr = semaphore_wait(dsema -> dsema_waiter_port);
      }while (kr == KERN_ABORTED);
      DISPATCH_SEMAPHORE_VERIFY_KR(kr);
      break;   
  }
  
#elif USE_POSIX_SEM
// 
#endif
  
  goto again;
}
```

<p>从上面的代码发现_dispatch_group_wait_slow和_dispatch_semaphore_wait_slow的逻辑很接近。都利用mach内核的semaphore进行信号的发送。区别在于_dispatch_semaphore_wait_slow在等待结束后return，而_dispatch_group_wait_slow在等待结束是调用_dispatch_group_wake去唤醒这个group</p>

##### 总结

1. dispatch_group是一个初始化为LONG_MAX的信号量，group中的任务完成是判断value是否恢复初始值。
2. dispatch_group_enter和dispatch_group_leave必须成对使用并且支持嵌套。
3. 如果dispatch_group_enter比dispatch_group_leave多，由于value不等于dsema_orig不会走到唤醒逻辑，dispatch_group_notify中的任务无法执行或者dispatch_group_wait收不到信号而卡住线程。如果是dispatch_group_leave多，则会引起崩溃。