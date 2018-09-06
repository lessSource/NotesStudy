//
//  TestView.m
//  NotesStudy
//
//  Created by Lj on 2018/3/15.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "TestView.h"
#import "PopUpViewObjeect.h"

@implementation TestView

- (void)willShowView {
//    [super willShowView];
    NSLog(@"willShowView");
}

- (void)willCancelView {
    NSLog(@"willCancelView");
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    UIButton *nameButton = [[UIButton alloc]init];
    [nameButton setTitle:@"button" forState:UIControlStateNormal];
    [nameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nameButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:nameButton];
    [nameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

- (void)buttonClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectViewData:showView:)]) {
        [self.delegate selectViewData:@[@"ddd",@"czcx"] showView:self];
    }
    [[PopUpViewObjeect sharrPopUpView]cancalContentView:self direction:PopUpViewDirectionTypeNone];
}

- (void)dealloc {
    NSLog(@"TextView----------dealloc");
}

@end
