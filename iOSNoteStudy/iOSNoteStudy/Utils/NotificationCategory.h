//
//  NotificationCategory.h
//  iOSNoteStudy
//
//  Created by Lj on 2018/4/18.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationCategory : NSObject

+ (void)addNotificationCategories API_AVAILABLE(ios(10.0));


+ (void)createLocalizedUserNotification:(void(^)(BOOL))success data:(id)data API_AVAILABLE(ios(10.0));

@end
