//
//  BHStarsView.m
//  Behing
//
//  Created by Lj on 10/01/2018.
//  Copyright © 2018 lj. All rights reserved.
//

typedef void(^EvaluateViewDidChooseStarBlock)(NSUInteger count);


#import "BHStarsView.h"

@interface BHStarsView ()

@property (nonatomic, assign) NSUInteger selectIndex;
@property (nonatomic, copy) EvaluateViewDidChooseStarBlock evaluateViewChooseStarBlock;

@end

@implementation BHStarsView

+ (id)evaluationViewWithChooseStarBlock:(void (^)(NSUInteger))evaluateViewChoosedStarBlock {
    BHStarsView *starsView = [[BHStarsView alloc]init];
    starsView.backgroundColor = [UIColor clearColor];
    starsView.evaluateViewChooseStarBlock = ^(NSUInteger count) {
        if (evaluateViewChoosedStarBlock) evaluateViewChoosedStarBlock(count);
    };
    return starsView;
}

- (id)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        [self defaultParameters];
    }
    return self;
}

- (void)defaultParameters {
    self.starSize = 20;
    self.starCount = 5;
    self.spacing = 20;
}

- (void)setStarCount:(NSUInteger)starCount {
    if (_starCount != starCount) {
        _starCount = starCount;
    }
}

- (void)setTapEnabled:(BOOL)tapEnabled {
    _tapEnabled = tapEnabled;
    self.userInteractionEnabled = tapEnabled;
}

- (void)setSpacing:(CGFloat)spacing {
    if (_spacing != spacing) {
        _spacing = spacing;
        [self setNeedsDisplay];
    }
}

- (void)setStarSize:(CGFloat)starSize {
    if (_starSize != starSize) {
        _starSize = starSize;
    }
}

- (void)setSelectNum:(NSInteger)selectNum {
    if (selectNum == 0) return;
    if (_selectNum != selectNum) {
        _selectNum = selectNum;
        if (_selectNum > self.starCount) {
            _selectNum = self.starCount;
        }
        self.selectIndex = _selectNum;
        [self setNeedsDisplay];
        if (self.evaluateViewChooseStarBlock) self.evaluateViewChooseStarBlock(self.selectIndex);
    }
}

- (void)drawRect:(CGRect)rect {
    UIImage *norImage = [UIImage imageNamed:@"icon_evaluation_nor"];
    UIImage *selImage = [UIImage imageNamed:@"icon_evaluation_sel"];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat top = 0;
    // 如果高度过高则居中
    if (self.frame.size.height > self.starSize) {
        top = (self.frame.size.height - self.starSize) / 2;
    }
    // 画图
    for (NSInteger i = 0; i < self.starCount; i ++) {
        UIImage *drawImage = i < self.selectIndex ? selImage : norImage;
        [self drawImage:context CGImageRef:drawImage.CGImage CGRect:CGRectMake((i == 0) ? 0 : i * (self.starSize + self.spacing), top, self.starSize, self.starSize)];
    }
}

/**************将坐标翻转画图*************/
- (void)drawImage:(CGContextRef)context
       CGImageRef:(CGImageRef)image
           CGRect:(CGRect)rect {
    CGContextSaveGState(context);
    
    CGContextTranslateCTM(context, rect.origin.x, rect.origin.y);
    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, -rect.origin.x, -rect.origin.y);
    CGContextDrawImage(context, rect, image);
    CGContextRestoreGState(context);
}
    
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touches:touches withEvent:event];
}
    
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}
    
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touches:touches withEvent:event];
}
    
- (void)touches:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGFloat selectX = point.x;
    for (int i = 1; i <= self.starCount; i ++) {
        if (selectX < (self.starSize * i + self.spacing/2 * (2 * i - 1))) {
            self.selectIndex = i;
            break;
        }
    }
    [self setNeedsDisplay];
    if (self.evaluateViewChooseStarBlock) {
        self.evaluateViewChooseStarBlock(self.selectIndex);
    }
}
    

@end
