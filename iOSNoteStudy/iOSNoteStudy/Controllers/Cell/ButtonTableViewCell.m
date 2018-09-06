//
//  ButtonTableViewCell.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/8.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "ButtonTableViewCell.h"

@implementation ButtonTableViewCell

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
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    UIView *backView = [[UIView alloc]init];
    backView.layer.cornerRadius = 10;
    backView.clipsToBounds = YES;
    backView.backgroundColor = [UIColor mainColor];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(25);
        make.top.equalTo(self.contentView).offset(10);
    }];
    
    self.contentLabel = [[UILabel alloc]init];
    self.contentLabel.textColor = [UIColor whiteColor];
    self.contentLabel.font = LSFont_Size_15;
    [backView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(backView);
    }];
}



@end
