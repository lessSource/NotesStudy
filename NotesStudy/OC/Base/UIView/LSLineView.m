//
//  LSLineView.m
//  NotesStudy
//
//  Created by Lj on 2018/1/29.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "LSLineView.h"

@implementation LSLineView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef contenxt = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(contenxt, kCGLineCapRound);
    CGContextSetLineWidth(contenxt, 3);
    CGContextSetAllowsAntialiasing(contenxt, true);
    
    CGContextSetStrokeColorWithColor(contenxt, self.backgroundColor.CGColor);
    CGContextBeginPath(contenxt);
    CGContextMoveToPoint(contenxt, 0, 0); //起点坐标
    CGContextAddLineToPoint(contenxt, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));    //终点坐标
    CGContextStrokePath(contenxt);
    if (_isGradient) {
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = self.bounds;
        gradient.colors = [NSArray arrayWithObjects:(id)MAIN_COLOR.CGColor,(id)[UIColor whiteColor].CGColor, nil];
        [self.layer addSublayer:gradient];
    }
    
}

- (void)setIsGradient:(BOOL)isGradient {
    _isGradient = isGradient;
}


@end













