//
//  LStarsView.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/6/29.
//  Copyright © 2018年 lj. All rights reserved.
//

static NSUInteger const LStarsCount = 5;
static CGFloat const LStarsSize = 20.;
static CGFloat const LSpacing = 20.;

#import "LStarsView.h"

@implementation LStarsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat top = 0;
    // 如果高度过高则居中
    if (self.frame.size.height > self.starSize) {
        top = (self.frame.size.height - self.starSize) / 2;
    }
    for (int i = 0; i < self.starCount; i ++) {
        CGRect startRect = CGRectMake(i * (self.spacing + self.starSize), top, self.starSize, self.starSize);
        [self.starImage drawInRect:startRect];
    }
    [self.starNorColor set];
    UIRectFillUsingBlendMode(rect, kCGBlendModeSourceIn);
    
    CGRect newRect = CGRectZero;
    if (self.isDecimal) {
        newRect = CGRectMake(0, 0, self.currentFloat * CGRectGetWidth(self.bounds), rect.size.height);
    }else {
        newRect = CGRectMake(0, 0, self.currentIndex * self.starSize, rect.size.height);
    }
    [self.starSelColor set];
    UIRectFillUsingBlendMode(newRect, kCGBlendModeSourceIn);
}

#pragma mark - touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGFloat pointX = [[touches anyObject] locationInView:self].x;
    if (self.isDecimal) {
        self.currentFloat = pointX / CGRectGetWidth(self.bounds);
    }else {
        if (self.currentIndex == 1) {
            self.currentIndex = roundf(pointX / self.starSize);
        }else {
            self.currentIndex = ceilf(pointX / self.starSize);
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGFloat pointX = [[touches anyObject] locationInView:self].x;
    if (self.isDecimal) {
        self.currentFloat = pointX / CGRectGetWidth(self.bounds);
        if (self.currentFloat <= self.starSize / 2 / CGRectGetWidth(self.bounds)) {
            self.currentFloat = self.starSize / 2 / CGRectGetWidth(self.bounds);
        }
    }else {
        if (self.currentIndex == 1) {
            self.currentIndex = roundf(pointX / self.starSize);
        }else {
            self.currentIndex = ceilf(pointX / self.starSize);
        }
        if (self.currentIndex <= 1) {
            self.currentIndex = 1;
        }
    }
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.isDecimal) {
        self.currentFloat = self.currentFloat > 1. ? 1. : self.currentFloat;
        self.currentFloat = self.currentFloat < 0. ? 0. : self.currentFloat;
        CGFloat width = self.currentFloat * CGRectGetWidth(self.bounds);
        CGFloat starWidth = 0.0, count = 0;
        for (int i = 0; i < self.starCount; i ++) {
            starWidth += self.starSize;
            if (starWidth > width) {
                break;
            }
            starWidth += self.spacing;
            if (starWidth > width) {
                break;
            }
            count = i;
        }
        
        CGFloat dddd = (width - count * self.spacing - (count + 1) * self.starSize);
        CGFloat ccc = count + 1;
        if (dddd > self.starSize) {
            ccc += 1;
        }else {
            ccc += (dddd/self.starSize);
        }
        
        NSLog(@"------%f-----",ccc);
    }else {
        if (self.currentIndex > self.starCount) {
            self.currentIndex = self.starCount;
        }
        self.currentIndex = self.currentIndex > self.starCount ? self.starCount : self.currentIndex;
    }

    [self setNeedsDisplay];
}

#pragma mark - Lazy
- (UIImage *)starImage {
    if (!_starImage) {
        _starImage = [UIImage imageNamed:@"icon_evaluation_sel"];
    }
    return _starImage;
}

- (NSUInteger)starCount {
    if (_starCount <= 0) {
        _starCount = LStarsSize;
    }
    return _starCount;
}

- (CGFloat)starSize {
    if (_starSize <= 0.001) {
        _starSize = LStarsSize;
    }
    return _starSize;
}

- (CGFloat)spacing {
    if (_spacing <= 0.001) {
        _spacing = LSpacing;
    }
    return _spacing;
}

- (UIColor *)starNorColor {
    if (!_starNorColor) {
        _starNorColor = [UIColor groupTableViewBackgroundColor];
    }
    return _starNorColor;
}

- (UIColor *)starSelColor {
    if (!_starSelColor) {
        _starSelColor = [UIColor redColor];
    }
    return _starSelColor;
}


@end
