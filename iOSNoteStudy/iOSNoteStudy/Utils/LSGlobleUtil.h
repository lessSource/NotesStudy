//
//  LSGlobleUtil.h
//  NotesStudy
//
//  Created by Lj on 2018/1/27.
//  Copyright © 2018年 lj. All rights reserved.
//

#ifndef LSGlobleUtil_h
#define LSGlobleUtil_h

#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;

// 颜色方法
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.00 green:G/255.00 blue:B/255.00 alpha:A]

//屏幕尺寸
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define rectStatus  [[UIApplication sharedApplication] statusBarFrame]
#define kStatusHeight           (rectStatus.size.height)
#define kTopBarHeight           (44.f)
#define kNavbarAndStatusBar     (kStatusHeight + kTopBarHeight)
#define kBottomBarHeight        (kDevice_Is_iPhoneX ? 83.f : 49.f)
#define kBarHeight              (kDevice_Is_iPhoneX ? 34.f : 0.f)

#define SizeScale ((kScreenWidth > 320.00) ? kScreenWidth/375.00 : 1)

//是否是Retina屏幕
#define isRetina [UIScreen mainScreen].scale > 1

//设备种类判断
#define isSimulator NSNotFound != [[[UIDevice currentDevice] model] rangeOfString:@"Simulator"].location
#define isIphone UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone
#define isIpad UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//系统版本判断
#define IOS9 [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0

//当前软件版本号
#define BundleShortVersionString [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//由角度转换弧度 由弧度转换角度
#define DegreesToRadian(x) M_PI * (x) / 180.0
#define RadianToDegrees(radian) radian * 180.0 / M_PI

//通知中心
#define NotificationCenter [NSNotificationCenter defaultCenter]


#pragma mark - 字体大小
#define LSFont_Size_9 [UIFont systemFontOfSize:SizeScale *9.0]

#define LSFont_Size_10 [UIFont systemFontOfSize:SizeScale *10.0]

#define LSFont_Size_11 [UIFont systemFontOfSize:SizeScale *11.0]

#define LSFont_Size_12 [UIFont systemFontOfSize:SizeScale *12.0]

#define LSFont_Size_13 [UIFont systemFontOfSize:SizeScale *13.0]

#define LSFont_Size_14 [UIFont systemFontOfSize:SizeScale *14.0]

#define LSFont_Size_15 [UIFont systemFontOfSize:SizeScale *15.0]

#define LSFont_Size_16 [UIFont systemFontOfSize:SizeScale *16.0]

#define LSFont_Size_17 [UIFont systemFontOfSize:SizeScale *17.0]

#define LSFont_Size_18 [UIFont systemFontOfSize:SizeScale *18.0]



/* 快速查询一段代码的执行时间 */
/** 用法
 TICK
 do your work here
 TOCK
 */
#define TICK NSDate *startTime = [NSDate date];
#define TOCK NSLog(@"Time :%f", - [startTime timeIntervalSinceNow]);


#endif /* LSGlobleUtil_h */

//在DEBUG模式下输出NSLog  在release模式下不输出NSLog
#ifndef DEBUG
#undef NSLog
#define NSLog(args,...)
#endif

