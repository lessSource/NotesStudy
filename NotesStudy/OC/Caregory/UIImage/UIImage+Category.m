//
//  UIImage+Category.m
//  NotesStudy
//
//  Created by Lj on 2018/1/28.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)
//根据颜色获取图片
+ (nullable UIImage *)createImageWithColor:(UIColor *)color {
    //图片尺寸
    CGRect rect = CGRectMake(0, 0, 10, 10);
    //填充画笔
    UIGraphicsBeginImageContext(rect.size);
    //根据所传颜色绘制
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    //显示区域
    CGContextFillRect(context, rect);
    // 得到图片信息
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    //消除画笔
    UIGraphicsEndImageContext();
    return image;
}

//设置图片不透明度
+ (nullable UIImage *)imageByApplyingImage:(UIImage *_Nullable)image alpha:(CGFloat)alpha {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    CGContextDrawImage(ctx, area, image.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//view 生成 image
+ (nullable UIImage *)convertViewToImage:(UIView *_Nullable)view {
    CGSize size = view.bounds.size;
    //第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数屏幕密度
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    //把控制器的view的内容画到上下文中
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    //- (void)renderInContext:(CGContextRef)ctx; 该方法为渲染view.layer
    //- (void)drawInContext:(CGContextRef)ctx; 该方法为渲染UIImage
    //从上下文中生成一张图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    return image;
}

@end
