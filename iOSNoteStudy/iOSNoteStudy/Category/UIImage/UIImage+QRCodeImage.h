//
//  UIImage+QRCodeImage.h
//  Community
//
//  Created by Lj on 2017/8/9.
//  Copyright © 2017年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QRCodeImage)

/**
 * 生成一个二维码
 * @param string 字符串
 * @param width 二维码宽度
 */

+ (UIImage *_Nonnull)codeImageWithString:(NSString *_Nonnull)string sizeWidth:(CGFloat)width;


/**
 * 生成一个二维码
 * @param string 字符串
 * @param width 二维码宽度
 * @param color 二维码颜色
 */

+ (UIImage *_Nonnull)codeImageWithString:(NSString *_Nonnull)string sizeWidth:(CGFloat)width qrColor:(UIColor *_Nonnull)color;


/**
 *  3.生成一个二维码
 *
 *  @param string    字符串
 *  @param width     二维码宽度
 *  @param color     二维码颜色
 *  @param icon      头像
 *
 */
+ (UIImage *_Nonnull)codeImageWithString:(NSString *_Nullable)string
                                        sizeWidth:(CGFloat)width
                                       qrColor:(UIColor *_Nullable)color
                                    iconImage:(UIImage *_Nullable)icon;


/// 返回一张不超过屏幕尺寸的 image
+ (UIImage *_Nonnull)imageSizeWithScreenImage:(UIImage *_Nonnull)image;



@end
