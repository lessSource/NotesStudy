//
//  HomeTestCase.m
//  iOSNoteStudyTests
//
//  Created by Lj on 2018/4/26.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "BaseTestCase.h"
#import "HomePageViewController.h"
#import "ContactDataObject.h"
#import "PermissionsObject.h"

@interface HomeTestCase : BaseTestCase

@end

@implementation HomeTestCase

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

//链接数据库
- (void)testCreateDataBase {
    [[ContactDataObject shareInstance] createDataBase];
}

//插入数据
- (void)testInssertData {
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"dd",@"userId", NULL];
    [[ContactDataObject shareInstance] insertData:dic];
}

//删除数据
- (void)testDeleteData {
    [[ContactDataObject shareInstance]deleteData:@"dd"];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.

    }];
}

@end
