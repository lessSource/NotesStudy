//
//  LSAlertUtil.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/29.
//  Copyright © 2018年 lj. All rights reserved.
//


#import "LSAlertUtil.h"
#import <MBProgressHUD/MBProgressHUD.h>

/** 默认简短提示语显示的时间 */
static CGFloat const showTime = 1.0f;
/** 默认超时时间，30s后自动去除提示框 */
static NSTimeInterval const interval = 30.0f;

static LSAlertUtil *_alertUtil;

@interface LSAlertUtil ()
@property (nonatomic, strong) MBProgressHUD *loadingHUD;
@property (nonatomic, strong) MBProgressHUD *prompptHUD;

@end


@implementation LSAlertUtil

+ (id)alertManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_alertUtil == nil) {
            _alertUtil = [[LSAlertUtil alloc]init];
        }
    });
    return _alertUtil;
}

#pragma mark - Public
/** 提示语 */
- (void)showPromptInfo:(NSString *)info {
    [self showPromptInfo:info inView:nil];
}

- (void)showPromptInfo:(NSString *)info inView:(UIView *)view {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.prompptHUD == nil) {
            self.prompptHUD = [MBProgressHUD showHUDAddedTo:(view == nil) ? [self _topView] : view animated:YES];
        }
        self.prompptHUD.label.text = info;
        self.prompptHUD.label.numberOfLines = 0;
        self.prompptHUD.animationType = MBProgressHUDAnimationZoom;
        self.prompptHUD.mode = MBProgressHUDModeText;
        self.prompptHUD.removeFromSuperViewOnHide = YES;
        [self.prompptHUD hideAnimated:YES afterDelay:showTime];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(showTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.prompptHUD = nil;
        });
    });
}

/** 显示loading */
- (void)showLoading {
    [self showLoadinginView:nil];
}

- (void)showLoadinginView:(UIView *)view {
    if (self.loadingHUD == nil) {
        self.loadingHUD = [[MBProgressHUD alloc]initWithView:(view == nil) ? [self _topView] : view];
    }
    self.loadingHUD.removeFromSuperViewOnHide = YES;
    self.loadingHUD.label.text = nil;
    if (view) {
        [view addSubview:self.loadingHUD];
        [view bringSubviewToFront:self.loadingHUD];
    }else {
        [[self _topView] addSubview:self.loadingHUD];
        [[self _topView] addSubview:self.loadingHUD];
    }
    [self.loadingHUD showAnimated:YES];
}

/** 隐藏loading */
- (void)hiddenLoading {
    [self.loadingHUD hideAnimated:YES];
    self.loadingHUD = nil;
}


#pragma mark - private
//获取view上的hud
- (MBProgressHUD *)_hudForView:(UIView *)view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subView in subviewsEnum) {
        if ([subView isKindOfClass:[MBProgressHUD class]]) {
            return (MBProgressHUD *)subView;
        }
    }
    return nil;
}

//超时后自动隐藏
- (void)_hideAlertDelay {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hiddenLoading];
    });
}

//返回最上层View
- (UIView *)_topView {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    return window;
}

@end

