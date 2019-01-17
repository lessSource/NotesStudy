//
//  NurseNavbarView.m
//  iOSNoteStudy
//
//  Created by less on 2019/1/17.
//  Copyright © 2019 lj. All rights reserved.
//

#import "NurseNavbarView.h"

@implementation NurseNavbarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark - initView
- (void)initView {
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:@"取消收藏" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(kStatusHeight/2);
        make.right.equalTo(self.mas_right).offset(- 15);
    }];
    
    UIButton *backButton = [[UIButton alloc]init];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(kStatusHeight/2);
        make.left.equalTo(self).offset(15);
    }];
}

- (void)backButtonClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(nurseNavbarSelect:)]) {
        [self.delegate nurseNavbarSelect:0];
    }
}

- (void)buttonClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(nurseNavbarSelect:)]) {
        [self.delegate nurseNavbarSelect:1];
    }
}



@end
