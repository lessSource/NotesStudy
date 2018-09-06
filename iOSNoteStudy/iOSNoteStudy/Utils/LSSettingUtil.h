//
//  LSSettingUtil.h
//  NotesStudy
//
//  Created by Lj on 2018/2/4.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SortingType) {
    /** 降序 */
    SortingDescendingType,
    /** 升序 */
    SortingAscendingType,
};

typedef NS_ENUM(NSInteger, SortingMethodType) {
    /** 冒泡排序 */
    SortingMethodBubblingType,
};



@interface LSSettingUtil : NSObject

/** 判断是否为空或空对象(如果字符串的话是否为@"") */
+ (BOOL)dataAndStringIsNull:(id)obj;

/** 圆角 */
+ (CALayer *)bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

/** 金额的判断 */
+ (BOOL)isInputAmountConversion:(NSString *)price textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range;

/** 密码判断 */
+ (BOOL)validatePassword:(NSString *)passWord;

/** MD5加密 */
+ (NSString *)MD5:(NSString *)encryption;

/** 身份证校验 */
+ (BOOL)verificationIdentityCard:(NSString *)cardStr;

/** 时间戳转时间 */
+ (NSString *)conversionTime:(NSString *)string dateFormat:(NSString *)format;

/** 存储图片 */
+ (void)photoAlbumsSaveImage:(UIImage *)image isCustomAlbums:(BOOL)isCustomAlbums;

/** 排序 */
+ (NSArray *)sortingWithArray:(NSArray *)dataArray methodType:(SortingMethodType)methodType sortingType:(SortingType)sortingType;

/** 打印数据 */
+ (void)writeFileData:(NSString *)data;

+ (NSString *)input:(int)number;

@end
