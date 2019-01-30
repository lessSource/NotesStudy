//
//  NurseCommentsTableViewCell.m
//  iOSNoteStudy
//
//  Created by Lj on 2019/1/19.
//  Copyright © 2019 lj. All rights reserved.
//

#import "NurseCommentsTableViewCell.h"
#import "OptionsView.h"

@interface NurseCommentsTableViewCell () <OptionsViewDelegate>
@property (nonatomic, strong) UIImageView *headerImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *onTimeLabel;
@property (nonatomic, strong) UILabel *attitudeLabel;
@property (nonatomic, strong) UILabel *professionalLabel;

@end

@implementation NurseCommentsTableViewCell

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
    self.headerImage = [[UIImageView alloc]init];
    self.headerImage.backgroundColor = [UIColor redColor];
    self.headerImage.layer.cornerRadius = 15;
    self.headerImage.contentMode = UIViewContentModeScaleAspectFill;
    self.headerImage.clipsToBounds = true;
    [self.contentView addSubview:self.headerImage];
    [self.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.offset(30);
        make.top.equalTo(self.contentView).offset(15);
        make.left.equalTo(self.contentView).offset(15);
    }];
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.textColor = [UIColor colorWithHexString:@"#666666" alpha:1.0];
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    self.nameLabel.text = @"haa****";
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headerImage);
        make.left.equalTo(self.headerImage.mas_right).offset(5);
    }];
    
    self.onTimeLabel = [[UILabel alloc]init];
    self.onTimeLabel.textColor = [UIColor colorWithHexString:@"#7777777" alpha:1.0];
    self.onTimeLabel.font = [UIFont systemFontOfSize:10];
    self.onTimeLabel.text = @"2019年22年22月";
    [self.contentView addSubview:self.onTimeLabel];
    [self.onTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headerImage);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
    
    OptionsView *optionsView = [[OptionsView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, 50)];
    optionsView.delegate = self;
    optionsView.buttonHeight = 20;
    optionsView.buttonStyle.textFontNor = [UIFont systemFontOfSize:10];
    optionsView.buttonStyle.isBorder = false;
    optionsView.buttonStyle.titColorNor = [UIColor whiteColor];
    optionsView.buttonStyle.backColorNor = [UIColor colorWithHexString:@"#d0d0d0" alpha:1.0];
    optionsView.buttonStyle.backColorSel = [UIColor colorWithHexString:@"#d0d0d0" alpha:1.0];
    optionsView.buttonStyle.cornerRadius = 10;
    [self.contentView addSubview:optionsView];
    
    self.detailLabel = [[UILabel alloc]init];
    self.detailLabel.text = @"服务很好，第一次使用小护登门，非常不错推荐给好多朋友。服务态度好，工作仔细认真以后会一直使用的";
    self.detailLabel.textColor = [UIColor colorWithHexString:@"#777777" alpha:1.0];
    self.detailLabel.numberOfLines = 0;
    self.detailLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(optionsView.mas_bottom);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(- 15);
    }];
    
    self.onTimeLabel = [[UILabel alloc]init];
    self.onTimeLabel.textColor = [UIColor colorWithHexString:@"#f08519" alpha:1.0];
    self.onTimeLabel.font = [UIFont systemFontOfSize:10];
    self.onTimeLabel.text = @"准时 4.6";
    [self.contentView addSubview:self.onTimeLabel];
    [self.onTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(- 12);
    }];
    
    self.attitudeLabel = [[UILabel alloc]init];
    self.attitudeLabel.textColor = [UIColor colorWithHexString:@"#f08519" alpha:1.0];
    self.attitudeLabel.font = [UIFont systemFontOfSize:10];
    self.attitudeLabel.text = @"准时 4.6";
    [self.contentView addSubview:self.attitudeLabel];
    [self.attitudeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.onTimeLabel.mas_right).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(- 12);
    }];
    
    self.professionalLabel = [[UILabel alloc]init];
    self.professionalLabel.textColor = [UIColor colorWithHexString:@"#f08519" alpha:1.0];
    self.professionalLabel.font = [UIFont systemFontOfSize:10];
    self.professionalLabel.text = @"准时 4.6";
    [self.contentView addSubview:self.professionalLabel];
    [self.professionalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.attitudeLabel.mas_right).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(- 12);
    }];
    
}

- (NSArray *)optionsViewData:(OptionsView *)optionsView {
    return @[@"经外周置入中心静脉导管",@"静脉导管",@"生命体质监测"];
}

@end
