//
//  UIView+Category.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/9.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)

- (UIViewController *)viewController {
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

@end
