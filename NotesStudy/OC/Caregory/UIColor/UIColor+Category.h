//
//  UIColor+Category.h
//  NotesStudy
//
//  Created by Lj on 2018/2/3.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)

/**
 * 16
 * @param hexString 颜色字符串
 *
 * @return UIColor
 */
+ (nullable UIColor *)colorWithHexString:(NSString *_Nullable)hexString alpha:(CGFloat)alpha;
/** 主色 */
+ (nonnull UIColor *)mainColor;
/** 背景色 */
+ (nonnull UIColor *)mainBackColor;
/** 边框颜色 */
+ (nonnull UIColor *)boderLineColor;
/** 分割线颜色 */
+ (nonnull UIColor *)dividingLineColor;
/** 随机颜色 */
+ (nonnull UIColor *)randomColor;
/** 点缀色 */
+ (nonnull UIColor *)ornamentColor;


#pragma mark - 按钮颜色
/** button不能点击时颜色 */
+ (nonnull UIColor *)buttonNoSelectColor;

#pragma mark - 字体颜色
+ (nonnull UIColor *)textColor35343D;
+ (nonnull UIColor *)textColor706E80;
+ (nonnull UIColor *)textColor9B99A9;


@end
