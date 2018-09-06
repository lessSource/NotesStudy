//
//  LBrowserImageView.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/6/26.
//  Copyright © 2018年 lj. All rights reserved.
//

#define MaxScale 3.0  //最大缩放比例
#define MinScale 1.0

#import "LBrowserImageView.h"

@interface LBrowserImageView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, assign) CGFloat total;
@property (nonatomic, strong) UIImage *currentImage;

@end

@implementation LBrowserImageView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.delegate = self;
    self.minimumZoomScale = MinScale;
    self.maximumZoomScale = MaxScale;
    self.backgroundColor = [UIColor blackColor];
    
    self.imageView = [[UIImageView alloc]init];
    [self addSubview:self.imageView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureClick:)];
    [self addGestureRecognizer:tapGesture];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGestureClick:)];
    [self addGestureRecognizer:longPressGesture];
    
    UITapGestureRecognizer *doubleGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleGestureClick:)];
    doubleGesture.numberOfTouchesRequired = 2;
    [self addGestureRecognizer:doubleGesture];
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchClick:)];
    [self addGestureRecognizer:pinchRecognizer];
    
    [tapGesture requireGestureRecognizerToFail:doubleGesture];
    
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat offsetX = (CGRectGetWidth(self.bounds) > self.contentSize.width) ? (CGRectGetWidth(self.bounds) - self.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (CGRectGetHeight(self.bounds) > self.contentSize.height) ? (CGRectGetHeight(self.bounds) - self.contentSize.height) * 0.5 : 0.0;
    self.imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
}

#pragma mark - Event
- (void)tapGestureClick:(UITapGestureRecognizer *)gestureRecognizer {
    if (self.imageDelegate && [self.imageDelegate respondsToSelector:@selector(didSelectImageView:deleteImage:)]) {
        [self.imageDelegate didSelectImageView:self deleteImage:self.currentImage];
    }
}

- (void)longPressGestureClick:(UILongPressGestureRecognizer *)gestureRecognizer {
    if (self.imageDelegate && [self.imageDelegate respondsToSelector:@selector(longPressImageView:image:)]) {
        [self.imageDelegate longPressImageView:self image:self.currentImage];
    }
}

- (void)doubleGestureClick:(UITapGestureRecognizer *)gestureRecognizer {
    if (self.zoomScale > MinScale) {
        [self setZoomScale:MinScale animated:YES];
    }else {
        CGPoint touchPoint = [gestureRecognizer locationInView:self.imageView];
        CGFloat newZoomScale = self.maximumZoomScale;
        CGFloat sizeX = CGRectGetWidth(self.frame) / newZoomScale;
        CGFloat sizeY = CGRectGetHeight(self.frame) / newZoomScale;
        [self zoomToRect:CGRectMake(touchPoint.x - sizeX / 2, touchPoint.y - sizeY / 2, sizeX, sizeY) animated:YES];
    }
}

- (void)pinchClick:(UIPinchGestureRecognizer *)gestureRecognizer {
    
}

#pragma mark - private
- (void)_layoutImageView {
    CGRect imageFrame;
    if (_currentImage.size.width > CGRectGetWidth(self.bounds) || _currentImage.size.height > CGRectGetHeight(self.bounds)) {
        CGFloat imageRation = _currentImage.size.width/_currentImage.size.height;
        CGFloat photoRation = CGRectGetWidth(self.bounds)/CGRectGetHeight(self.bounds);
        
        if (imageRation > photoRation) {
            imageFrame.size = CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetWidth(self.bounds)/_currentImage.size.width * _currentImage.size.height);
            imageFrame.origin.x = 0;
            imageFrame.origin.y = (CGRectGetHeight(self.bounds) - CGRectGetHeight(imageFrame)) / 2.0;
        }else {
            imageFrame.size = CGSizeMake(CGRectGetHeight(self.bounds)/_currentImage.size.height * _currentImage.size.width, CGRectGetHeight(self.bounds));
            imageFrame.origin.x = (CGRectGetWidth(self.bounds) - CGRectGetWidth(imageFrame)) / 2.0;
            imageFrame.origin.y = 0;
        }
    }else {
        imageFrame.size = _currentImage.size;
        imageFrame.origin.x = (CGRectGetWidth(self.bounds) - _currentImage.size.width) / 2.0;
        imageFrame.origin.y = (CGRectGetHeight(self.bounds) - _currentImage.size.height) / 2.0;
    }
    _imageView.frame = imageFrame;
    _imageView.image = _currentImage;
    if (self.imageArray.count > 1) {
        [_imageView setAnimationImages:self.imageArray];
        [_imageView setAnimationDuration:self.total];
        [_imageView setAnimationRepeatCount:LONG_MAX];
        [_imageView startAnimating];
    }
}

#pragma mark - Set
- (void)setShowImage:(id)showImage {
    if (self.imageArray.count > 1) {
        self.total = 0;
        [self.imageView stopAnimating];
        [self.imageArray removeAllObjects];
    }
    _showImage = showImage;
    self.imageView.image = nil;
    if ([LSSettingUtil dataAndStringIsNull:showImage]) {
        self.currentImage = [UIImage imageNamed:@""];
    }else if ([showImage isKindOfClass:[UIImage class]]) {
        self.currentImage = (UIImage *)showImage;
    }else if ([showImage isKindOfClass:[NSString class]]) {
        NSString *imageStr = (NSString *)showImage;
        if ([imageStr hasPrefix:@"http://"] || [imageStr hasPrefix:@"https://"]) {
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@""]];
            self.currentImage = self.imageView.image;
        }else {
            self.currentImage = [UIImage imageNamed:imageStr];
        }
    }
    [self _layoutImageView];
}

- (void)setCurrentImage:(UIImage *)currentImage {
    _currentImage = currentImage;
    _obtainImage = currentImage;
}

#pragma mark - Lazy
- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}


@end



