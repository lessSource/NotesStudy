//
//  UIImage+Category.m
//  NotesStudy
//
//  Created by Lj on 2018/4/16.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)

/** view生成image */
+ (UIImage *)convertViewToImage:(UIView *)view {
    CGSize size = view.bounds.size;
    //第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数屏幕密度
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    //把控制器的View的内容画到上下文中
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    //- (void)renderInContext:(CGContextRef)ctx; 该方法为渲染view.layer
    //- (void)drawInContext:(CGContextRef)ctx; 该方法为渲染UIImage
    //从上下文生成一张图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    return image;
}

/** color生成image */
+ (UIImage *)convertColorToImage:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
