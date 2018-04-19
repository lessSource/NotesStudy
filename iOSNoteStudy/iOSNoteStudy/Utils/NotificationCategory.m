//
//  NotificationCategory.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/4/18.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "NotificationCategory.h"

@implementation NotificationCategory

+ (void)addNotificationCategories API_AVAILABLE(ios(10.0)) {
    
    /** UNNotificationActionOptions
     *  需要解锁显示，点击不会进app
     *  UNNotificationActionOptionAuthenticationRequired
     *
     *  红色文字 点击不会进app
     *  UNNotificationActionOptionDestructive
     *
     *  黑色文字 点击会进app
     *  UNNotificationActionOptionForeground
     */
    
    //创建Action
    UNNotificationAction *lookAction = [UNNotificationAction actionWithIdentifier:@"action.join" title:@"接收邀请" options:UNNotificationActionOptionAuthenticationRequired];
    UNNotificationAction *joinAction = [UNNotificationAction actionWithIdentifier:@"action.look" title:@"查看邀请" options:UNNotificationActionOptionForeground];
    UNNotificationAction *cancelAction = [UNNotificationAction actionWithIdentifier:@"action.cancel" title:@"取消" options:UNNotificationActionOptionDestructive];
    UNTextInputNotificationAction *inputAction = [UNTextInputNotificationAction actionWithIdentifier:@"action.input" title:@"输入" options:UNNotificationActionOptionForeground textInputButtonTitle:@"发送" textInputPlaceholder:@"tell me loudly"];
    
    //创建category
    UNNotificationCategory *notificationCategory = [UNNotificationCategory categoryWithIdentifier:@"Dely_locationCategory" actions:@[lookAction,joinAction,cancelAction,inputAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    
    //identifire 是category 唯一标识
    //这个id 不管是Local Notification 还是 remote Notification 一定要有并且要保持一致
    //actions 是你创建action的操作数组
    //intentIdentifiers 意图标识符 可在 <Intents/INIntentIdentifiers.h> 中查看，主要是针对电话、carplay等
    UNUserNotificationCenter *notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
    
    [notificationCenter setNotificationCategories:[NSSet setWithObject:notificationCategory]];
}

+ (void)createLocalizedUserNotification:(void(^)(BOOL))success data:(id)data API_AVAILABLE(ios(10.0)) {
    // UNPushNotificationTrigger (远程通知)
    // UNTimeIntervalNotificationTrigger (本地通知) 一定时间之后，重复或者不重复推送通知
    // UNCalendarNotificationTrigger (本地通知) 一定日期之后 重复或者不重复推送
    // UNLocationNotificationTrigger (本地通知) 地理位置的一种通知，当用户进入或者离开一个地理区域来通知
    
    //设置触发条件UNNotificationTrigger
    UNTimeIntervalNotificationTrigger *timeTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10.5 repeats:NO];
    //创建通知内容 UNMutableNotificaionContent
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    content.title = @"Dely 时间提醒 -title";
    content.subtitle = [NSString stringWithFormat:@"时间提醒 -- subtitle"];
    content.body = @"时间提醒 -- body";
    content.badge = @1;
    content.sound = [UNNotificationSound defaultSound];
    content.userInfo = @{@"key1":@"value1",@"key2":@"value2"};
    content.categoryIdentifier = @"Dely_locationCategory";
    //将category 添加到通知中心
    [self addNotificationCategories];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    //创建通知标识
    NSString *requestIdentfire = @"Dely.X.time";
    //创建通知请求 UNNotificationRequest 将触发条件和通知内容添加到请求中
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentfire content:content trigger:timeTrigger];
    
    //将通知请求 add 到 UNUserNotificationCenter
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (!error) success(YES);
        else success(NO);
    }];
}


@end
