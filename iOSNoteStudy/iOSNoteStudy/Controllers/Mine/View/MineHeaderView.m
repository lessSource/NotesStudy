//
//  MineHeaderView.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/29.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "MineHeaderView.h"

@implementation MineHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    UIImageView *image = [[UIImageView alloc]init];
    image.clipsToBounds = YES;
    image.layer.cornerRadius = 25;
    image.backgroundColor = [UIColor greenColor];
    [self addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(20);
        make.height.width.offset(50);
    }];
}

@end
