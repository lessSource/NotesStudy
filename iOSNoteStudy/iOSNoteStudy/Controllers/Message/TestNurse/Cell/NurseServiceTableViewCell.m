//
//  NurseServiceTableViewCell.m
//  iOSNoteStudy
//
//  Created by Lj on 2019/1/19.
//  Copyright © 2019 lj. All rights reserved.
//

#import "NurseServiceTableViewCell.h"

@interface NurseServiceTableViewCell ()
@property (nonatomic, strong) UIImageView *contentImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIButton *timeButton;
@property (nonatomic, strong) UIButton *countButton;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *selectButton;

@end

@implementation NurseServiceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if (selected) {
        [self.selectButton setImage:[UIImage imageNamed:@"sortNone"] forState:UIControlStateNormal];
    }else {
        [self.selectButton setImage:[UIImage imageNamed:@"sortNone"] forState:UIControlStateNormal];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

#pragma mark - initViw
- (void)initView {
    self.contentImage = [[UIImageView alloc]init];
    self.contentImage.backgroundColor = [UIColor redColor];
    self.contentImage.layer.cornerRadius = 5;
    self.contentImage.clipsToBounds = true;
    self.contentImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.contentImage];
    [self.contentImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(15);
        make.width.height.offset(110);
    }];
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.text = @"经外周静脉置入中心静中心中心脉导管...";
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    self.nameLabel.textColor = [UIColor colorWithHexString:@"#444444" alpha:1.0];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.left.equalTo(self.contentImage.mas_right).offset(15);
    }];
    
    self.detailLabel = [[UILabel alloc]init];
    self.detailLabel.text = @"经外周静脉置入中心静脉导管（PICC）维护脉导管（PICC）维护";
    self.detailLabel.font = [UIFont systemFontOfSize:12];
    self.detailLabel.textColor = [UIColor colorWithHexString:@"#666666" alpha:1.0];
    self.detailLabel.numberOfLines = 3;
    [self.contentView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.left.equalTo(self.contentImage.mas_right).offset(15);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(12);
    }];
    
    self.timeButton = [[UIButton alloc]init];
    [self.timeButton setTitle:@"22小时" forState:UIControlStateNormal];
    [self.timeButton setTitleColor:[UIColor colorWithHexString:@"#666666" alpha:1.0] forState:UIControlStateNormal];
    [self.timeButton setImage:[UIImage imageNamed:@"sortNone"] forState:UIControlStateNormal];
    self.timeButton.titleLabel.font = [UIFont systemFontOfSize:11];
    self.timeButton.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
    [self.contentView addSubview:self.timeButton];
    [self.timeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(- 15);
        make.left.equalTo(self.contentImage.mas_right).offset(15);
    }];
    
    self.countButton = [[UIButton alloc]init];
    [self.countButton setTitle:@"18次" forState:UIControlStateNormal];
    [self.countButton setTitleColor:[UIColor colorWithHexString:@"#666666" alpha:1.0] forState:UIControlStateNormal];
    [self.countButton setImage:[UIImage imageNamed:@"sortNone"] forState:UIControlStateNormal];
    self.countButton.titleLabel.font = [UIFont systemFontOfSize:11];
    self.countButton.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
    [self.contentView addSubview:self.countButton];
    [self.countButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.timeButton);
        make.left.equalTo(self.timeButton.mas_right).offset(15);
    }];
    
    self.selectButton = [[UIButton alloc]init];
    [self.selectButton setImage:[UIImage imageNamed:@"sortNone"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.selectButton];
    [self.contentView addSubview:self.selectButton];
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-25);
        make.width.height.offset(20);
        make.centerY.equalTo(self.timeButton);
    }];
    
    self.priceLabel = [[UILabel alloc]init];
    self.priceLabel.text = @"￥300";
    self.priceLabel.textColor = [UIColor colorWithHexString:@"#f08300" alpha:1.0];
    self.priceLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.selectButton);
        make.right.equalTo(self.selectButton.mas_left).offset(-5);
    }];
}


@end
