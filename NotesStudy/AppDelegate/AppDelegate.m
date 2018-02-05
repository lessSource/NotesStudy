//
//  AppDelegate.m
//  NotesStudy
//
//  Created by Lj on 2018/1/27.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "NotesStudy-Swift.h"
#import "BaseViewController.h"
#import "BaseTabBarController.h"
#import "BaseNavigationController.h"

@interface AppDelegate ()
@property (nonatomic, strong) BaseTabBarController *tabBarController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    LoginViewController *LoginVc = [[LoginViewController alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:LoginVc];
//    self.window.rootViewController = nav;
//    [self.window makeKeyWindow];
    
    [self gotoLogin];
    
    //设置通知的类可以为弹框提示,声音提示，应用图标数字提示
    UIUserNotificationSettings *notiSetting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
    //授权通知
    [[UIApplication sharedApplication] registerUserNotificationSettings:notiSetting];
    
    UILocalNotification *note = launchOptions[UIApplicationLaunchOptionsLocationKey];
    if (note) {
        //程序不在后台运行
        NSLog(@"点击本地通知启动的程序");
    }else {
        NSLog(@"直接点击app图标启动的程序");
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    //设置应用程序图标右上角的数字
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//当用户点击本地通知进入app的时候调用（通知发出的时候app在后台）
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    //程序在前台运行，直接返回
    if (application.applicationState == UIApplicationStateActive) return;
    //
    NSLog(@"相应操作");
    
}

- (void)gotoLogin {
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    self.window.rootViewController = nav;
}

- (void)gotoMian {
    self.tabBarController = [[BaseTabBarController alloc] init];

    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:self.tabBarController];
    [nav setNavigationBarHidden:YES];
    self.window.backgroundColor = MAIN_COLOR;
    self.window.rootViewController = nav;
}


@end
