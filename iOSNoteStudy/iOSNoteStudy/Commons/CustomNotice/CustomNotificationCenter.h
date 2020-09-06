//
//  CustomNotificationCenter.h
//  iOSNoteStudy
//
//  Created by L j on 2020/7/25.
//  Copyright © 2020 lj. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CustomNotificationModel;

NS_ASSUME_NONNULL_BEGIN

@interface CustomNotificationCenter : NSObject

+ (instancetype)defaultCenter;

// 注册通知
- (void)addObserver:(nonnull id)observer selector:(nonnull SEL)selector name:(NSString *)name;

// 发送通知
- (void)postNotificationName:(NSString *)name;

// 移出通知
- (void)removeObserver:(nonnull id)observer;


@end



@interface CustomNotificationModel : NSObject
// 通知字符串名称
@property (nonatomic, copy) NSString *name;
// 观察者对象
@property (nonatomic, strong) id observer;
// 执行方法
@property (nonatomic, assign) SEL selector;

@end


NS_ASSUME_NONNULL_END
