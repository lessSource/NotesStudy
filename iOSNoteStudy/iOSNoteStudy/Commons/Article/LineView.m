//
//  LineView.m
//  FlyingEagle
//
//  Created by Lj on 2017/2/10.
//  Copyright © 2017年 lj. All rights reserved.
//

#import "LineView.h"

@implementation LineView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 3);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
//    CGContextSetRGBStrokeColor(context, 116.0 / 255.0, 189.0 / 255.0, 255.0 / 255.0, 1.0);  //线的颜色
    CGContextSetStrokeColorWithColor(context, self.backgroundColor.CGColor);
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, 0, 0);  //起点坐标
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height);   //终点坐标
    CGContextStrokePath(context);
    if (_isGradient) {
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = self.bounds;
        gradient.colors = [NSArray arrayWithObjects:
                           (id)UIColor.mainColor.CGColor,
                           (id)[UIColor whiteColor].CGColor, nil];
        [self.layer addSublayer:gradient];
    }
}

- (void)setIsGradient:(BOOL)isGradient {
    _isGradient = isGradient;
}



@end
