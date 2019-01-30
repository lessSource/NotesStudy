//
//  NurseCertificateTableViewCell.m
//  iOSNoteStudy
//
//  Created by Lj on 2019/1/19.
//  Copyright © 2019 lj. All rights reserved.
//

#import "NurseCertificateTableViewCell.h"

@interface NurseCertificateTableViewCell ()
@property (nonatomic, strong) UIImageView *firstImage;
@property (nonatomic, strong) UIImageView *secondImage;

@end

@implementation NurseCertificateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

#pragma mark - initView
- (void)initView {
    self.firstImage = [[UIImageView alloc]init];
    self.firstImage.backgroundColor = [UIColor randomColor];
    self.firstImage.clipsToBounds = true;
    self.firstImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.firstImage];
    [self.firstImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(10);
        make.width.offset((kScreenWidth - 45)/2);
    }];
    
    self.secondImage = [[UIImageView alloc]init];
    self.secondImage.backgroundColor = [UIColor randomColor];
    self.secondImage.clipsToBounds = true;
    self.secondImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.secondImage];
    [self.secondImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset((kScreenWidth - 45)/2);
        make.centerY.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(- 15);
    }];
}

@end
