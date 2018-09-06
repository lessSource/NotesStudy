//
//  HotSpotsButton.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/30.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "HotSpotsButton.h"

@implementation HotSpotsButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;
    CGFloat widthDelta = 44.0 - bounds.size.width;
    CGFloat heightDelta = 44.0 - bounds.size.height;
    bounds = CGRectInset(bounds, - widthDelta * 0.5, - heightDelta * 0.5);
    return CGRectContainsPoint(bounds, point);
}

@end
