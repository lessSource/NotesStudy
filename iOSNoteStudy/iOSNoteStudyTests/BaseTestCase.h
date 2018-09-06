//
//  BaseTestCase.h
//  iOSNoteStudyTests
//
//  Created by Lj on 2018/4/26.
//  Copyright © 2018年 lj. All rights reserved.
//

#define assertTrue(expr)              XCTAssertTrue((expr), @"")
#define assertFalse(expr)             XCTAssertFalse((expr), @"")
#define assertNil(a1)                 XCTAssertNil((a1), @"")
#define assertNotNil(a1)              XCTAssertNotNil((a1), @"")
#define assertEqual(a1, a2)           XCTAssertEqual((a1), (a2), @"")
#define assertEqualObjects(a1, a2)    XCTAssertEqualObjects((a1), (a2), @"")
#define assertNotEqual(a1, a2)        XCTAssertNotEqual((a1), (a2), @"")
#define assertNotEqualObjects(a1, a2) XCTAssertNotEqualObjects((a1), (a2), @"")
#define assertAccuracy(a1, a2, acc)   XCTAssertEqualWithAccuracy((a1),(a2),(acc))

#define WAIT                                                                \
do {                                                                        \
[self expectationForNotification:@"LCUnitTest" object:nil handler:nil]; \
[self waitForExpectationsWithTimeout:60 handler:nil];                   \
} while(0);

#define NOTIFY                                                                            \
do {                                                                                      \
[[NSNotificationCenter defaultCenter] postNotificationName:@"LCUnitTest" object:nil]; \
} while(0);

#import <XCTest/XCTest.h>

@interface BaseTestCase : XCTestCase

@end
