//
//  BHSingleLabel.m
//  Behing
//
//  Created by Lj on 2017/10/19.
//  Copyright © 2017年 lj. All rights reserved.
//

#import "BHSingleLabel.h"

@implementation BHSingleLabel

- (BHSingleLabel *(^)(NSString *labelText))label_text {
    return ^id(NSString *labelText) {
        self.text = labelText;
        return self;
    };
}

- (BHSingleLabel *(^)(CGFloat size))text_bold {
    return ^id(CGFloat fontSize) {
        self.font = [UIFont fontWithName:@"Helvetica-Bold" size:fontSize * SizeScale];
        return self;
    };
}


- (BHSingleLabel *(^)(UIFont *font))text_font {
    return ^id(UIFont *textfont) {
        self.font = textfont;
        return self;
    };
}

- (BHSingleLabel *(^)(UIColor *color))text_color {
    return ^id(UIColor *color) {
        self.textColor = color;
        return self;
    };
}



@end
