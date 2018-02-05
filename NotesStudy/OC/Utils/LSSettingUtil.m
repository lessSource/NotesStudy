//
//  LSSettingUtil.m
//  NotesStudy
//
//  Created by Lj on 2018/2/4.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "LSSettingUtil.h"

@implementation LSSettingUtil

//判断数据是否为空或空对象(如果字符串的话是否为@"")
+ (BOOL)dataAndStringIsNull:(id)obj {
    if ([obj isEqual:[NSNull null]] || obj == nil || [obj isEqual:@""]) {
        return YES;
    }
    return NO;
}



@end
