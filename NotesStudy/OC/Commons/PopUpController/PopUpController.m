//
//  PopUpController.m
//  NotesStudy
//
//  Created by Lj on 2018/2/5.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "PopUpController.h"

@implementation PopUpController

#pragma mark - present
- (void)presentContentView:(UIView *)contentView {
    
}

- (void)presentContentView:(UIView *)contentView displayTime:(NSTimeInterval)displayTime {
    
}

- (void)presentContentView:(UIView *)contentView duration:(NSTimeInterval)duration springAnimated:(BOOL)isSpringAnimated {
    
}

- (void)presentContentView:(UIView *)contentView
                  duration:(NSTimeInterval)duration
            springAnimated:(BOOL)isSpringAnimated
                    inView:(UIView *)sView {
    
}

- (void)presentContentView:(UIView *)contentView
                  duration:(NSTimeInterval)duration
            springAnimated:(BOOL)isSpringAnimated
                    inView:(UIView *)sView
               displayTime:(NSTimeInterval)displayTime {
//    NSMutableDictionary 
}

- (void)dealloc {
    
}

@end


@implementation UIViewController (PopUpController)

- (PopUpController *)popUpController {
    id popUpVC = objc_getAssociatedObject(self, _cmd);
    if (popUpVC == nil) {
        popUpVC = [[PopUpController alloc]init];
        self.popUpController = popUpVC;
    }
    return popUpVC;
}

- (void)setPopUpController:(PopUpController *)popUpController {
    objc_setAssociatedObject(self, @selector(popUpController), popUpController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


