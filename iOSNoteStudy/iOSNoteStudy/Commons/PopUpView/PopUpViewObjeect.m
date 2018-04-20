//
//  PopUpViewObjeect.m
//  NotesStudy
//
//  Created by Lj on 2018/3/16.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "PopUpViewObjeect.h"

@interface PopUpViewObjeect ()
@property (nonatomic, strong) UIView *subBackView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) ContentView *contentView;
@property (nonatomic, assign) PopUpViewDirectionType directionType;

@end

static PopUpViewObjeect *popUpViewObject;

@implementation PopUpViewObjeect

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if (popUpViewObject == nil) {
                popUpViewObject = [super allocWithZone:zone];
                [popUpViewObject setUpUI];
            }
        });
    return popUpViewObject;
}

+ (instancetype)sharrPopUpView {
    return [[self alloc]init];
}

- (void)setUpUI {
    self.subBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    self.maskView = [[UIView alloc]initWithFrame:self.subBackView.bounds];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0;
    //背景点击事件
    UITapGestureRecognizer *tapGester = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backViewClick)];
    tapGester.numberOfTapsRequired = 1;
    [self.maskView addGestureRecognizer:tapGester];
    
    //拖动事件
    //    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc]init];
    //    [panRecognizer addTarget:self action:@selector(panClick:)];
    //    [self.maskView addGestureRecognizer:panRecognizer];
    
    [self.subBackView addSubview:self.maskView];
}

- (void)presentContentView:(ContentView *)contentView {
    [self presentContentView:contentView direction:PopUpViewDirectionTypeNone];
}

- (void)presentContentView:(ContentView *)contentView direction:(PopUpViewDirectionType)dircetionType {
    if (!contentView) { return; }
    self.directionType = dircetionType;
    [self.subBackView addSubview:contentView];
    [contentView willShowView];
    _contentView = contentView;
    [UIView animateWithDuration:0.5 animations:^{
        self.contentView.alpha = 1;
        self.maskView.alpha = 0.5;
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:self.subBackView];
    if (dircetionType == PopUpViewDirectionTypeCenter) {
        [_contentView.layer addAnimation:[self _alertViewShowAnimation] forKey:nil];
    }else {
        [self _showAnimation:dircetionType];
    }
}


- (void)cancalContentView:(ContentView *)contentView {
    [self _cancelAnimation:PopUpViewDirectionTypeNone];
}

- (void)cancalContentView:(ContentView *)contentView direction:(PopUpViewDirectionType)dircetionType {
    [self _cancelAnimation:dircetionType];
}

#pragma mark - animation
- (void)_showAnimation:(PopUpViewDirectionType)directionType {
    if (directionType == PopUpViewDirectionTypeNone) {
        self.contentView.transform = CGAffineTransformMakeTranslation(CGFLOAT_MIN, CGRectGetHeight(self.contentView.bounds));
    }else {
        self.contentView.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(self.contentView.bounds), CGFLOAT_MIN);
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.transform = CGAffineTransformMakeTranslation(CGFLOAT_MIN, CGFLOAT_MIN);
    }];
}

- (void)_cancelAnimation:(PopUpViewDirectionType)directionType {
    [_contentView willCancelView];
    [UIView animateWithDuration:0.5 animations:^{
        if (directionType == PopUpViewDirectionTypeRight) {
            self.contentView.transform = CGAffineTransformMakeTranslation(kScreenWidth, CGFLOAT_MIN);
        }else if (directionType == PopUpViewDirectionTypeCenter) {
            
        }else {
            self.contentView.transform = CGAffineTransformMakeTranslation(CGFLOAT_MIN, kScreenHeight);
        }
        self.maskView.alpha = 0.0;
        self.contentView.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (self.contentView) {
            [self.contentView removeFromSuperview];
            self.contentView = nil;
        }
        [self.subBackView removeFromSuperview];
    }];
}

- (CAKeyframeAnimation *)_alertViewShowAnimation {
    CAKeyframeAnimation *alertViewAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    alertViewAnimation.duration = 0.5;
    alertViewAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.2f, 0.2f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DIdentity]];
    alertViewAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    return alertViewAnimation;
}


#pragma mark - 按钮
- (void)backViewClick {
    if (self.directionType == PopUpViewDirectionTypeLeft) {
        [self cancalContentView:_contentView direction:PopUpViewDirectionTypeRight];
    }else {
        [self cancalContentView:_contentView direction:self.directionType];
    }
}

//#pragma mark - UIPanGestureRecognizer(拖动)
//- (void)panClick:(UIPanGestureRecognizer *)gestureRecognizer {
//    //获取拖动按钮的坐标
//    CGPoint point = [gestureRecognizer translationInView:self.contentView];
//    self.contentView.center = CGPointMake(self.contentView.center.x + point.x, self.contentView.center.y);
//    if (self.contentView.center.x <= kScreenWidth - CGRectGetWidth(self.contentView.bounds)/2) {
//        self.contentView.center = CGPointMake(kScreenWidth - CGRectGetWidth(self.contentView.bounds)/2, self.contentView.center.y);
//    }
//    [gestureRecognizer setTranslation:CGPointMake(0, 0) inView:self.contentView];
//
//    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
////        [UIView animateWithDuration:0.3 animations:^{
////            self.contentView.center = CGPointMake(kScreenWidth - CGRectGetWidth(self.contentView.bounds)/2, self.contentView.center.y);
////        }];
//        [self cancalContentView:self.contentView];
//    }
//}


- (void)dealloc {
    NSLog(@"PopUpViewObject--------dealloc");
}

@end

@implementation ContentView

- (void)willShowView { }

- (void)willCancelView { }

- (void)dealloc {
    NSLog(@"ContentView--------dealloc");
}

@end

