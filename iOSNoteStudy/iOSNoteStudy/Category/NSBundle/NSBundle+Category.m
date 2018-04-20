//
//  NSBundle+Category.m
//  NotesStudy
//
//  Created by Lj on 2018/2/4.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "NSBundle+Category.h"
#import "HomePageViewController.h"

@implementation NSBundle (Category)

+ (instancetype)categoryBundle {
    static NSBundle *bundle = nil;
    if (bundle == nil) {
        bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[HomePageViewController class]] pathForResource:@"MJRefresh" ofType:@"bundle"]];
    }
    return bundle;
}

+ (NSString *)localizedStringForKey:(NSString *)key {
    return @"dd";
}

+ (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value {
    static NSBundle *bundle = nil;
    if (bundle == nil) {
        NSString *language = [NSLocale preferredLanguages].firstObject;
        if ([language hasPrefix:@"en"]) {
            language = @"en";
        }else {
            language = @"zh-Hans"; //简体中文
        }
        
        bundle = [NSBundle bundleWithPath:[[NSBundle categoryBundle] pathForResource:language ofType:@"dd"]];
    }
    value = [bundle localizedStringForKey:key value:value table:nil];
    return [[NSBundle mainBundle] localizedStringForKey:key value:value table:nil];
}

@end

