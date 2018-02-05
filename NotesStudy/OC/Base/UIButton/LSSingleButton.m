//
//  LSSingleButton.m
//  NotesStudy
//
//  Created by Lj on 2018/1/29.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "LSSingleButton.h"

@implementation LSSingleButton

- (LSSingleButton *(^)(NSString *buttonName))button_name {
    return ^id(NSString *name) {
        [self setTitle:name forState:UIControlStateNormal];
        return self;
    };
}

- (LSSingleButton *(^)(UIColor *backColor))bcakColor {
    return ^id(UIColor *bcakColor) {
        self.backgroundColor = bcakColor;
        return self;
    };
}

- (LSSingleButton *(^)(UIColor *buttonTitleColor))button_title_color {
    return ^id(UIColor *buttonTitleColor) {
        [self setTitleColor:buttonTitleColor forState:UIControlStateNormal];
        return self;
    };
}

- (LSSingleButton *(^)(UIColor *borderColor, CGFloat borderWidth, CGFloat cornerRadius))border {
    return ^id(UIColor *borderColor, CGFloat borderWidth, CGFloat cornerRadius) {
        self.layer.cornerRadius = cornerRadius;
        self.layer.borderColor = borderColor.CGColor;
        self.layer.borderWidth = borderWidth;
        return self;
    };
}

- (LSSingleButton *(^)(UIColor *normalColor, UIColor *highlightColor))highlightedColor {
    return ^id(UIColor *normalColor, UIColor *highlightColor) {
        [self setBackgroundImage:[UIImage createImageWithColor:normalColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage createImageWithColor:highlightColor] forState:UIControlStateHighlighted];
        return self;
    };
}

- (LSSingleButton *(^)(BOOL isSelect))isSelect {
    return ^id(BOOL isSelect) {
        self.userInteractionEnabled = isSelect;
        return self;
    };
}


//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    CGRect bounds = self.bounds;
//    CGFloat widthDelta = 44.0 - CGRectGetWidth(bounds);
//    CGFloat heightDelta = 44.0 - CGRectGetHeight(bounds);
//    bounds = CGRectInset(bounds, - 0.5 * widthDelta, - 0.5 * heightDelta);
//    return CGRectContainsPoint(bounds, point);
//}


@end










