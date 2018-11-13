//
//  UIImage+Category.h
//  NotesStudy
//
//  Created by Lj on 2018/4/16.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)

/** view生成image */
+ (UIImage *)convertViewToImage:(UIView *)view;

/** 生成渐变色image */
+ (UIImage *)convertGradientToImage:(UIView *)view;

/** color生成image */
+ (UIImage *)convertColorToImage:(UIColor *)color;

/** 设置图片不透明度 */
+ (UIImage *)imageByAppleingImage:(UIImage *)image alpha:(CGFloat)alpha;

/** 修改图片尺寸（等比） */
+ (UIImage *)imageResize:(UIImage *)image resizeTo:(CGSize)newSize;

/** 保存图片到相册 */
- (void)loadImageSave:(void(^)(BOOL saveSuccess, BOOL createSuccess))successBlock;

@end
