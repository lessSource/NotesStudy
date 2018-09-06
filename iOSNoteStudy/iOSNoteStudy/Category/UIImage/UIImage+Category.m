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


/** 生成渐变色image */
+ (UIImage *)convertGradientToImage:(UIView *)view {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor navigationStartColor].CGColor, (__bridge id)[UIColor navigationEndColor].CGColor];
    gradientLayer.locations = @[@0.1,@1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0.0);
    gradientLayer.frame = view.bounds;
    [view.layer insertSublayer:gradientLayer above:gradientLayer];
    UIImage *image = [self convertViewToImage:view];
    return image;
}

/** color生成image */
+ (UIImage *)convertColorToImage:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 10.0f, 10.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/** 设置图片不透明度 */
+ (UIImage *)imageByAppleingImage:(UIImage *)image alpha:(CGFloat)alpha {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, - area.size.height);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    CGContextDrawImage(ctx, area, image.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)imageResize:(UIImage *)image resizeTo:(CGSize)newSize {
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGSize size = image.size;
    CGFloat height = (kScreenWidth - 30) * size.height / size.width;
    newSize = CGSizeMake(kScreenWidth - 30, height);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
