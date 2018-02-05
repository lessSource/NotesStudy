//
//  UIColor+Category.m
//  NotesStudy
//
//  Created by Lj on 2018/2/3.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "UIColor+Category.h"

@implementation UIColor (Category)

+ (nullable UIColor *)colorWithHexString:(NSString *_Nullable)hexString alpha:(CGFloat)alpha {
    unsigned rgbValue = 0;
    //扫描hexString 字符串
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    //设置开始扫描的位置 Bypass '#' character
    [scanner setScanLocation:1];
    //Optionally prefixed with "0x" or "0X
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:alpha];
}

// 主色
+ (nonnull UIColor *)mainColor {
    return [self colorWithHexString:@"#20C99E" alpha:1.0];
}

// 背景色
+ (nonnull UIColor *)mainBackColor {
    return [self colorWithHexString:@"#F6F6FA" alpha:1.0];
}

//边框颜色
+ (nonnull UIColor *)boderLineColor {
    return [self colorWithHexString:@"#CCCCCC" alpha:1.0];
}

// 分割线颜色
+ (nonnull UIColor *)dividingLineColor {
    return [self colorWithHexString:@"#DDDDDD" alpha:1.0];
}

+ (nonnull UIColor *)randomColor {
    return [self colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0  blue:arc4random_uniform(256)/255.0  alpha:1.0];
}

+ (nonnull UIColor *)ornamentColor {
    return [self colorWithHexString:@"#FD7837" alpha:1.0];
}

#pragma mark - 按钮颜色
// button不能点击时颜色
+ (nonnull UIColor *)buttonNoSelectColor {
    return [self colorWithHexString:@"#C7C7CD" alpha:1.0];
}

#pragma mark - 字体颜色
+ (nonnull UIColor *)textColor35343D {
    return [self colorWithHexString:@"35343D" alpha:1.0];
}

+ (nonnull UIColor *)textColor706E80 {
    return [self colorWithHexString:@"706E80" alpha:1.0];
}

+ (nonnull UIColor *)textColor9B99A9 {
    return [self colorWithHexString:@"706E80" alpha:1.0];
}



@end
