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

/** color生成image */
+ (UIImage *)convertColorToImage:(UIColor *)color;

@end
