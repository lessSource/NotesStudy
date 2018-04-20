//
//  PermissionsObject.h
//  iOSNoteStudy
//
//  Created by Lj on 2018/4/20.
//  Copyright © 2018年 lj. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface PermissionsObject : NSObject

+ (void)shareInstance;

/** 相册权限 */
- (void)photoAlbumPermissions:(void(^)(BOOL, NSString *message))success;

/** 麦克风、相机权限 */
- (void)cameraOrMicrophonePermissions:(void(^)(BOOL, NSString *message))success mediaType:(AVMediaType)mediaType;

/** 通讯录授权 */
- (void)addressBookPermissions:(void(^)(BOOL, NSString *message))success;

/** 定位权限 */
- (void)locationPermissions:(void(^)(BOOL, NSString *message))success;


@end
