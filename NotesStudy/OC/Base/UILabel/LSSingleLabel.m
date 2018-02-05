//
//  LSSingleLabel.m
//  NotesStudy
//
//  Created by Lj on 2018/1/29.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "LSSingleLabel.h"

@implementation LSSingleLabel

- (LSSingleLabel *(^)(NSString *labelText))label_text {
    return ^id(NSString *labelText) {
        self.text = labelText;
        return self;
    };
}

- (LSSingleLabel *(^)(CGFloat size))text_bold {
    return ^id(CGFloat fontSize) {
        self.font = [UIFont fontWithName:@"TimesNewRomanPS-BoldItalicMT" size:fontSize * SizeScale];
        return self;
    };
}


- (LSSingleLabel *(^)(UIFont *font))text_font {
    return ^id(UIFont *textfont) {
        self.font = textfont;
        return self;
    };
}

- (LSSingleLabel *(^)(UIColor *color))text_color {
    return ^id(UIColor *color) {
        self.textColor = color;
        return self;
    };
}

@end
