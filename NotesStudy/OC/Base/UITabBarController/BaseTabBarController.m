//
//  BaseTabBarController.m
//  NotesStudy
//
//  Created by Lj on 2018/1/31.
//  Copyright © 2018年 lj. All rights reserved.
//

#define TabBarItem_FontSize 10.0


#import "BaseTabBarController.h"
#import "HomeViewController.h"
#import "MineViewController.h"
#import "BaseNavigationController.h"
#import "ReleaseViewController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initControllers];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initControllers {
    UIViewController *homePageVC = [self createController:[HomeViewController new] normalImg:@"" selectImg:@"" title:@"首页"];
    
    UIViewController *releaseVC = [self createController:[ReleaseViewController new] normalImg:@"icon_Release" selectImg:@"icon_Release" title:nil];
    
    UIViewController *personalVC = [self createController:[MineViewController new] normalImg:@"" selectImg:@"" title:@"我"];

    self.viewControllers = @[homePageVC,releaseVC,personalVC];
    
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [UITabBar appearance].translucent = NO;
    
    CGRect rect = CGRectMake(0, 0, kScreenWidth, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setShadowImage:img];
    [self.tabBar setBackgroundImage:img];
    
    
}

- (UIViewController *)createController:(UIViewController *)controller normalImg:(NSString *)normalImg selectImg:(NSString *)selectImg title:(NSString *)title {
    UINavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:controller];
    nav.tabBarItem = [BaseTabBarController createTabbarItemTitle:title ForImage:[UIImage imageNamed:normalImg] ForSelectImage:[UIImage imageNamed:selectImg]];
//    [nav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:TabBar_NormalColor,NSForegroundColorAttributeName,[UIFont systemFontOfSize:TabBarItem_FontSize],NSFontAttributeName, nil]forState:UIControlStateNormal];
//    [nav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:TabBar_SelectColor,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    return nav;
}

#pragma mark - class method
+ (UITabBarItem *)createTabbarItemTitle:(NSString *)title ForImage:(UIImage *)image {
    UIImage *oImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:oImage tag:0];
    
    return item;
}

+ (UITabBarItem *)createTabbarItemTitle:(NSString *)title ForImage:(UIImage *)image ForSelectImage:(UIImage *)sImage {
    UIImage *oImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *osImage = [sImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:oImage selectedImage:osImage];
    //    item.badgeValue = @"3";
    if (@available(iOS 10.0, *)) {
//        [item setBadgeColor:[UIColor colorWithHexString:@"FF4A3E"]];
    } else {
        // Fallback on earlier versions
    }
    item.titlePositionAdjustment = UIOffsetMake(0, - 3);
    if (title == nil) {
        CGFloat offset = 5.0;
        item.imageInsets = UIEdgeInsetsMake(offset, 0, - offset, 0);
    }
    return item;
}
@end
