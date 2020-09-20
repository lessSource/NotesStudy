//
//  UIImage+Local.m
//  Behing
//
//  Created by 王道道 on 2018/6/22.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "UIImage+Local.h"

@implementation UIImage (Local)

//将图片保存到本地
+ (void)SaveImageToLocal:(UIImage*)image Keys:(NSString*)key {
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    //[preferences persistentDomainForName:LocalPath];
    [preferences setObject:UIImagePNGRepresentation(image) forKey:key];
}

//本地是否有相关图片
+ (BOOL)LocalHaveImage:(NSString*)key {
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    //[preferences persistentDomainForName:LocalPath];
    NSData* imageData = [preferences objectForKey:key];
    if (imageData) {    
        return YES;
    }
    return NO;
}

//从本地获取图片
+ (UIImage*)GetImageFromLocal:(NSString*)key {
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    //[preferences persistentDomainForName:LocalPath];
    NSData* imageData = [preferences objectForKey:key];
    UIImage* image;
    if (imageData) {
        image = [UIImage imageWithData:imageData];
    }
    else {
        NSLog(@"未从本地获得图片");
    }
    return image;
}

+ (UIImage *) imageFromURLString: (NSString *) urlstring {
    return [UIImage imageWithData:[NSData  dataWithContentsOfURL:[NSURL URLWithString:urlstring]]]; 
}

//将昵称保存到本地
+ (void)SaveNickToLocal:(NSString*)nick Keys:(NSString*)key {
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    //[preferences persistentDomainForName:LocalPath];
    [preferences setObject:nick forKey:key];
}

//本地是否有相关昵称
+ (BOOL)LocalHaveNick:(NSString*)key {
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    //[preferences persistentDomainForName:LocalPath];
    NSString* nickData = [preferences objectForKey:key];
    if (nickData) {
        return YES;
    }
    return NO;
}

//从本地获取昵称
+ (NSString*)GetNickFromLocal:(NSString*)key {
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    //[preferences persistentDomainForName:LocalPath];
    NSString* nickData = [preferences objectForKey:key];
    if (nickData) {
        return nickData;
    }
    else {
        NSLog(@"未从本地获得图片");
        return @"";
    }
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
