//
//  UIImage+Category.m
//  NotesStudy
//
//  Created by Lj on 2018/4/16.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "UIImage+Category.h"
#import <Photos/Photos.h>

@implementation UIImage (Category)

/** view生成image */
+ (UIImage *)convertViewToImage:(UIView *)view {
    CGSize size = view.bounds.size;
    //第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数屏幕密度
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    //把控制器的View的内容画到上下文中
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    //- (void)renderInContext:(CGContextRef)ctx; 该方法为渲染view.layer
    //- (void)drawInContext:(CGContextRef)ctx; 该方法为渲染UIImage
    //从上下文生成一张图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    return image;
}


/** 生成渐变色image */
+ (UIImage *)convertGradientToImage:(UIView *)view {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor navigationStartColor].CGColor, (__bridge id)[UIColor navigationEndColor].CGColor];
    gradientLayer.locations = @[@0.1,@1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0.0);
    gradientLayer.frame = view.bounds;
    [view.layer insertSublayer:gradientLayer above:gradientLayer];
    UIImage *image = [self convertViewToImage:view];
    return image;
}

/** color生成image */
+ (UIImage *)convertColorToImage:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 10.0f, 10.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/** 设置图片不透明度 */
+ (UIImage *)imageByAppleingImage:(UIImage *)image alpha:(CGFloat)alpha {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, - area.size.height);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    CGContextDrawImage(ctx, area, image.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
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

/** 保存图片到相册 */
- (void)loadImageSave:(void(^)(BOOL saveSuccess, BOOL createSuccess))successBlock {
    NSMutableArray *imageIds = [NSMutableArray array];
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetChangeRequest *request = [PHAssetChangeRequest creationRequestForAssetFromImage:self];
        [imageIds addObject:request.placeholderForCreatedAsset.localIdentifier];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            PHFetchResult *result = [PHAsset fetchAssetsWithLocalIdentifiers:imageIds options:nil];
            // 获取自定义相册
            PHAssetCollection *assetCollection = [self _getAssetCollectionWithAppNameAndCreateIfNo];
            if (assetCollection == nil) {
                successBlock(true, false);
            }else {
                // 将保存的图片添加到自定义相册中
                NSError *error = nil;
                [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
                    // 需要操作的相册
                    PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
                    // 添加到自定义相册---追加---不能成为封面
                    //                [request addAssets:result];
                    // 插入到自定义相册---插入---可以成为封面
                    [request insertAssets:result atIndexes:[NSIndexSet indexSetWithIndex:0]];
                } error:&error];
                if (error) {
                    successBlock(true, false);
                }else {
                    successBlock(true, true);
                }
            }
        }else {
            successBlock(false, false);
        }
    }];
}


#pragma mark - private
/** 自定义相册 -- 如果没有则创建 */
- (PHAssetCollection *)_getAssetCollectionWithAppNameAndCreateIfNo {
    // 获取APP的名称
    NSString *title = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
    // 获取与APP名称相同的自定义相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {
            return collection;
        }
    }
    // 创建
    NSError *error = nil;
    __block NSString *createID = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // 发起创建相册请求，并拿到ID
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title];
        createID = request.placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    if (error) {
        return nil;
    }
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createID] options:nil].firstObject;
    
}


@end
