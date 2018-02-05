//
//  UIImage+Category.h
//  NotesStudy
//
//  Created by Lj on 2018/1/28.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)

/** 根据颜色获取图片 */
+ (nullable UIImage *)createImageWithColor:(UIColor *_Nullable)color;
/** 设置图片不透明度 */
+ (nullable UIImage *)imageByApplyingImage:(UIImage *_Nullable)image alpha:(CGFloat)alpha;
/** view 生成 image */
+ (nullable UIImage *)convertViewToImage:(UIView *_Nullable)view;


@end
