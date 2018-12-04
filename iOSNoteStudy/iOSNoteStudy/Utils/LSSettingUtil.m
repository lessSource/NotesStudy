//
//  LSSettingUtil.m
//  NotesStudy
//
//  Created by Lj on 2018/2/4.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "LSSettingUtil.h"
#import <CommonCrypto/CommonDigest.h>
#import <Photos/Photos.h>

@implementation LSSettingUtil

//判断数据是否为空或空对象(如果字符串的话是否为@"")
+ (BOOL)dataAndStringIsNull:(id)obj {
    if ([obj isEqual:[NSNull null]] || obj == nil || [obj isEqual:@""]) {
        return YES;
    }
    return NO;
}

//圆角
+ (CALayer *)bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii {
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    return shape;
}

/** 金额的判断 */
+ (BOOL)isInputAmountConversion:(NSString *)price textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range {
    NSString *NumbersWithDot = @".1234567890";
    NSString *NumbersWithoutDot = @"1234567890";
    
    // 判断是否输入内容，或者用户点击的是键盘的删除按钮
    if (![price isEqualToString:@""]) {
        NSCharacterSet *cs;
        // 小数点在字符串中的位置 第一个数字从0位置开始
        NSInteger dotLocation = [textField.text rangeOfString:@"."].location;
        // 判断字符串中是否有小数点
        // NSNotFound 表示请求操作的某个内容或者item没有发现，或者不存在
        // range.location 表示的是当前输入的内容在整个字符串中的位置，位置编号从0开始
        if (dotLocation == NSNotFound ) {
            // -- 如果限制非第一位才能输入小数点，加上 && range.location != 0
            // 取只包含“myDotNumbers”中包含的内容，其余内容都被去掉
            /*
             [NSCharacterSet characterSetWithCharactersInString:myDotNumbers]的作用是去掉"myDotNumbers"中包含的所有内容，只要字符串中有内容与"myDotNumbers"中的部分内容相同都会被舍去
             在上述方法的末尾加上invertedSet就会使作用颠倒，只取与“myDotNumbers”中内容相同的字符
             */
            cs = [[NSCharacterSet characterSetWithCharactersInString:NumbersWithDot] invertedSet];
            if (range.location >= 9) {
                NSLog(@"单笔金额不能超过亿位");
                if ([price isEqualToString:@"."] && range.location == 9) return YES;
                else return NO;
            }
        }else cs = [[NSCharacterSet characterSetWithCharactersInString:NumbersWithoutDot] invertedSet];
        // 按cs分离出数组,数组按@""分离出字符串
        NSString *filtered = [[price componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [price isEqualToString:filtered];
        if (!basicTest)  return NO;
        if (dotLocation != NSNotFound && range.location > dotLocation + 2) return NO;
        if (textField.text.length > 11) return NO;
    }
    return YES;
}

/** 密码判断 */
+ (BOOL)validatePassword:(NSString *)passWord {
    NSString *passWordRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)(?![^0-9a-zA-Z]+$).{6,20}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

/** MD5加密 */
+ (NSString *)MD5:(NSString *)encryption {
    const char *cStr = [encryption UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (unsigned int)strlen(cStr), digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH *2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i ++) {
        [output appendFormat:@"%02X", digest[i]];
    }
    return output;
}

/** 身份证校验 */
+ (BOOL)verificationIdentityCard:(NSString *)cardStr {
    cardStr = [cardStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length = 0;
    if (!cardStr) {
        return NO;
    }else {
        length = cardStr.length;
        if (length != 15 && length != 18) {
            return NO;
        }
    }
    //省份代码
    NSArray *areasArray = @[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    //检测省份身份行政区代码
    NSString *valueStart = [cardStr substringToIndex:2];
    BOOL areaFlag = NO; //标识省份代码是否正确
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart]) {
            areaFlag = YES;
            break;
        }
    }
    if (!areaFlag) {
        return NO;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    int year = 0;
    switch (length) {
        case 15: {
            year = [cardStr substringWithRange:NSMakeRange(6, 2)].intValue + 1900;
            if (year % 4 == 0 || (year % 100 == 0 && year % 4 == 0)) {
                //创建正则表达式 NSRegularExpressionCaseInsensitive: 不区分大小写
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法
            }
            //使用正则表达式匹配字符串
            numberofMatch = [regularExpression numberOfMatchesInString:cardStr options:NSMatchingReportProgress range:NSMakeRange(0, cardStr.length)];
            if (numberofMatch > 0) {
                return YES;
            }else {
                return NO;
            }
        }
            break;
        case 18: {
            year = [cardStr substringWithRange:NSMakeRange(6, 4)].intValue;
            if (year %4 == 0 || (year % 100 == 0 && year % 4 == 0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|71|(8[12])|91)\\d{4}(((19|20)\\d{2}(0[13-9]|1[012])(0[1-9]|[12]\\d|30))|((19|20)\\d{2}(0[13578]|1[02])31)|((19|20)\\d{2}02(0[1-9]|1\\d|2[0-8]))|((19|20)([13579][26]|[2468][048]|0[048])0229))\\d{3}(\\d|X|x)?$" options:NSRegularExpressionCaseInsensitive error:nil];
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|71|(8[12])|91)\\d{4}(((19|20)\\d{2}(0[13-9]|1[012])(0[1-9]|[12]\\d|30))|((19|20)\\d{2}(0[13578]|1[02])31)|((19|20)\\d{2}02(0[1-9]|1\\d|2[0-8]))|((19|20)([13579][26]|[2468][048]|0[048])0229))\\d{3}(\\d|X|x)?$" options:NSRegularExpressionCaseInsensitive error:nil];
            }
            numberofMatch = [regularExpression numberOfMatchesInString:cardStr options:NSMatchingReportProgress range:NSMakeRange(0, cardStr.length)];
            if (numberofMatch > 0) {
                int S = [cardStr substringWithRange:NSMakeRange(0,1)].intValue*7 + [cardStr substringWithRange:NSMakeRange(10,1)].intValue *7 + [cardStr substringWithRange:NSMakeRange(1,1)].intValue*9 + [cardStr substringWithRange:NSMakeRange(11,1)].intValue *9 + [cardStr substringWithRange:NSMakeRange(2,1)].intValue*10 + [cardStr substringWithRange:NSMakeRange(12,1)].intValue *10 + [cardStr substringWithRange:NSMakeRange(3,1)].intValue*5 + [cardStr substringWithRange:NSMakeRange(13,1)].intValue *5 + [cardStr substringWithRange:NSMakeRange(4,1)].intValue*8 + [cardStr substringWithRange:NSMakeRange(14,1)].intValue *8 + [cardStr substringWithRange:NSMakeRange(5,1)].intValue*4 + [cardStr substringWithRange:NSMakeRange(15,1)].intValue *4 + [cardStr substringWithRange:NSMakeRange(6,1)].intValue*2 + [cardStr substringWithRange:NSMakeRange(16,1)].intValue *2 + [cardStr substringWithRange:NSMakeRange(7,1)].intValue *1 + [cardStr substringWithRange:NSMakeRange(8,1)].intValue *6 + [cardStr substringWithRange:NSMakeRange(9,1)].intValue *3;
                
                int Y = S % 11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y, 1)]; //获取校验位
                NSString *lastStr = [cardStr substringWithRange:NSMakeRange(17, 1)];
                if ([lastStr isEqualToString:@"x"]) {
                    if ([M isEqualToString:@"X"]) {
                        return YES;
                    }else {
                        return NO;
                    }
                }else if ([M isEqualToString:[cardStr substringWithRange:NSMakeRange(17, 1)]]) {
                    return YES;
                }else {
                    return NO;
                }
            }else {
                return NO;
            }
        }
            break;
        default:
            return NO;
            break;
    }
}

/** 时间戳转时间 */
+ (NSString *)conversionTime:(NSString *)string dateFormat:(NSString *)format {
    if ([self dataAndStringIsNull:string]) return @"";
    else if ([string rangeOfString:@"Date"].location != NSNotFound) {
        NSRange start = [string rangeOfString:@"("];
        NSRange end = [string rangeOfString:@")"];
        
        NSString *sub = [string substringWithRange:NSMakeRange(start.location + 1, end.location - start.location - 4)];
        NSTimeInterval time = [sub doubleValue];
        NSDate *detailDate = [NSDate dateWithTimeIntervalSince1970:time];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        [dateFormatter setDateFormat:format];
        NSString *currentDateStr = [dateFormatter stringFromDate:detailDate];
        return currentDateStr;
    }else return string;
}

/** 存储图片 */
+ (void)photoAlbumsSaveImage:(UIImage *)image isCustomAlbums:(BOOL)isCustomAlbums {
    NSMutableArray *imagesIds = [NSMutableArray array];
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetChangeRequest *request = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        [imagesIds addObject:request.placeholderForCreatedAsset.localIdentifier];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success && isCustomAlbums) {
            PHFetchResult *result = [PHAsset fetchAssetsWithLocalIdentifiers:imagesIds options:nil];
            //获取自定义相册
            PHAssetCollection *asssetCollection = [self _getAssetCollectionWithAppNameAndCreateIfNo];
            if (asssetCollection == nil) {
                NSLog(@"创建相册失败");
                return;
            }
            NSError *error = nil;
            [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
                PHAssetCollectionChangeRequest *changeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:asssetCollection];
                //添加到自定义相册---追加--不能成为封面
                //[changeRequest addAssets:result];
                //插入到自定义相册---插入--可以成为封面
                [changeRequest insertAssets:result atIndexes:[NSIndexSet indexSetWithIndex:0]];
            } error:&error];
        }
    }];
}

/** 排序 */
+ (NSArray *)sortingWithArray:(NSArray *)dataArray methodType:(SortingMethodType)methodType sortingType:(SortingType)sortingType {
    if (methodType == SortingMethodBubblingType) {
        if (sortingType == SortingDescendingType) {
            return [self _bubbleDescendingSortWithArray:[NSMutableArray arrayWithArray:dataArray]];
        }else {
            return [self _bubbleAscendingSortWithArray:[NSMutableArray arrayWithArray:dataArray]];
        }
    }
    return @[];
}

//打印数据
+ (void)writeFileData:(NSString *)data {
    NSString *directoryPath= @"/Users/less/Desktop/";
    NSString *filePath= [directoryPath stringByAppendingPathComponent:@"text.txt"];
    NSString *fileContent = data;
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
    [fileHandle seekToEndOfFile]; //将节点跳到文件的末尾
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *datestr = [dateFormatter stringFromDate:[NSDate date]];
    
    NSString *str = [NSString stringWithFormat:@"\n%@\n%@",datestr,fileContent];
    NSData* stringData  = [str dataUsingEncoding:NSUTF8StringEncoding];
    [fileHandle writeData:stringData]; //追加写入数据
    [fileHandle closeFile];
}

#pragma mark - Private
//获取相册
+ (PHAssetCollection *)_getAssetCollectionWithAppNameAndCreateIfNo {
    NSString *title = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {
            return collection;
        }
    }
    //创建
    NSError *error = nil;
    __block NSString *createID = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        //发起创建相册的请求，并拿到ID
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title];
        createID = request.placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    if (error) {
        NSLog(@"创建失败");
        return nil;
    }else {
        NSLog(@"创建成功");
        return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createID] options:nil].firstObject;
    }
}

#pragma mark 冒泡排序
//冒泡算法是一种基础的排序算法，这种算法会重复的比较数组中相邻的两个元素。如果一个元素比另一个元素大（小），那么就交换这两个元素的位置。重复这一比较直至最后一个元素。这一比较会重复（n - 1）趟，每一趟比较（n - j）次，j是已经排序好的元素个数。每一趟比较都能找出未排序元素中最大或最小的那个数字。冒泡排序是一种时间复杂度较高，效率较低的排序方法。其空间复杂度是O(n)。
//1、最差时间复杂度 O(n^2)
//2、平均时间复杂度 O(n^2)
/**
 实现思路
 1、没一趟比较都比较数组中两个相邻元素的大小
 2、如果 i 元素小于（i - 1）元素，就调换两个元素的位置
 3、重复（n - 1）趟比较
 */

//降序
+ (NSArray *)_bubbleDescendingSortWithArray:(NSMutableArray *)dataArray {
    for (int i = 0; i < dataArray.count; i ++) {
        for (int j = 0; j < dataArray.count - 1 - i; j ++) {
            if ([dataArray[j] intValue] < [dataArray[j + 1] intValue]) {
                int tmp = [dataArray[j] intValue];
                dataArray[j] = dataArray[j + 1];
                dataArray[j + 1] = [NSNumber numberWithInt:tmp];
            }
        }
    }
    return dataArray;
}

//升序
+ (NSArray *)_bubbleAscendingSortWithArray:(NSMutableArray *)dataArray {
    for (int i = 0; i < dataArray.count; i ++) {
        for (int j = 0; j < dataArray.count - 1 - i; j ++) {
            if ([dataArray[j + 1] intValue] < [dataArray[j] intValue]) {
                int temp = [dataArray[j] intValue];
                dataArray[j] = dataArray[j + 1];
                dataArray[j + 1] = [NSNumber numberWithInt:temp];
            }
        }
    }
    return dataArray;
}

#pragma mark 选择排序
/** 实现思路
 1、设数组内存放了n个待排数字，数组下标从1开始，到n结束
 2、i = 1
 3、从数组的第i个元素开始到第n个元素，寻找最小的元素。（设arr[i]为最小，逐一比较，若遇到比之小的则交换）
 4、将上一步找到的最小元素和第i为元素交换
 5、如果（i = n - 1）算法结束，否则回到第三步
 
 复杂度：
 平均时间复杂度：O(n^2)
 平均空间复杂度：O(1)
 
 */

//降序
+ (NSArray *)_selectionDescendingSortWithArray:(NSMutableArray *)dataArray {
    for (int i = 0; i < dataArray.count; i ++) {
        for (int j = i + 1; j < dataArray.count; j ++) {
            if ([dataArray[i] integerValue] < [dataArray[j] integerValue]) {
                int temp = [dataArray[i] intValue];
                dataArray[i] = dataArray[j];
                dataArray[j] = [NSNumber numberWithInt:temp];
            }
        }
    }
    return dataArray;
}

//升序
+ (NSArray *)_selectionAscendingSortWithArray:(NSMutableArray *)dataArray {
    for (int i = 0; i < dataArray.count; i ++) {
        for (int j = i + 1; dataArray.count; i ++) {
            if ([dataArray[i] integerValue] > [dataArray[j] integerValue]) {
                int temp = [dataArray[i] intValue];
                dataArray[i] = dataArray[j];
                dataArray[j] = [NSNumber numberWithInt:temp];
            }
        }
    }
    return dataArray;
}

#pragma mark 快速排序
/** 实现思路
 1、从数列中挑出一个元素，称为"基准"（pivot）
 2、重新排序树列，所有元素比基准值小的摆放在基准前面，所有元素比基准值大的摆在基准的后面（相同的数可以到任一边）。在这个分割之后，该基准是它的最后位置。这个称为分割（partition）操作。
 3、递归的（recursive）把小于基准值元素的子数列和大于基准值元素的子数列排序。
 
 快速排序是基于分治模式处理的，对一个典型子数组A[p...r]排序的分治过程为三个步骤：
     1.分解
     A[p..r]被划分为两个（可能空）的子数组A[p..q-1]和A[q+1..r],使得A[p..q-1] <= A[q] <= A[q+1..r]
     2.解决：通过递归调用快速排序，对子数组A[p..q-1]和A[q+1..r]排序。
     3.合并
 
 复杂度:
 平均时间复杂度：O(n^2)
 平均空间复杂度：O(nlogn)   O(nlogn) ~ O(n^2)

 */

////降序
//+ (NSArray *)_quickAscendingSortWithArray:(NSMutableArray *)dataArray {
//    
//}

//+ (NSInteger)getMiddleIndex:(NSMutableArray )



+ (NSString *)input:(int)number {
    NSString *str = [NSString stringWithFormat:@"%d",number];
    if (str.length <= 1) {
        return str;
    }
    while (str.length > 1) {
        int number = [str substringToIndex:1].intValue * [str substringFromIndex:1].intValue;
        str = [NSString stringWithFormat:@"%d",number];
    }
    return str;
}


@end

