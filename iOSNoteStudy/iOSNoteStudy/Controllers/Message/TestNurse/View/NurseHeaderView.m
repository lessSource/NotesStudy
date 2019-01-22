//
//  NurseHeaderView.m
//  iOSNoteStudy
//
//  Created by less on 2019/1/17.
//  Copyright © 2019 lj. All rights reserved.
//

#import "NurseHeaderView.h"
#import "UIImage+Category.h"

@interface NurseHeaderView ()
@property (nonatomic, strong) UIImageView *headerImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *certificationLabel;
@property (nonatomic, strong) UILabel *certificateLabel;
@property (nonatomic, strong) UILabel *signatureLabel;
@property (nonatomic, strong) UIButton *gradeButton;
@property (nonatomic, strong) UILabel *countLabel;

@end

@implementation NurseHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark - initView
- (void)initView {
    self.backgroundColor = [UIColor whiteColor];
    UIImage *backGroundImage = [UIImage imageNamed:@"picture"];
    self.layer.contents = (__bridge id _Nullable)([UIImage imageByAppleingImage:backGroundImage alpha:0.2].CGImage);
    UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    [self addSubview:backView];
    
    self.headerImage = [[UIImageView alloc]init];
    self.headerImage.backgroundColor = [UIColor whiteColor];
    self.headerImage.layer.cornerRadius = 40;
    self.headerImage.clipsToBounds = true;
    [self addSubview:self.headerImage];
    [self.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.top.equalTo(self).offset(20 + kNavbarAndStatusBar);
        make.height.width.offset(80);
    }];
    
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.text = @"蒋顺达";
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerImage).offset(5);
        make.left.equalTo(self.headerImage.mas_right).offset(15);
    }];
    
    self.gradeButton = [[UIButton alloc]init];
    self.gradeButton.backgroundColor = [UIColor whiteColor];
    [self.gradeButton setTitle:@"38" forState:UIControlStateNormal];
    self.gradeButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.gradeButton setImage:[UIImage imageNamed:@"sortAscending"] forState:UIControlStateNormal];
    self.gradeButton.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    [self.gradeButton setTitleColor:[UIColor colorWithHexString:@"#a9a8a8" alpha:1.0] forState:UIControlStateNormal];
    [self addSubview:self.gradeButton];
    [self.gradeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel);
        make.left.equalTo(self.nameLabel.mas_right).offset(10);
        make.width.offset(30);
        make.height.offset(15);
    }];
    
    self.countLabel = [[UILabel alloc]init];
    self.countLabel.font = [UIFont systemFontOfSize:10];
    self.countLabel.textColor = [UIColor colorWithHexString:@"#a9a8a8" alpha:1.0];
    self.countLabel.text = @"服务56次";
    self.countLabel.textAlignment = NSTextAlignmentCenter;
    self.countLabel.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(50);
        make.height.offset(15);
        make.centerY.equalTo(self.nameLabel);
        make.left.equalTo(self.gradeButton.mas_right).offset(5);
    }];
    
    UIImageView *certificationImage = [[UIImageView alloc]init];
    certificationImage.backgroundColor = [UIColor redColor];
    [self addSubview:certificationImage];
    [certificationImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImage.mas_right).offset(15);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(7);
        make.width.offset(20);
        make.height.offset(10);
    }];
    
    self.certificationLabel = [[UILabel alloc]init];
    self.certificationLabel.text = @"心理护理师";
    self.certificationLabel.textColor = [UIColor whiteColor];
    self.certificationLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.certificationLabel];
    [self.certificationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(certificationImage);
        make.left.equalTo(certificationImage.mas_right).offset(3);
    }];
    
    UIImageView *certificateImage = [[UIImageView alloc]init];
    certificateImage.backgroundColor = [UIColor redColor];
    [self addSubview:certificateImage];
    [certificateImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImage.mas_right).offset(15);
        make.top.equalTo(certificationImage.mas_bottom).offset(7);
        make.width.offset(20);
        make.height.offset(10);
    }];
    
    self.certificateLabel = [[UILabel alloc]init];
    self.certificateLabel.text = @"《职业资格证书》《养老护理技能证明》《养老护理技能证明》";
    self.certificateLabel.numberOfLines = 2;
    self.certificateLabel.textColor = [UIColor whiteColor];
    self.certificateLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.certificateLabel];
    [self.certificateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(- 30);
        make.left.equalTo(certificateImage.mas_right).offset(3);
        make.top.equalTo(certificateImage);
    }];
    
    UILabel *declarationLabel = [[UILabel alloc]init];
    declarationLabel.text = @"小护宣言：";
    declarationLabel.textColor = [UIColor whiteColor];
    declarationLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:declarationLabel];
    [declarationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.top.equalTo(self.headerImage.mas_bottom).offset(20);
    }];
    
    self.signatureLabel = [[UILabel alloc]init];
    self.signatureLabel.numberOfLines = 0;
    self.signatureLabel.text = @"随着中国老龄化的速度不断加快截止2016年底，我国60岁以上老年人口接近2将老压力则更大中国老龄化的速度不断加快截止2016年底，我国60岁以上老年人口";
    self.signatureLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.signatureLabel];
    self.signatureLabel.textColor = [UIColor whiteColor];
    [self.signatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self.mas_right).offset(- 30);
        make.top.equalTo(declarationLabel.mas_bottom).offset(10);
    }];
}

@end
