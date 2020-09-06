//
//  CustomNotificationCenter.m
//  iOSNoteStudy
//
//  Created by L j on 2020/7/25.
//  Copyright © 2020 lj. All rights reserved.
//

#import "CustomNotificationCenter.h"

static CustomNotificationCenter *notificationCenter;

@interface CustomNotificationCenter()

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

@implementation CustomNotificationCenter

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
        static dispatch_once_t onceToken;
    
        dispatch_once(&onceToken, ^{
            if (notificationCenter == nil) {
                notificationCenter = [super allocWithZone:zone];
            }
            
        });
    return notificationCenter;
}


+ (instancetype)defaultCenter {    
    return [[self alloc]init];
}

// 注册通知
- (void)addObserver:(nonnull id)observer selector:(nonnull SEL)selector name:(NSString *)name {
    CustomNotificationModel *notiModel = [[CustomNotificationModel alloc]init];
    notiModel.name = name;
    __weak typeof(observer) weakObserver = observer;
    notiModel.observer = weakObserver;
    notiModel.selector = selector;
    
    if ([self.dataDic.allKeys containsObject:notiModel.name]) {
        NSMutableArray *array = (NSMutableArray *)self.dataDic[name];
        [array addObject:notiModel];
    }else {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:notiModel];
        [self.dataDic setObject:array forKey:name];
    }
    
}

// 发送通知
- (void)postNotificationName:(NSString *)name {
    if (![self.dataDic.allKeys containsObject:name]) {
        return;
    }
    NSArray *array = (NSArray *)self.dataDic[name];
    [array enumerateObjectsUsingBlock:^(CustomNotificationModel   * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.observer respondsToSelector:obj.selector]) {
            ((void (*)(id, SEL))[obj.observer methodForSelector:obj.selector])(obj.observer, obj.selector);
        }
    }];
    
}

// 移出通知
- (void)removeObserver:(nonnull id)observer {
    NSMutableArray *nameArray = [NSMutableArray array];
    NSArray *keys = self.dataDic.allKeys;
    for (int i = 0; i < keys.count; i ++) {
        NSArray *values = [self.dataDic objectForKey:keys[i]];
        for (CustomNotificationModel *model in values) {
            id ddd = model.observer;
            NSLog(@"%@",ddd);
            if (model.observer == observer) {
                [nameArray addObject:model.name];
            }
        }
    }
    if (nameArray.count != 0) {
        [self.dataDic removeObjectsForKeys:nameArray];
    }
}
                      
                      
- (NSMutableDictionary *)dataDic {
    if (_dataDic == nil) {
        _dataDic = [NSMutableDictionary dictionary];
    }
    return _dataDic;
}
                      
@end


@implementation CustomNotificationModel


@end
