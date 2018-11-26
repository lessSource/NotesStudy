//
//  MineSwiftViewController.swift
//  NotesStudy
//
//  Created by Lj on 2018/2/7.
//  Copyright © 2018年 lj. All rights reserved.
//

import UIKit
import RxSwift

class MineSwiftViewController: BaseSwiftViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.‘
        
        /*
        
        //Observable
        //Observable<Element>是一个观察者模式中被观察的对象，相当于一个事件序列，会向订阅者发送新产生的事件信息
        
        //Producer
        //Sequence
        //Sequence把一系列元素转化为事件序列
        
        let sequenceOfElements = Observable.of(1,2,3,4)
        _ = sequenceOfElements.subscribe({ (event) in
            print(event)
        })
        
        //AnonymousObservable
        //AnonymousObservable继承自Producer，Producer实现了线程调度功能，可以安排线程执行run方法，因此AnonymousObservable是可以运行在指定线程中Observable
        let generated = Observable.generate(initialState: 0, condition: {$0 < 20}, iterate: {$0 + 4})
        _ = generated.subscribe {
            print($0)
        }
        
        //Error
        //Error错误处理，创建一个不发送任何item的Observable
        let error = NSError.init(domain: "test", code: -1, userInfo: nil)
        let erroredSequence = Observable<Any>.error(error)
        _ = erroredSequence.subscribe {
            print($0)
        }
        
        //Deferred
        //Deferred会等到有订阅者的时候在通过工厂方法创建Observable对象，每个订阅者订阅的对象都是内容相同而完全独立的序列
        let deferredSequence: Observable<Int> = Observable.deferred {
            print("creating")
            return Observable.create { observer in
                print("emmition")
                observer.onNext(0)
                observer.onNext(1)
                observer.onNext(2)
                return Disposables.create()
            }
        }
        
        _ = deferredSequence.subscribe({ (event) in
            print(event)
        })
        
        _ = deferredSequence.subscribe({ (event) in
            print(event)
        })
        
        //Empty
        //Empty创建一个空的序列。它仅仅发送.Completed消息
        let emptySequence = Observable<String>.empty()
        _ = emptySequence.subscribe({ (event) in
            print(event)
        })
        
        //Never
        //Never创建一个序列，改序列永远不会发送消息，.Complete消息也不会发
        let neverSequence = Observable<Int>.never()
        _ = neverSequence.subscribe({ (_) in
            print("这句话永远都不会被打印")
        })
        
        //Just
        //just代表只包含一个元素的序列。它将向订阅者发送两个消息，第一个消息是其中元素的值，另一个是.Completed
        let singleElementSequence = Observable.just("Swift")
        _ = singleElementSequence.subscribe {
            print($0)
        }
        
        //PublishSubject
        //PublishSubject会发送订阅者从订阅之后的事件序列
        let subject = PublishSubject<String>()
        _ = subject.subscribe {
            print($0)
        }
        
        subject.onNext("dddd")
        subject.onNext("dddddd")
        
        //ReplaySubject
        //ReplaySubject在新的订阅对象订阅的时候会补发所有已经发送过的数据队列，bufferSize是缓冲区的大小，决定了补发队列的最大值。如果bufferSize是1，那么新的订阅者出现的时候就会补发上一个事件，如果是2，则补发两个，以此类推
        
        let subject1 = ReplaySubject<Int>.create(bufferSize: 2)
        _ = subject1.subscribe({ (event) in
            print("1 -> \(event)")
        })
        subject1.onNext(1)
        subject1.onNext(2)
        
        _ = subject1.subscribe({ (event) in
            print("2 -> \(event)")
        })
        subject1.onNext(3)
        subject1.onNext(4)
        
        //BehaviorSubject
        //BehaviorSubject在新的订阅对象的时候会发送最近的事件，如果没有则发送一个默认值
        let behaviorSubject = BehaviorSubject(value: "2")
        _ = behaviorSubject.subscribe({ (event) in
            print("1 -> \(event)")
        })
        behaviorSubject.onNext("a")
        behaviorSubject.onNext("b")
        
        _ = behaviorSubject.subscribe({ (event) in
            print("2 -> \(event)")
        })
        behaviorSubject.onNext("c")
        behaviorSubject.onCompleted()
        
        //Variable
        //variable是基于BehaviorSubject的一层封装,它的优势是：不会被显示终结。即：不会收到.Complete和.Error这类的终结事件，它会主动在析的时候发送.Complete
        let variable = Variable("z")
        _ = variable.asObservable().subscribe({ (event) in
            print("1 -> \(event)")
        })
        
        variable.value = "a"
        variable.value = "b"
        
        _ = variable.asObservable().subscribe({ (event) in
            print("2 -> \(event)")
        })
        variable.value = "c"
        
        //Map
        //map就是对每个元素都用函数做一次转换，挨个映射一遍
        let originalSequence = Observable.of(1,2,3)
        _ = originalSequence.map { number in
            number * 2
            }.subscribe {
                print($0)
        }
        
        //FlatMap
        //flatMap将每个Observable发射的数据变换为Observable的集合,然后将其降维排列成一个Observable
        let sequenceInt = Observable.of(1,2,3)
        let sequenceString = Observable.of("A","B","C","D","E")
        _ = sequenceInt.flatMap { (event: Int) -> Observable<String> in
            print("From sequentInt \(event)")
            return sequenceString
            }.subscribe {
                print($0)
        }
        
        //Scan
        //scan对Observable发射的每一项数据应用一个函数，然后按顺序依次发射一个值
        let sequenceToSum = Observable.of(0,1,2,3,4,5)
        _ = sequenceToSum.scan (0){ acum, elem in
            acum + elem
            }.subscribe {
                print($0)
        }
        
        //Filtering Observables
        //Filtering Observables对序列进行过滤
        
        //Filer
        //filer只会让符合条件的元素通过
        _ = Observable.of(0,1,2,3,4,5,6,7).filter {
            $0 % 2 == 0
            }.subscribe {
                print($0)
        }
        
        //DistinctUntilChanged
        //distinctUntilChanger会废弃掉重复的事件
        _ = Observable.of(1,1,2,3,4,4,4,4,5,5,5,5).distinctUntilChanged().subscribe {
            print($0)
        }
        
        //Take
        //take只获取序列中的前n个事件，在满足数量之后会自动.Completed
        _ = Observable.of(1,3,3,2,1,2,3).take(2).subscribe {
            print($0)
        }
        
        //Combination operators
        //Conbination operators是关于序列的运算，可以将多个序列源进行组合，拼装成一个新的事件序列
        
        //StartWith
        //startWith会在队列开始之前插入一个事件元素
        _ = Observable.of(1,2,3).startWith(0).subscribe {
            print($0)
        }
        
        //CombinLatest
        //ConbinLatest如果存在两件事件队列，需要同时监听，那么每当有新的事件发生的时候，combineLatest会将每个队列的最新一个元素进行合并
        let combineLatest1 = PublishSubject<String>()
        let combineLatest2 = PublishSubject<Int>()
        
        _ = Observable.combineLatest(combineLatest1,combineLatest2) {
            "\($0)\($1)"
            }.subscribe {
                print($0)
        }
        combineLatest1.onNext("iOS")
        combineLatest2.onNext(11)
        combineLatest1.onNext("Swift")
        combineLatest2.onNext(66)
        combineLatest1.onNext("Rx")
        combineLatest2.onNext(666)
        
        //为了能够产生结果，两个序列中都必须保证至少有一个元素
        let combineLatest3 = Observable.just(1)
        let combineLatest4 = Observable.of(0,1,2,3,4)
        
        _ = Observable.combineLatest(combineLatest3, combineLatest4) {
            $0 * $1
            }.subscribe {
                print($0)
        }
        
        //ComineLatest也有超过两个参数的版本
        let combineLatest5 = Observable.just(3)
        let combineLatest6 = Observable.of(0,1,2,3)
        let combineLatest7 = Observable.of(0,1,2,3,4)
        _ = Observable.combineLatest(combineLatest5, combineLatest6,combineLatest7) {
            ($0 + $1) * $2
            }.subscribe {
                print($0)
        }
        
        //CombineLatest可以作用于不同的数据类型
        let intObserver = Observable.just(2)
        let stringObserver = Observable.just("swift")
        _ = Observable.combineLatest(intObserver, stringObserver) {
            "\($0)" + $1
            }.subscribe {
                print($0)
        }
        
        //Zip
        //zip合并两条队列，不过它会等两个队列的元素一一对应地凑合之后再合并
        let stringZipObserver = PublishSubject<String>()
        let intZipObserver = PublishSubject<Int>()
        _ = Observable.zip(stringZipObserver, intZipObserver) {
            "\($0) \($1)"
            }.subscribe {
                print($0)
        }
        stringZipObserver.onNext("iOS")
        intZipObserver.onNext(6)
        stringZipObserver.onNext("swift")
        intZipObserver.onNext(66)
        stringZipObserver.onNext("Rx")
        intZipObserver.onNext(666)
        stringZipObserver.onNext("不会打印")
        
        //Merge
        //merge合并多个Observables的组合成一个
        let mergeSubject1 = PublishSubject<Int>()
        let mergeSubject2 = PublishSubject<Int>()
        _ = Observable.of(mergeSubject1, mergeSubject2).merge().subscribe({ (event) in
            print(event)
        })
        mergeSubject1.onNext(20)
        mergeSubject1.onNext(40)
        mergeSubject1.onNext(60)
        mergeSubject2.onNext(1)
        mergeSubject2.onNext(80)
        mergeSubject2.onNext(100)
        mergeSubject2.onNext(2)
        
        //例如只开一条线程
        _ = Observable.of(mergeSubject1, mergeSubject2).merge(maxConcurrent: 1).subscribe({ (event) in
            print(event)
        })
        mergeSubject1.onNext(20)
        mergeSubject1.onNext(40)
        mergeSubject1.onNext(60)
        mergeSubject2.onNext(1)
        mergeSubject2.onNext(80)
        mergeSubject2.onNext(100)
        mergeSubject2.onNext(2)
        
        //SwitchLatest
        //switchLatest将一个发射多个Observables的Observable转换成另一个单独的Observable，后者发射哪些Observables最近发射的数据项
        let var1 = Variable(0)
        let var2 = Variable(200)
        let var3 = Variable(var1.asObservable())
        _ = var3.asObservable().switchLatest().subscribe {
            print($0)
        }
        var1.value = 1
        var1.value = 2
        var1.value = 3
        var1.value = 4
        var3.value = var2.asObservable()
        var2.value = 201
        var1.value = 5
        var1.value = 6
        var1.value = 7
        
        //Error Handing Operators
        //Error Handing Operators对从Observable发射的error通知做出响应或者从错误中恢复，简称错误处理
        
        //CatchError
        //catchError收到error通知之后，转而发送一个没有错误的序列
        let sequenceThatFails = PublishSubject<Int>()
        let recoverySequence = Observable.of(100,200,300,400)
        _ = sequenceThatFails.catchError({ (error) -> Observable<Int> in
            return recoverySequence
        }).subscribe {
            print($0)
        }
        sequenceThatFails.onNext(1)
        sequenceThatFails.onNext(2)
        sequenceThatFails.onNext(3)
        sequenceThatFails.onNext(4)
        sequenceThatFails.onError(NSError.init(domain: "test", code: 0, userInfo: nil))
        
        //另一种用法
        _ = sequenceThatFails.catchErrorJustReturn(100).subscribe {
            print($0)
        }
        sequenceThatFails.onNext(1)
        sequenceThatFails.onNext(2)
        sequenceThatFails.onNext(3)
        sequenceThatFails.onNext(4)
        sequenceThatFails.onError(NSError.init(domain: "test", code: 0, userInfo: nil))
        
        //Retry
        //retry如果原始的Observable遇到错误，重新订阅
        var conut = 1
        let funnyLookingSequeence = Observable<Int>.create { observer in
            let error = NSError.init(domain: "test", code: 0, userInfo: nil)
            observer.onNext(0)
            observer.onNext(1)
            observer.onNext(2)
            if conut < 2 {
                observer.onError(error)
                conut += 1
            }
            observer.onNext(3)
            observer.onNext(4)
            observer.onNext(5)
            observer.onCompleted()
            return Disposables.create()
        }
        
        _ = funnyLookingSequeence.retry().subscribe {
            print($0)
        }
        
        //Observable Utility Operators
        //Observable Utility Operators辅助工具
        
        //Subscribe
        //subscribe有新的事件就会触发
        let sequenceOfInts = PublishSubject<Int>()
        _ = sequenceOfInts.subscribe {
            print($0)
        }
        sequenceOfInts.onNext(1)
        sequenceOfInts.onCompleted()
        
        //SubscribeNext
        _ = sequenceOfInts.subscribe (onNext:{
            print($0)
        })
        sequenceOfInts.onNext(1)
        sequenceOfInts.onCompleted()
        
        //SubscribeCompleted
        _ = sequenceOfInts.subscribe(onCompleted: {
            print("已经完成了")
        })
        sequenceOfInts.onNext(1)
        sequenceOfInts.onCompleted()
        
        //SubscribeError
        _ = sequenceOfInts.subscribe(onError: { error in
            print(error)
        })
        sequenceOfInts.onNext(1)
        sequenceOfInts.onError(NSError.init(domain: "Test", code: -1, userInfo: nil))
        
        //DoOn
        //doOn注册一个操作来监听事件的生命周期
        _ = sequenceOfInts.do(onNext: { (event) in
            print("监听 event \(event)")
        }, onError: { (event) in
            print("监听 event \(event)")
        }, onCompleted: {
            print("监听 event ()")
        }, onSubscribe: {
            print("监听 event ()")
        }, onSubscribed: {
            print("监听 event ()")
        }, onDispose: {
            print("监听 event ()")
        }).subscribe {
            print($0)
        }
        
        sequenceOfInts.onNext(1)
        sequenceOfInts.onCompleted()
        
        //Conditional and Boolean Operators
        //Conditional and Boolean Operators条件和布尔操作，可用操作根据条件发射或变换Observables，或者对他们做布尔运算
        
        //TakeUntil
        //takeUntil当第二个Observable发送数据之后，丢弃第一个Observable在在之后的所有消息
        let takeUntilOriginalSequence = PublishSubject<Int>()
        let whenThisSendsNextWordStops = PublishSubject<Int>()
        _ = takeUntilOriginalSequence.takeUntil(whenThisSendsNextWordStops).subscribe {
            print($0)
        }
        takeUntilOriginalSequence.onNext(1)
        takeUntilOriginalSequence.onNext(2)
        takeUntilOriginalSequence.onNext(3)
        takeUntilOriginalSequence.onNext(4)
        takeUntilOriginalSequence.onNext(5)
        takeUntilOriginalSequence.onNext(6)
        
        whenThisSendsNextWordStops.onNext(1)
        takeUntilOriginalSequence.onNext(8)
        
        //takeWhile
        //takeWhile发送原始Observable的数据，直到一个特定打条件false
        let takeWhileSequence = PublishSubject<Int>()
        _ = takeWhileSequence.takeWhile({ (event)  in
            event < 4
        }).subscribe {
            print($0)
        }
        takeWhileSequence.onNext(1)
        takeWhileSequence.onNext(2)
        takeWhileSequence.onNext(3)
        takeWhileSequence.onNext(4)
        takeWhileSequence.onNext(5)
        
        //Mathematical and Aggregate Operators
        //Mathematical and Aggregate Operators算数和聚concat合并两个或者以上的Observable的消息，并且这些消息的发送时间不会交叉
        let behavior1 = BehaviorSubject.init(value: 0)
        let behavior2 = BehaviorSubject.init(value: 200)
        let behavior3 = BehaviorSubject.init(value: behavior1)
        _  = behavior3.concat().subscribe {
            print($0)
        }
        behavior1.onNext(1)
        behavior1.onNext(2)
        behavior1.onNext(3)
        behavior1.onNext(4)
        behavior3.onNext(behavior2)
        behavior2.onNext(201)
        behavior1.onNext(5)
        behavior1.onNext(6)
        behavior1.onNext(7)
        behavior1.onCompleted()
        behavior2.onNext(202)
        behavior2.onNext(203)
        behavior2.onNext(204)
        
        //Reduce
        //reduce按顺序对Observable发射的每项数据应用一个函数并发射最终的值
        _ = Observable.of(0,1,2,3,4,5,6,7,8,9).reduce(0, accumulator: +).subscribe {
            print($0)
        }
        
        //Connectable Observable Operators连接操作
        
        //Deley
        //Deley延迟操作
//        let deleyObserver = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//        _ = deleyObserver.subscribe {
//            print("第一次走 \($0)")
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//            _ = deleyObserver.subscribe {
//                print("延迟5s走的 \($0)")
//            }
//        }
 */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
