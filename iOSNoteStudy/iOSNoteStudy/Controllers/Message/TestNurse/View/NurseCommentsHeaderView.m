//
//  NurseCommentsHeaderView.m
//  iOSNoteStudy
//
//  Created by Lj on 2019/1/19.
//  Copyright © 2019 lj. All rights reserved.
//

#import "NurseCommentsHeaderView.h"

@interface NurseCommentsHeaderView ()
@property (nonatomic, strong) UILabel *scoreLabel;

@end

@implementation NurseCommentsHeaderView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

#pragma mark - initView
- (void)initView {
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2, 12, 1, CGRectGetHeight(self.bounds) - 24)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#999999" alpha:1.0];
    [self addSubview:lineView];
    
    self.scoreLabel = [[UILabel alloc]init];
    self.scoreLabel.text = @"5.0";
    self.scoreLabel.textColor = [UIColor colorWithHexString:@"#fdd100" alpha:1.0];
    self.scoreLabel.font = [UIFont systemFontOfSize:30];
    [self addSubview:self.scoreLabel];
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(lineView.mas_left).offset(-30);
    }];
    
    UILabel *ratingLabel = [[UILabel alloc]init];
    ratingLabel.text = @"信用评级";
    ratingLabel.textColor = [UIColor colorWithHexString:@"#666666" alpha:1.0];
    ratingLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:ratingLabel];
    [ratingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.scoreLabel.mas_left).offset(-15);
    }];
    
    for (int i = 0; i < 3; i ++) {
        CommentsScoreView *attitudeView = [[CommentsScoreView alloc]initWithFrame:CGRectMake(kScreenWidth/2, i * CGRectGetHeight(self.bounds)/3, kScreenWidth/2, CGRectGetHeight(self.bounds)/3)];
        [self addSubview:attitudeView];
    }
}

@end

@implementation CommentsScoreView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

#pragma mark - initView
- (void)initView {
    UILabel *label = [[UILabel alloc]init];
    label.text = @"态度";
    label.font = [UIFont systemFontOfSize:10];
    label.textColor = [UIColor colorWithHexString:@"#666666" alpha:1.0];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(35);
        make.centerY.equalTo(self);
    }];
    
    StarsView *starsView = [[StarsView alloc]init];
    starsView.tapEnabled = false;
    starsView.selectNum = 4;
    starsView.starSize = 9;
    starsView.spacing = 3;
    [self addSubview:starsView];
    [starsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(label.mas_right).offset(5);
        make.height.offset(10);
        make.width.offset(57);
    }];
    
    UILabel *starsLabel = [[UILabel alloc]init];
    starsLabel.text = @"93分";
    starsLabel.font = [UIFont systemFontOfSize:10];
    starsLabel.textColor = [UIColor colorWithHexString:@"#666666" alpha:1.0];
    [self addSubview:starsLabel];
    [starsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(starsView.mas_right).offset(5);
        make.centerY.equalTo(self);
    }];
}

@end
