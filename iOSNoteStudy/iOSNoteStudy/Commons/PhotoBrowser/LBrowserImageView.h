//
//  LBrowserImageView.h
//  iOSNoteStudy
//
//  Created by Lj on 2018/6/26.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LBrowserImageView;

@protocol BrowserImageViewDelegate <NSObject>

@optional
- (void)didSelectImageView:(LBrowserImageView *)imageView deleteImage:(UIImage *)currentImage;

- (void)longPressImageView:(LBrowserImageView *)imageView image:(UIImage *)currentImage;


@end

@interface LBrowserImageView : UIScrollView

@property (nonatomic, strong) id showImage;

@property (nonatomic, assign) id <BrowserImageViewDelegate> imageDelegate;

@property (nonatomic, strong, readonly) UIImage *obtainImage;

@end
