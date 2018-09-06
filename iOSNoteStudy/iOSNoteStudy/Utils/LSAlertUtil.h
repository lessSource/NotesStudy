//
//  LSAlertUtil.h
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/29.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSAlertUtil : NSObject

+ (id)alertManager;

/** 提示语 */
- (void)showPromptInfo:(NSString *)info;
- (void)showPromptInfo:(NSString *)info inView:(UIView *)view;

/** 显示loading */
- (void)showLoading;
- (void)showLoadinginView:(UIView *)view;

/** 隐藏loading */
- (void)hiddenLoading;


@end
