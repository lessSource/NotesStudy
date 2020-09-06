//
//  CustomNotice.h
//  iOSNoteStudy
//
//  Created by L j on 2020/7/25.
//  Copyright © 2020 lj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomNotice.h"


NS_ASSUME_NONNULL_BEGIN


@interface CustomNotice : NSObject

+ (instancetype)share;

- (void)addObserver:(nonnull id)observer selector:(nonnull SEL)selector name:(NSString *)name;

- (void)postNotification:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
