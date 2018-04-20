//
//  UIColor+Category.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/4/18.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "UIColor+Category.h"

@implementation UIColor (Category)

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    unsigned rgbValue = 0;
    //扫描hexString 字符串
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    //设置开始扫描的位置 Bypass '#' character
    [scanner setScanLocation:1];
    //可选前缀 '0x' 或 '0X'
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:alpha];
}

/** 导航栏起始颜色 */
+ (UIColor *)navigationStartColor {
    return [self colorWithHexString:@"#FF465D" alpha:1.0];
}

/** 导航栏终止颜色 */
+ (UIColor *)navigationEndColor {
    return [self colorWithHexString:@"#FB6C2A" alpha:1.0];
}

/** tabBar点击时颜色 */
+ (UIColor *)tabBarSelectColor {
    return [self mainColor];
}

/** tabBar未点击时颜色 */
+ (UIColor *)tabBarNormalColor {
    return [self colorWithHexString:@"#aaaaaa" alpha:1.0];
}

/** 主色 */
+ (UIColor *)mainColor {
    return [self colorWithHexString:@"#FB6C2A" alpha:1.0];
}

/** 背景色 */
+ (UIColor *)mainBackgroundColor {
    return [UIColor groupTableViewBackgroundColor];
}

/** 随机颜色 */
+ (UIColor *)randomColor {
    return [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:arc4random_uniform(256)/255.0];
}

@end
