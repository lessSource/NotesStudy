//
//  AppDelegate+PushNotification.m
//  NotesStudy
//
//  Created by Lj on 2018/4/17.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "AppDelegate+PushNotification.h"


@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate (PushNotification)

- (void)pushNotificationAuthorization:(UIApplication *)application {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
        //必须写代理，不然无法监听通知的接收与点击事件
        notificationCenter.delegate = self;
        [notificationCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.authorizationStatus == UNAuthorizationStatusNotDetermined) {
                NSLog(@"尚未选择");
                [notificationCenter requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
                    if (granted) {
                        NSLog(@"允许通知");
                    }else {
                        NSLog(@"禁止通知");
                    }
                }];
            }else if (settings.authorizationStatus == UNAuthorizationStatusDenied) {
                NSLog(@"用户拒绝");
            }else {
                NSLog(@"用户允许");
            }
        }];
    }else if (@available(iOS 8.0, *)) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound) categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
    //注册远端消息通知获取device token
    [application registerForRemoteNotifications];
}

#pragma mark - iOS10收到通知 （本地和远端）
//App处于前端接收通知时(只会app处于前台状态才会走、后台模式不会走)
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler  API_AVAILABLE(ios(10.0)){
    //推送的请求
    UNNotificationRequest *request = notification.request;
    //推送的内容
    UNNotificationContent *content = request.content;
    //用户基本信息
    NSDictionary *userInfo = content.userInfo;
    //推送消息角标
    NSNumber *bodge = content.badge;
    //消息body
    NSString *body = content.body;
    //消息声音
    UNNotificationSound *sound = content.sound;
    //消息副标题
    NSString *subtitle = content.subtitle;
    //消息标题
    NSString *title = content.title;
    if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //远程通知
        NSLog(@"iOS10 收到远程通知：%@",userInfo);
    }else {
        //本地通知
        NSLog(@"iOS10 收到本地通知(前台)：body: %@ title: %@ subtitle: %@ badge: %@ sound: %@ userInfo: %@",body,title,subtitle,bodge,sound,userInfo);
    }
    //选择是否提醒用户，有Badge、Sound、Alert
    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound);
}

//App通知的点击事件(只会是用户点击消息才会触发，如果用户长按（3DTouch）、弹出Action页面等不会触发。点击Action的时候会触发)
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    //点击或输入action
    NSString *actionIdentifierStr = response.actionIdentifier;
    if ([response isKindOfClass:[UNTextInputNotificationResponse class]]) {
        NSString *userSayStr = [(UNTextInputNotificationResponse *)response userText];
        NSLog(@"action_identifiew----%@、action_text-----%@",actionIdentifierStr,userSayStr);
    }else {
        if ([actionIdentifierStr isEqualToString:@"action.join"]) {
            NSLog(@"actionid----%@",actionIdentifierStr);
        }
    }
    
    //推动的请求
    UNNotificationRequest *request = response.notification.request;
    //推送的内容
    UNNotificationContent *content = request.content;
    //用户基本信息
    NSDictionary *userInfo = content.userInfo;
    //推送消息角标
    NSNumber *bodge = content.badge;
    //消息body
    NSString *body = content.body;
    //消息声音
    UNNotificationSound *sound = content.sound;
    //消息副标题
    NSString *subtitle = content.subtitle;
    //消息标题
    NSString *title = content.title;
    if ([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //远程通知
        NSLog(@"iOS10 收到远程通知：%@",userInfo);
    }else {
        //本地通知
        NSLog(@"iOS10 收到本地通知（点击）：body: %@ title: %@ subtitle: %@ badge: %@ sound: %@ userInfo: %@",body,title,subtitle,bodge,sound,userInfo);
    }
    completionHandler();
}

#pragma mark - iOS10 之前收到通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"iOS7及以上系统，收到通知：%@",userInfo);
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark - 获取device Token
//获取DeviceToken成功
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *deviceString = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    deviceString = [deviceString stringByReplacingOccurrencesOfString:@" " withString:@""];
}

//获取DeviceToken失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"error -- %@",error.description);
}

@end

