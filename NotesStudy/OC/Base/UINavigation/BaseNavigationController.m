//
//  BaseNavigationController.m
//  NotesStudy
//
//  Created by Lj on 2018/1/31.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()
@property (strong, nonatomic) UIView *barBackgroundView;

@end

@implementation BaseNavigationController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.translucent = YES;
    
    self.barBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, - kStatusHeight, self.view.frame.size.width, kNavbarAndStatusBar)];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    UIColor *color1= [UIColor colorWithRed:255.0/255.0 green:70.0/255.0 blue:93.0/255.0 alpha:1.0];
    UIColor *color2 = [UIColor colorWithRed:251.0/255.0 green:108.0/255.0 blue:42.0/255.0 alpha:1.0];
    gradientLayer.colors = @[(__bridge id)color1.CGColor, (__bridge id)color2.CGColor];
    gradientLayer.locations = @[@0.5, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, kNavbarAndStatusBar);
    [self.barBackgroundView.layer insertSublayer:gradientLayer above:gradientLayer];
    
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setBarTintColor:[UIColor clearColor]];

    self.navigationBar.topItem.title = @"";
    
    //这个是去除下面的黑线
    [self.navigationBar setShadowImage:[UIImage new]];  
    
    //对navigationbar透明
    [self.navigationBar setBackgroundImage:[UIImage convertViewToImage:self.barBackgroundView] forBarMetrics:UIBarMetricsDefault];
    
    //navigationBar image
    //    CGRect rect = CGRectMake(0, 0, kScreenWidth, 10);
    //    UIGraphicsBeginImageContext(rect.size);
    //    CGContextRef content = UIGraphicsGetCurrentContext();
    //    CGContextSetFillColorWithColor(content, [UIColor redColor].CGColor);
    //    CGContextFillRect(content, rect);
    //    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    //    [self.navigationController.navigationBar setShadowImage:img];
    //    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
