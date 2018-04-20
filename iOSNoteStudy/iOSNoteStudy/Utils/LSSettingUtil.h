//
//  LSSettingUtil.h
//  NotesStudy
//
//  Created by Lj on 2018/2/4.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSSettingUtil : NSObject

/** 判断是否为空或空对象(如果字符串的话是否为@"") */
+ (BOOL)dataAndStringIsNull:(id)obj;

/** 圆角 */
+ (CALayer *)bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;





@end

