//
//  UIColor+Category.h
//  iOSNoteStudy
//
//  Created by Lj on 2018/4/18.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)

/** 16位
 *  @param hexString 颜色转换字符串
 *  @return UIColor
 */

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

/** 导航栏起始颜色 */
+ (UIColor *)navigationStartColor;

/** 导航栏终止颜色 */
+ (UIColor *)navigationEndColor;

/** tabBar点击时颜色 */
+ (UIColor *)tabBarSelectColor;

/** tabBar未点击时颜色 */
+ (UIColor *)tabBarNormalColor;

/** 主色 */
+ (UIColor *)mainColor;

/** 背景色 */
+ (UIColor *)mainBackgroundColor;

/** 随机颜色 */
+ (UIColor *)randomColor;



@end
