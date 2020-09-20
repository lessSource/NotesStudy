//
//  UIImage+Local.h
//  Behing
//
//  Created by 王道道 on 2018/6/22.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Local)

//将图片保存到本地
+ (void)SaveImageToLocal:(UIImage*)image Keys:(NSString*)key;

//本地是否有相关图片
+ (BOOL)LocalHaveImage:(NSString*)key;

//从本地获取图片
+ (UIImage*)GetImageFromLocal:(NSString*)key;

+ (UIImage *) imageFromURLString: (NSString *) urlstring;
//将昵称保存到本地
+ (void)SaveNickToLocal:(NSString*)nick Keys:(NSString*)key;

//本地是否有相关昵称
+ (BOOL)LocalHaveNick:(NSString*)key;

//从本地获取昵称
+ (NSString*)GetNickFromLocal:(NSString*)key;

+ (UIImage *)imageResize:(UIImage *)image resizeTo:(CGSize)newSize;


@end
