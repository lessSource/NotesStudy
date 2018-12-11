//
//  MoreViewController.m
//  iOSNoteStudy
//
//  Created by less on 2018/12/11.
//  Copyright © 2018 lj. All rights reserved.
//

#define TabBarItem_FontSize 10.0


#import "MoreViewController.h"
#import "MoreMineViewController.h"
#import "MoreHomeViewController.h"
#import "BaseNavigationController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

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
    UIViewController *homePageVC = [self createController:[MoreMineViewController new] norImage:@"icon_norHomePage" selImage:@"icon_selHomePage" title:@"首页"];
    
    UIViewController *mainVC = [self createController:[MoreHomeViewController new] norImage:@"icon_norHomePage" selImage:@"icon_selHomePage" title:@"我的"];
    
    self.viewControllers = @[homePageVC, mainVC];
    
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

- (UIViewController *)createController:(UIViewController *)controller norImage:(NSString *)norStr selImage:(NSString *)selStr title:(NSString *)title {
//    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:controller];
    controller.tabBarItem = [MoreViewController createTabBarItemTitle:title forNorImage:[UIImage imageNamed:norStr] forSelectImage:[UIImage imageNamed:selStr]];
    [controller.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor tabBarNormalColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:10],NSFontAttributeName, nil] forState:UIControlStateNormal];
    [controller.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor tabBarSelectColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    return controller;
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
