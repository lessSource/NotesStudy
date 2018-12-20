//
//  UIImage+QRCodeImage.m
//  Community
//
//  Created by Lj on 2017/8/9.
//  Copyright © 2017年 lj. All rights reserved.
//

#import "UIImage+QRCodeImage.h"

@implementation UIImage (QRCodeImage)

+ (UIImage *)codeImageWithString:(NSString *)string sizeWidth:(CGFloat)width {
    CIImage *ciImage = [UIImage _createQRForString:string];
    if (ciImage) {
        return [UIImage _createNonInterpolatedUIImageFormCIImage:ciImage withSize:width];
    }else {
        return nil;
    }
}


void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}

+ (UIImage *)codeImageWithString:(NSString *)string sizeWidth:(CGFloat)width qrColor:(UIColor *)color {
    UIImage *image = [UIImage codeImageWithString:string sizeWidth:width];
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    CGFloat red     = components[0]*255;
    CGFloat green   = components[1]*255;
    CGFloat blue    = components[2]*255;
    
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900) {
            // 改成下面的代码，会将图片转成想要的颜色
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        }else { // 将白色变成透明
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 255;
        }
    }
    // 输出图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    // 清理空间
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}

+ (UIImage *)codeImageWithString:(NSString *)string sizeWidth:(CGFloat)width qrColor:(UIColor *)color iconImage:(UIImage *)icon {
    UIImage *bgImage = [UIImage codeImageWithString:string sizeWidth:width qrColor:color];
    bgImage = [UIImage _imagewithBgImage:bgImage addLogoImage:icon ofTheSize:width];
    return bgImage;
}

/// 返回一张不超过屏幕尺寸的 image
+ (UIImage *)imageSizeWithScreenImage:(UIImage *)image {
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    if (imageWidth <= kScreenWidth && imageHeight <= kScreenHeight) {
        return image;
    }
    
    CGFloat max = MAX(imageWidth, imageHeight);
    CGFloat scale = max/kScreenHeight;
    CGSize size = CGSizeMake(imageWidth / scale, imageHeight / scale);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - 内部方法
+ (CIImage *)_createQRForString:(NSString *)qrString {
    //实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //恢复滤镜的默认属性
    [filter setDefaults];
    
    //将字符串转化为NSData
    NSData *data = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    //通过KVO设置滤镜inputMessage数据
    [filter setValue:data forKey:@"inputMessage"];
    //纠错级别
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    //获取数据输出的图像
    return  filter.outputImage;
}

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
+ (UIImage *)_createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


/**
 *  二维码添加头像
 *
 *  @param bgImage     背景（二维码）
 *  @param LogoImage  logo
 *  @param width        绘制区域大小
 *
 *  @return newImage
 */
+ (UIImage *)_imagewithBgImage:(UIImage *)bgImage addLogoImage:(UIImage *)LogoImage ofTheSize:(CGFloat)width; {
    if (LogoImage == nil) {
        return bgImage;
    }
    BOOL opaque = 1.0;
    // 获取当前设备的scale
    CGFloat scale = [UIScreen mainScreen].scale;
    // 创建画布Rect
    CGRect bgRect = CGRectMake(0, 0, width, width);
    // 头像大小 _不能大于_ 画布的1/4 （这个大小之内的不会遮挡二维码的有效信息）
    CGFloat avatarWidth = (width/4.0);
    CGFloat avatarHeight = avatarWidth;
    //MARK:-调用一个新的切割绘图方法 crop image add cornerRadius  (裁切头像图片为圆角，并添加bored   返回一个newimage)
    LogoImage = [UIImage _clipCornerRadius:LogoImage withSize:CGSizeMake(avatarWidth, avatarHeight)];
    // 设置头像的位置信息
    CGPoint position = CGPointMake(width/2.0, width/2.0);
    CGRect avatarRect = CGRectMake(position.x-(avatarWidth/2.0), position.y-(avatarHeight/2.0), avatarWidth, avatarHeight);
    
    // 设置画布信息
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, width), opaque, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);{// 开启画布
        // 翻转context （画布）
        CGContextTranslateCTM(context, 0, width);
        CGContextScaleCTM(context, 1, -1);
        // 根据 bgRect 用二维码填充视图
        CGContextDrawImage(context, bgRect, bgImage.CGImage);
        //  根据newLogoImage 填充头像区域
        CGContextDrawImage(context, avatarRect, LogoImage.CGImage);
        
    }CGContextRestoreGState(context);// 提交画布
    // 从画布中提取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 释放画布
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)_clipCornerRadius:(UIImage *)image withSize:(CGSize) size {
    // 白色border的宽度
    CGFloat outerWidth = 5;
    // 黑色border的宽度
    CGFloat innerWidth = outerWidth/10.0;
    // 圆角这个就是我觉着的适合的一个值 ，可以自行改
    CGFloat corenerRadius = size.width/5.0;
    // 为context创建一个区域
    CGRect areaRect = CGRectMake(0, 0, size.width, size.height);
    UIBezierPath *areaPath = [UIBezierPath bezierPathWithRoundedRect:areaRect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(corenerRadius, corenerRadius)];
    
    // 因为UIBezierpath划线是双向扩展的 初始位置就不会是（0，0）
    // origin position
    CGFloat outerOrigin = outerWidth/2.0;
    CGFloat innerOrigin = innerWidth/2.0 + outerOrigin/1.2;
    CGRect outerRect = CGRectInset(areaRect, outerOrigin, outerOrigin);
    CGRect innerRect = CGRectInset(outerRect, innerOrigin, innerOrigin);
    //  外层path
    UIBezierPath *outerPath = [UIBezierPath bezierPathWithRoundedRect:outerRect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(outerRect.size.width/5.0, outerRect.size.width/5.0)];
    // 创建上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);{
        // 翻转context
        CGContextTranslateCTM(context, 0, size.height);
        CGContextScaleCTM(context, 1, -1);
        // context  添加 区域path -> 进行裁切画布
        CGContextAddPath(context, areaPath.CGPath);
        CGContextClip(context);
        // context 添加 背景颜色，避免透明背景会展示后面的二维码不美观的。（当然也可以对想遮住的区域进行clear操作，但是我当时写的时候还没有想到）
        CGContextAddPath(context, areaPath.CGPath);
        //        UIColor *fillColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
        UIColor *fillColor = [UIColor whiteColor];
        CGContextSetFillColorWithColor(context, fillColor.CGColor);
        CGContextFillPath(context);
        // context 执行画头像
        CGContextDrawImage(context, innerRect, image.CGImage);
        // context 添加白色的边框 -> 执行填充白色画笔
        CGContextAddPath(context, outerPath.CGPath);
        //        CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1].CGColor);
        CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextSetLineWidth(context, outerWidth);
        CGContextStrokePath(context);
        // context 添加黑色的边界假象边框 -> 执行填充黑色画笔
        //        CGContextAddPath(context, innerPath.CGPath);
        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextSetLineWidth(context, innerWidth);
        CGContextStrokePath(context);
        
    }CGContextRestoreGState(context);
    UIImage *radiusImage  = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return radiusImage;
}


@end
