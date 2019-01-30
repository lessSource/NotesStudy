//
//  NurseCertificationTableViewCell.m
//  iOSNoteStudy
//
//  Created by Lj on 2019/1/19.
//  Copyright © 2019 lj. All rights reserved.
//

#import "NurseCertificationTableViewCell.h"

@interface NurseCertificationTableViewCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *selectImage;

@end

@implementation NurseCertificationTableViewCell

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
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.text = @"身份认证";
    self.nameLabel.textColor = [UIColor colorWithHexString:@"#666666" alpha:1.0];
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(30);
    }];
    
    self.detailLabel = [[UILabel alloc]init];
    self.detailLabel.text = @"已认证";
    self.detailLabel.textColor = [UIColor colorWithHexString:@"#666666" alpha:1.0];
    self.detailLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(- 30);
    }];
    
    self.selectImage = [[UIImageView alloc]init];
    self.selectImage.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.selectImage];
    [self.selectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.height.width.offset(14);
        make.right.equalTo(self.detailLabel.mas_left).offset(-8);
    }];

}

@end
