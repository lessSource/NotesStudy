//
//  CustomNotice.m
//  iOSNoteStudy
//
//  Created by L j on 2020/7/25.
//  Copyright © 2020 lj. All rights reserved.
//

#import "CustomNotice.h"

@interface CustomNotice()

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) SEL selector;


@end


static CustomNotice *notice;

@implementation CustomNotice

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if (notice == nil) {
                notice = [super allocWithZone:zone];
            }
        });
    return notice;
}

+ (instancetype)share {
        
//    [[NSNotificationCenter defaultCenter] postNotification:@"name"];
    
    return [[self alloc]init];
}

- (void)addObserver:(nonnull id)observer selector:(nonnull SEL)selector name:(NSString *)name {
    self.selector = selector;
    self.dataDic[name] = observer;
}

- (void)postNotification:(NSString *)name {
    id obj = _dataDic[name];
    if (obj != nil) {
        if ([obj isKindOfClass:[UIViewController class]]) {
            UIViewController *controller = (UIViewController *)obj;
            if ([controller respondsToSelector:_selector]) {
                ((void (*)(id , SEL))[controller methodForSelector:_selector])(controller, _selector);
            }
        }
    }
}



- (NSMutableDictionary *)dataDic {
    if (_dataDic == nil) {
        _dataDic = [NSMutableDictionary dictionary];
    }
    return _dataDic;
}


@end
