//
//  iOSNoteStudyTests.m
//  iOSNoteStudyTests
//
//  Created by Lj on 2018/4/17.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HomePageViewController.h"

@interface iOSNoteStudyTests : XCTestCase

@property (nonatomic, strong) HomePageViewController *homePageVC;

@end

@implementation iOSNoteStudyTests

//测试夹具的设置方法，在每个测试用例运行前被调用，在此方法中完成每个测试用例的初始化工作
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.homePageVC = [[HomePageViewController alloc]init];
}

//测试用例的清理方法，在每个测试用例执行完
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.homePageVC = nil;
    
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results
}

- (void)testHome {
//    NSInteger result = self.homePageVC
//    NSInteger result = [self.homePageVC homeTest]
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
