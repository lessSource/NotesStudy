//
//  PermissionsObject.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/4/20.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "PermissionsObject.h"
#import <Photos/Photos.h>
#import <CoreLocation/CoreLocation.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <ContactsUI/ContactsUI.h>
#endif
#import <AddressBook/AddressBook.h>

static PermissionsObject *permissionsObject;

@implementation PermissionsObject

+ (void)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (permissionsObject) {
            permissionsObject = [[PermissionsObject alloc]init];
        }
    });
}

- (id)init {
    if (self = [super init]) {
    }
    return self;
}

//相册权限
- (void)photoAlbumPermissions:(void(^)(BOOL, NSString *message))success {
    PHAuthorizationStatus photoAuthorStatus = [PHPhotoLibrary authorizationStatus];
    switch (photoAuthorStatus) {
        case PHAuthorizationStatusAuthorized:
            success(YES, @"允许授权");
            break;
        case PHAuthorizationStatusDenied:
            success(NO, @"拒绝授权");
            break;
        case PHAuthorizationStatusNotDetermined:
            [self _requestPhotoAuthorization:success];
            break;
        case PHAuthorizationStatusRestricted:
            success(NO, @"限制授权");
            break;
        default:
            break;
    }
}

//麦克风、相机权限
- (void)cameraOrMicrophonePermissions:(void(^)(BOOL, NSString *message))success mediaType:(AVMediaType)mediaType {
    AVAuthorizationStatus authorizationStatas = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    switch (authorizationStatas) {
        case AVAuthorizationStatusAuthorized:
            success(YES, @"允许授权");
            break;
        case AVAuthorizationStatusDenied:
            success(NO, @"禁止授权");
            break;
        case AVAuthorizationStatusNotDetermined:
            [self _requestCameraOrMicrophoneAuthorization:success mediaType:mediaType];
            break;
        case AVAuthorizationStatusRestricted:
            success(NO, @"限制授权");
            break;
        default:
            break;
    }
}

// 通讯录授权
- (void)addressBookPermissions:(void(^)(BOOL, NSString *message))success {
    if (@available(iOS 9.0, *)) {
        CNAuthorizationStatus authorizationStatas = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        switch (authorizationStatas) {
            case CNAuthorizationStatusAuthorized:
                success(YES, @"允许授权");
                break;
            case CNAuthorizationStatusDenied:
                success(NO, @"禁止授权");
                break;
            case CNAuthorizationStatusNotDetermined:
                [self _requestAddressBookAuthorization:success];
                break;
            case CNAuthorizationStatusRestricted:
                success(NO, @"限制授权");
                break;
            default:
                break;
        }
        
    }else if (@available(iOS 8.0, *)) {
        /*
        ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
        __block ABAddressBookRef *addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        if (addressBook == NULL) {
            return;
        }
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            if (granted) {
                NSLog(@"");
            }else {
                
            }
            if (addressBook) {
                CFRelease(addressBook);
            }
        });
        */
    }
}

/** 定位权限 */
- (void)locationPermissions:(void(^)(BOOL, NSString *message))success {
    //    kCLAuthorizationStatusNotDetermined        用户尚未做出选择
    //    kCLAuthorizationStatusRestricted           定位权限被限制
    //    kCLAuthorizationStatusAuthorizedAlways     一直允许定位
    //    kCLAuthorizationStatusAuthorizedWhenInUse  在使用时允许定位
    //    kCLAuthorizationStatusDenied               拒绝获取定位
    
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)) {
        success(YES, @"允许授权");
    }else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        NSLog(@"禁止授权");
    }
}

//相册权限回调
- (void)_requestPhotoAuthorization:(void(^)(BOOL, NSString *message))success {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            success(YES, @"允许授权");
        }else {
            success(NO, @"拒绝授权");
        }
    }];
}

//麦克风、相机权限回调
- (void)_requestCameraOrMicrophoneAuthorization:(void(^)(BOOL, NSString *message))success mediaType:(AVMediaType)mediaType {
    [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
        if (granted) {
            success(YES, @"允许授权");
        }else {
            success(NO, @"拒绝授权");
        }
    }];
}

//通讯录权限回调
- (void)_requestAddressBookAuthorization:(void(^)(BOOL, NSString *message))success API_AVAILABLE(ios(9.0)) {
    CNContactStore *contactStore = [[CNContactStore alloc]init];
    [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            success(YES, @"允许授权");
        }else {
            success(NO, @"禁止授权");
        }
    }];
}


- (void)_pushSystemSetupInterface {
    //跳转到系统的设置界面
    //    NSURL *url = [NSURL URLWithString:@"Prefs:root=Privacy&path=LOCATTON"];
    //    Class appLicationWorkspace = NSClassFromString(@"appLicationWorkspace");
    //    [[appLicationWorkspace performSelector:@selector(defaultWorkspace)] performSelector:@selector(application:openURL:options:) withObject:url withObject:nil];
    //需要添加URL Scheme, 方法：Target -> Info -> URL Types，点击“+”，将URL Schemes设置为Prefs即可。
    
    /*
     - (id)performSelector:(SEL)aSelector;
     - (id)performSelector:(SEL)aSelector withObject:(id)object
     - (id)performSelector:(SEL)aSelector withObject:(id)object1 withObject:(id)object2
     */
    //三个方法同步执行，与线程无关，在需要动态的去调用方法的时候去使用
    //    [self performSelector:@selector(configUI)]; 与[self configUI] 效果相同
    //    withObject:(id)object 需要传的参数
    
    /*
     - (void)performSelector:(SEL)aSelector withObject:(nullable id)anArgument afterDelay:(NSTimeInterval)delay inModes:(NSArray<NSString *> *)modes;
     - (void)performSelector:(SEL)aSelector withObject:(nullable id)anArgument afterDelay:(NSTimeInterval)delay;
     */
    //这两个方法为异步执行，只能在主线程执行，可用于点击UI中一个按钮会触发一个消耗性能的事件，在事件执行期间按钮会一直处于高亮状态。此时可以调用该方法去异步的处理该事件
    
    
    //在方法未执行时间之前，取消方法
    /*
     + (void)cancelPreviousPerformRequestsWithTarget:(id)aTarget selector:(SEL)aSelector object:(nullable id)anArgument;
     + (void)cancelPreviousPerformRequestsWithTarget:(id)aTarget;
     */
    //调用该方法之前或在该方法所在的viewController生命周期结束的时候去调用取消函数，以确保不会引起内存泄漏
    
    //3.
    /*
     - (void)performSelectorOnMainThread:(SEL)aSelector withObject:(nullable id)arg waitUntilDone:(BOOL)wait modes:(nullable NSArray<NSString *> *)array;
     
     - (void)performSelectorOnMainThread:(SEL)aSelector withObject:(nullable id)arg waitUntilDone:(BOOL)wait;
     */
    //这两个方法，在主线程和子线程中均可执行，均会调用主线程的aSelector方法
    //如果设置wait为YES；等待当前线程执行完以后，主线程才会执行aSelector方法
    //如果设置为NO；不等待当前线程执行完。就在主线程执行aSelector方法
    //如果当前线程为主线程。那么aSelector方法马上执行
    //注意：apple不允许程序员在主线程以外的线程中对UI进行操作，此时我们必须调用performSelectorOnMainThread函数在主线程完成UI的跟新
    
    /**
     * 4
     
     - (void)performSelector:(SEL)aSelector onThread:(NSThread *)thr withObject:(nullable id)arg waitUntilDone:(BOOL)wait modes:(nullable NSArray<NSString *> *)array NS_AVAILABLE(10_5, 2_0);
     
     - (void)performSelector:(SEL)aSelector onThread:(NSThread *)thr withObject:(nullable id)arg waitUntilDone:(BOOL)wait NS_AVAILABLE(10_5, 2_0);
     */
    //在指定的线程中调用方法
    
    /**
     - (void)performSelectorInBackground:(SEL)aSelector withObject:(nullable id)arg NS_AVAILABLE(10_5, 2_0);
     */
    //后台执行
    
}


@end












