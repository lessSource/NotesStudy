//
//  BaseNavigationController.m
//  NotesStudy
//
//  Created by Lj on 2018/4/15.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "BaseNavigationController.h"
#import "LSGlobleUtil.h"
#import "UIImage+Category.h"
#import "UIColor+Category.h"

@interface BaseNavigationController ()
@property (nonatomic, strong) UIView *barBackgroundView;

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.translucent = NO;  //半透明属性
    
    self.barBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, - kStatusHeight, kScreenWidth, kNavbarAndStatusBar)];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    gradientLayer.colors = @[(__bridge id)[UIColor navigationStartColor].CGColor,(__bridge id)[UIColor navigationEndColor].CGColor];
    gradientLayer.locations = @[@0.1,@1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), kNavbarAndStatusBar);
    [self.barBackgroundView.layer insertSublayer:gradientLayer above:gradientLayer];
    
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setBarTintColor:[UIColor clearColor]];
    self.navigationBar.topItem.title = @"";
    //去除下面的黑线
    [self.navigationBar setShadowImage:[UIImage new]];
    //对navigationbar透明
    [self.navigationBar setBackgroundImage:[UIImage convertViewToImage:self.barBackgroundView] forBarMetrics:UIBarMetricsDefault];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    viewController.hidesBottomBarWhenPushed = YES;
//    [super pushViewController:viewController animated:animated];
//}

@end
