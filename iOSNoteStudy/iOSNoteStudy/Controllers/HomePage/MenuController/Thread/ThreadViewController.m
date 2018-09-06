//
//  ThreadViewController.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/31.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "ThreadViewController.h"

@interface ThreadViewController ()

@end

@implementation ThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"线程";
}

- (NSArray *)buttonListArray {
    return @[@"串行队列",@"并发队列",@"主队列",@"全局并发队列",@"同步执行任务",@"异步执行任务",@"串行同步",@"串行异步",@"并发同步",@"并发异步",@"主队列同步",@"主队列异步",@"GCD栅栏",@"GCD延时执行",@"GCD实现代码只执行一次",@"GCD快速迭代",@"GCD队列组"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        //串行队列
        dispatch_queue_t serialQueue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
        [self alertController:serialQueue.description];
    }else if (indexPath.row == 1) {
        //并发队列
        dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
        [self alertController:concurrentQueue.description];
    }else if (indexPath.row == 2) {
        //主队列：主队列负责在主线程上调度任务，如果在主线程上已经有任务在执行，主队列会等到主线程空闲后在调度任务。通常是返回主线程跟新UI的时候使用。
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            //耗时操作
            for (int i = 0; i < 100; i ++) {
                sleep(0.5);
                [[LSAlertUtil alertManager]showPromptInfo:[NSString stringWithFormat:@"耗时操作%d",i]];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
               //回到主线程跟新UI
                [self alertController:@"回到主线程了"];
            });
        });
    }else if (indexPath.row == 3) {
        //全局并发队列
        dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        [self alertController:globalQueue.description];
    }else if (indexPath.row == 4) {
        //同步执行任务
        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            [self alertController:@"dispatch_sync(dispatch_get_global_queue(0, 0), ^{})"];
        });
    }else if (indexPath.row == 5) {
        //异步执行任务
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self alertController:@"dispatch_async(dispatch_get_global_queue(0, 0), ^{})"];
        });
    }else if (indexPath.row == 6) {
        //串行同步
        //执行完一个任务，在执行下一个任务，不开启新线程
        [self _syncSerial];
    }else if (indexPath.row == 7) {
        //串行异步
        //开启新线程，但因为任务是串行的，所以还是按顺序执行任务
        [self _asyncSerial];
    }else if (indexPath.row == 8) {
        //并发同步
        //因为是同步的，所以执行完一个任务，在执行下一个任务。不会开启新线程
        [self _syncConcurrent];
    }else if (indexPath.row == 9) {
        //并发异步
        //任务交替执行，开启多线程
        [self _asyncConcurrent];
    }else if (indexPath.row == 10) {
        //主队列同步
        //如果在主线程中运用这个方法，则会发生死锁，程序崩溃
    }else if (indexPath.row == 11) {
        //主队列异步
        //在主线程中顺序执行
        [self _asyncMain];
    }else if (indexPath.row == 12) {
        //GCD栅栏
        //当任务需要异步进行，但是这些任务需要分成两组来执行，第一组组成之后才能进行第二组的操作。这时候就用了GCD的栅栏方法dispatch_barrier_async
        [self _barrierGCD];
    }else if (indexPath.row == 13) {
        //GCD延时执行
        //当需要等待一会在执行一段代码时，就可以用到这个方法，dispatch_after
        NSLog(@"*********GCD延时执行：dispatch_after*******");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self alertController:@"我已经等待了五秒"];
        });
    }else if (indexPath.row == 14) {
        //GCD实现代码只执行一次
        //使用dispatch_once_t能保证某段代码在程序运行过程中只被执行1次。
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self alertController:@"程序运行过程中只执行一次"];
        });
    }else if (indexPath.row == 15) {
        //GCD快速迭代
        //GCD有一个快速迭代方法dispatch_apple, dispatch_apple可以同时遍历多个数字
        [self _applyGCD];
    }else if (indexPath.row == 16) {
        //GCD队列组
        //异步执行几个耗时操作，当这几个操作都完成之后再回到主线程操作，可以用队列组
        //队列组的特定
        //所有的任务都会并发的执行（不按序）
        //所有的异步函数都添加到队列中，然后再纳入队列组的监听范围
        //使用dispatch_group_notify函数，来监听上面的任务是否完成，如果完成就调用这个方法
        [self _queueGroupGCD];
    }
}

- (void)alertController:(NSString *)message {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"晓得啦" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:action];
    [self.navigationController presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark -
/** 串行同步 */
- (void)_syncSerial {
    NSLog(@"\n************串行同步**************\n");
    //串行队列
    dispatch_queue_t queue = dispatch_queue_create("syncSerial", DISPATCH_QUEUE_SERIAL);
    //同步执行
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i ++) {
            NSLog(@"串行同步1 %@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i ++) {
            NSLog(@"串行同步2 %@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i ++) {
            NSLog(@"串行同步3 %@",[NSThread currentThread]);
        }
    });
}

/** 串行异步 */
- (void)_asyncSerial {
    NSLog(@"\n*************串行同步*************\n");
    //串行队列
    dispatch_queue_t queue = dispatch_queue_create("_asyncSerial", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i ++) {
            NSLog(@"串行异步1 %@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i ++) {
            NSLog(@"串行异步2 %@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i ++) {
            NSLog(@"串行异步3 %@",[NSThread currentThread]);
        }
    });
}

/** 并发同步 */
- (void)_syncConcurrent {
    NSLog(@"\n*************并发同步************\n");
    //并发同步
    dispatch_queue_t queue = dispatch_queue_create("syncConcurrent", DISPATCH_QUEUE_CONCURRENT);
    //同步执行
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i ++) {
            NSLog(@"并发同步1 %@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i ++) {
            NSLog(@"并发同步2 %@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i ++) {
            NSLog(@"并发同步3 %@", [NSThread currentThread]);
        }
    });
}

/** 并发异步 */
- (void)_asyncConcurrent {
    NSLog(@"\n************并发异步************\n");
    
    //并发队列
    dispatch_queue_t queue = dispatch_queue_create("asyncConcurrent", DISPATCH_QUEUE_CONCURRENT);
    //同步执行
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i ++) {
            NSLog(@"并发异步1 %@", [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i ++) {
            NSLog(@"并发异步2 %@", [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i ++) {
            NSLog(@"并发异步3 %@", [NSThread currentThread]);
        }
    });
}

/** 主队列同步 */
- (void)_syncMain {
    NSLog(@"\n**************主队列同步************\n");
    
    //主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i ++) {
            NSLog(@"主队列同步1 %@", [NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i ++) {
            NSLog(@"主队列同步2 %@", [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i ++) {
            NSLog(@"主队列同3 %@", [NSThread currentThread]);
        }
    });
    /*  主队列同步造成死锁的原因
    * 如果在主线程中运用主队列同步，也就是把任务放到了主线程的队列中。
    * 而同步对于任务是立即执行的，那么当把一个任务放进主队列时，它就会立即执行
    * 可是主线程现在正在处理_syncMain方法，任务需要等_syncMain执行完才能执行
    * _syncMain执行到第一个任务的时候，又要等第一个任务执行完才能往下执行第二个和第三个任务
    * 这样_syncMain方法和第一个任务就开始了相互等待，形成了死锁
    */
}

/** 主队列异步 */
- (void)_asyncMain {
    NSLog(@"\n**************主队列异步*************\n");
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i ++) {
            NSLog(@"主队列异步1 %@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i ++) {
            NSLog(@"主队列异步2 %@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i ++) {
            NSLog(@"主队列异步3 %@",[NSThread currentThread]);
        }
    });
}

/** GCD栅栏 */
- (void)_barrierGCD {
    NSLog(@"\n*************GCD栅栏**************\n");
    
    //并发队列
    dispatch_queue_t queue = dispatch_queue_create("_barrierGCD", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i ++) {
            NSLog(@"栅栏：并发异步1 %@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i ++) {
            NSLog(@"栅栏：并发异步2 %@",[NSThread currentThread]);
        }
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"***************barrier**********%@",[NSThread currentThread]);
        NSLog(@"***************并发异步执行，但是34一定12后面***********");
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i ++) {
            NSLog(@"栅栏：并发异步3 %@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i ++) {
            NSLog(@"栅栏：并发异步4 %@",[NSThread currentThread]);
        }
    });
}

/** GCD快速迭代 */
- (void)_applyGCD {
    NSLog(@"\n**************GCD快速迭代************\n");
    
    //并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //dispatch_apply几乎同时遍历多个数字
    dispatch_apply(7, queue, ^(size_t index) {
        NSLog(@"dispatch_apply: %zd============%@",index, [NSThread currentThread]);
    });
}

/** GCD队列组 */
- (void)_queueGroupGCD {
    NSLog(@"\n**************GCD队列组************\n");
    dispatch_group_t queue = dispatch_group_create();
    
    dispatch_group_async(queue, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"队列组：有一个耗时操作完成！");
    });
    
    dispatch_group_async(queue, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"队列组：有一个耗时操作完成!");
    });
    
    dispatch_group_notify(queue, dispatch_get_main_queue(), ^{
        NSLog(@"队列组：前面的耗时操作都完成了，回到主线程进行相关操作");
    });    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
