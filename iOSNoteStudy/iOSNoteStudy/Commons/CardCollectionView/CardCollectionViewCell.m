//
//  CardCollectionViewCell.m
//  NotesStudy
//
//  Created by Lj on 2018/3/21.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "CardCollectionViewCell.h"

@interface CardCollectionViewCell ()
@property (nonatomic, strong) UIImageView *userImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *describeLabel;
@property (nonatomic, strong) UIImageView *contentImage;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *zanNumberLabel;
@property (nonatomic, strong) UILabel *shareNumberLabel;

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
    self.userImage = [[UIImageView alloc]init];
    self.userImage.image = [UIImage imageNamed:@""];
    self.userImage.backgroundColor = [UIColor redColor];
    self.userImage.layer.cornerRadius = 20;
    [self.contentView addSubview:self.userImage];
    [self.userImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(40);
        make.top.equalTo(self.contentView).offset(15);
        make.left.equalTo(self.contentView).offset(15);
    }];
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.text = @"大型犬";
    
}


@end
