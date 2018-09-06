//
//  GitHubTableViewCell.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/26.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "GitHubTableViewCell.h"

@interface GitHubTableViewCell ()
@property (nonatomic, strong) UILabel *productName;
@property (nonatomic, strong) UILabel *productDescribe;
@property (nonatomic, strong) UILabel *starLabel;
@property (nonatomic, strong) UILabel *ownerLable;
@property (nonatomic, strong) UILabel *urlLabel;
@property (nonatomic, strong) UIImageView *headImage;

@end

@implementation GitHubTableViewCell

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
        [self viewLayout];
    }
    return self;
}

- (void)setUpUI {
    self.headImage = [[UIImageView alloc]init];
    self.headImage.clipsToBounds = YES;
    self.headImage.layer.cornerRadius = 29;
    [self.contentView addSubview:self.headImage];
    
    self.productName = [[UILabel alloc]init];
    self.productName.font = LSFont_Size_17;
    self.productName.numberOfLines = 0;
    self.productName.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:self.productName];
    
    self.ownerLable = [[UILabel alloc]init];
    self.ownerLable.font = LSFont_Size_12;
    self.ownerLable.numberOfLines = 0;
    self.ownerLable.textColor = [UIColor colorWithHexString:@"#575757" alpha:1.0];
    [self.contentView addSubview:self.ownerLable];
    
    self.productDescribe = [[UILabel alloc]init];
    self.productDescribe.font = LSFont_Size_10;
    self.productDescribe.numberOfLines = 0;
    self.productDescribe.textColor = [UIColor colorWithHexString:@"#b7b6b6" alpha:1.0];
    [self.contentView addSubview:self.productDescribe];
    
    self.starLabel = [[UILabel alloc]init];
    self.starLabel.font = LSFont_Size_10;
    self.starLabel.numberOfLines = 0;
    self.starLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1.0];
    [self.contentView addSubview:self.starLabel];
    
    self.urlLabel = [[UILabel alloc]init];
    self.urlLabel.font = LSFont_Size_12;
    self.urlLabel.numberOfLines = 0;
    self.urlLabel.textColor = [UIColor mainColor];
    [self.contentView addSubview:self.urlLabel];
}

- (void)viewLayout {
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.offset(58);
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(8);
    }];
    
    [self.productName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_right).offset(10);
        make.top.equalTo(self.contentView).offset(8);
    }];
    
    [self.starLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(- 15);
        make.centerY.equalTo(self.productName);
    }];
    
    [self.ownerLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(- 15);
        make.top.equalTo(self.productName.mas_bottom).offset(5);
    }];
    
    [self.productDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(- 15);
        make.top.equalTo(self.ownerLable.mas_bottom).offset(5);
    }];
    
    [self.urlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(- 15);
        make.top.equalTo(self.productDescribe.mas_bottom).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(- 10);
    }];
    

}

- (void)setItem:(GitHubListItemModel *)item {
    if (![LSSettingUtil dataAndStringIsNull:item]) {
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:item.owner.avatar_url] placeholderImage:[UIImage imageNamed:@""]];
        self.ownerLable.text = item.owner.login;
        self.productName.text = item.name;
        self.productDescribe.text = item.projectDescription;
        self.urlLabel.text = item.svn_url;
        self.starLabel.text = [NSString stringWithFormat:@"star  %ld",item.stargazers_count];
    }
}


@end
