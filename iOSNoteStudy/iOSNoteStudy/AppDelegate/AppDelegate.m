//
//  AppDelegate.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/4/17.
//  Copyright © 2018年 lj. All rights reserved.
//



#import "AppDelegate.h"
#if defined(DEBUG) || defined(_DEBUG)
#import <FHHFPSIndicator/FHHFPSIndicator.h>
#endif

#import "BaseNavigationController.h"
#import "BaseTabBarController.h"
#import "AppDelegate+PushNotification.h"
#import "ContactDataObject.h"
#import "UIViewController+Category.h"

@interface AppDelegate ()
@property (nonatomic, strong) BaseTabBarController *tabBarController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    [self pushNotificationAuthorization:application];
    [self gotoMain];
    
    [[ContactDataObject shareInstance]createDataBase];
    
#if defined(DEBUG) || defined(_DEBUG)
    [[FHHFPSIndicator sharedFPSIndicator] show];
#endif
    
    //登录成功
    UIViewController *topmostVC = [UIViewController topViewController];
    SEL selector = NSSelectorFromString(@"LViewOverloadingData");
    if ([topmostVC respondsToSelector:selector]) {
        ((void (*)(id , SEL))[topmostVC methodForSelector:selector])(topmostVC, selector);
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
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[ContactDataObject shareInstance] closeData];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)gotoMain {
    self.tabBarController = [[BaseTabBarController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:self.tabBarController];
    [nav setNavigationBarHidden:YES];
    self.window.rootViewController = nav;
}


@end
