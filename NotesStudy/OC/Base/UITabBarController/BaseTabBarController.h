//
//  BaseTabBarController.h
//  NotesStudy
//
//  Created by Lj on 2018/1/31.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabBarController : UITabBarController

+ (UITabBarItem *)createTabbarItemTitle:(NSString *)title ForImage:(UIImage *)image;

+ (UITabBarItem *)createTabbarItemTitle:(NSString *)title ForImage:(UIImage *)image ForSelectImage:(UIImage *)sImage;

@end
