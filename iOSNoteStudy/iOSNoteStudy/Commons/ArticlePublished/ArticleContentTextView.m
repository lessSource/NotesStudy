//
//  ArticleContentTextView.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/7/10.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "ArticleContentTextView.h"

@implementation ArticleContentTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    //是否纠错
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    //设置拼写检查类型
    self.spellCheckingType = UITextSpellCheckingTypeNo;
//    self.alwaysBounceVertical = YES;
    
}

@end
