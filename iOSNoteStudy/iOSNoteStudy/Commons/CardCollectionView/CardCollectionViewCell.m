//
//  CardCollectionViewCell.m
//  NotesStudy
//
//  Created by Lj on 2018/3/21.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "CardCollectionViewCell.h"

@interface CardCollectionViewCell ()

@end

@implementation CardCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor mainColor];
        self.layer.cornerRadius = 10;
        self.clipsToBounds = YES;
        [self initView];
    }
    return self;
}

#pragma mark - initView
- (void)initView {
    self.contentLabel = [[UILabel alloc]init];
    self.contentLabel.textColor = [UIColor whiteColor];
    self.contentLabel.font = [UIFont fontWithName:@"Xingkai SC" size:80];
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
    
    self.describeLabel = [[UILabel alloc]init];
    self.describeLabel.textColor = [UIColor whiteColor];
    self.describeLabel.font = [UIFont fontWithName:@"Xingkai SC" size:14];
    self.describeLabel.textAlignment = NSTextAlignmentCenter;
    self.describeLabel.numberOfLines = 2;
    self.describeLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.describeLabel];
    [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(- 10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(- 5);
    }];
}


@end
