//
//  ViewController.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/4/17.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <FMDB/FMDB.h>
#import "CustomNotificationCenter.h"

@class FootView;

@interface ViewController ()

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    NSOperationQueue *dad = [NSOperationQueue add]
    
    
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
    
    [self runtime];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataScuucess) name:@"123455" object:nil];
    
    
//    [[CustomNotice share] addObserver:self selector:@selector(dataScuucess) name:@"dataScuucess"];
}

- (void)dataScuucess {
    NSLog(@"123456");
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)runtime {
    
    
}


@end

@implementation ClassName


@end

