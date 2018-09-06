//
//  iOSNoteStudyUITests.m
//  iOSNoteStudyUITests
//
//  Created by Lj on 2018/4/17.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface iOSNoteStudyUITests : XCTestCase

/** 当前测试的APP */
@property (nonatomic, strong) XCUIApplication *app;

@end

@implementation iOSNoteStudyUITests

- (void)setUp {
    [super setUp];
    
//    XCUIApplication *app = [[XCUIApplication alloc] init];
//    //重新启动引用
//    [app launch];
//    //启动参数
//    NSArray *args = [app launchArguments];
//    for(int i=0;i<args.count;i++){
//        NSLog(@"arg :  %@",[args objectAtIndex:i]);
//    }
//    //启动环境
//    NSDictionary *env = [app launchEnvironment];
//    for (id key in env) {
//        NSString *object=[env objectForKey:key];
//        NSLog(@"env : %@",object);
//    }
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
//    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    [self.app launch];

    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
            // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    [self allTextExample];
}

- (void)allTextExample {
    [self testSelect];
}

- (void)testSelect {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [[app.scrollViews.otherElements.collectionViews.cells.otherElements containingType:XCUIElementTypeImage identifier:@"商城"].element tap];
    [app.tables.staticTexts[@"商品详情"] tap];
    
    for (int i = 0; i < 50; i ++) {
//        int y = arc4random() % 6;
        [app.buttons[@"测试"] tap];
    }
}

@end
