//
//  BaseTabBarController.m
//  NotesStudy
//
//  Created by Lj on 2018/4/16.
//  Copyright © 2018年 lj. All rights reserved.
//

#define TabBarItem_FontSize 10.0

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "LSGlobleUtil.h"
#import "HomePageViewController.h"
#import "MineViewController.h"
#import "GitHubViewController.h"
#import "MessageViewController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (instancetype)init {
    if (self = [super init]) {
        [self initControllers];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initControllers {
    UIViewController *homePageVC = [self createController:[HomePageViewController new] norImage:@"icon_norHomePage" selImage:@"icon_selHomePage" title:@"首页"];
    
    UIViewController *functionVC = [self createController:[GitHubViewController new] norImage:@"icon_norHomePage" selImage:@"icon_selHomePage" title:@"搜索"];

    UIViewController *animationVC = [self createController:[MessageViewController new] norImage:@"icon_norHomePage" selImage:@"icon_selHomePage" title:@"消息"];

    
    UIViewController *mineVC = [self createController:[MineViewController new] norImage:@"icon_norHomePage" selImage:@"icon_selHomePage" title:@"我的"];
    
    self.viewControllers = @[homePageVC, functionVC, animationVC, mineVC];
    
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [UITabBar appearance].translucent = NO;
    CGRect rect = CGRectMake(0, 0, kScreenWidth, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setShadowImage:image];
    [self.tabBar setBackgroundImage:image];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)createController:(UIViewController *)controller norImage:(NSString *)norStr selImage:(NSString *)selStr title:(NSString *)title {
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:controller];
    nav.tabBarItem = [BaseTabBarController createTabBarItemTitle:title forNorImage:[UIImage imageNamed:norStr] forSelectImage:[UIImage imageNamed:selStr]];
    [nav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor tabBarNormalColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:10],NSFontAttributeName, nil] forState:UIControlStateNormal];
    [nav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor tabBarSelectColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    return nav;
}

#pragma mark -
+ (UITabBarItem *)createTabBarItemTitle:(NSString *)title forNorImage:(UIImage *)nImage forSelectImage:(UIImage *)sImage {
    UIImage *norImage = [nImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selImage = [sImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:title image:norImage selectedImage:selImage];
    if (@available(iOS 10.0, *)) {
    }else {
    }
    item.titlePositionAdjustment = UIOffsetMake(0, - 3);
    if (title == nil) {
        CGFloat offSet = 5.0;
        item.imageInsets = UIEdgeInsetsMake(offSet, 0, - offSet, 0);
    }
    return item;
}

@end

