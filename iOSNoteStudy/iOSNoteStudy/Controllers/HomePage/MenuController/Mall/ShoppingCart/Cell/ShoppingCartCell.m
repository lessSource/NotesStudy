//
//  ShoppingCartCell.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/30.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "ShoppingCartCell.h"
#import "HotSpotsButton.h"
#import "LSLineView.h"

@interface ShoppingCartCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *attributeLabel;
@property (nonatomic, strong) UIImageView *goodsImage;
@property (nonatomic, strong) HotSpotsButton *selectedButton;

@end

@implementation ShoppingCartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpUI];
        [self _viewLayout];
    }
    return self;
}

- (void)setUpUI {
    LSLineView *lineView = [[LSLineView alloc]init];
    lineView.backgroundColor = [UIColor mainBackgroundColor];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.height.offset(1);
        make.width.offset(kScreenWidth - 15);
        make.top.equalTo(self.contentView);
    }];
    
    self.selectedButton = [[HotSpotsButton alloc]init];
    [self.selectedButton setImage:[UIImage imageNamed:@"settingUnselect"] forState:UIControlStateNormal];
    [self.selectedButton addTarget:self action:@selector(selectedClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.selectedButton];
    
    self.goodsImage = [[UIImageView alloc]init];
    self.goodsImage.image = [UIImage imageNamed:@"icon_placeholder"];
    self.goodsImage.backgroundColor = [UIColor mainColor];
    self.goodsImage.clipsToBounds = YES;
    self.goodsImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.goodsImage];
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.text = @"商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称";
    self.nameLabel.textColor = [UIColor darkTextColor];
    self.nameLabel.numberOfLines = 2;
    self.nameLabel.font = LSFont_Size_14;
    [self.contentView addSubview:self.nameLabel];
    
    self.priceLabel = [[UILabel alloc]init];
    self.priceLabel.text = @"¥125";
    self.priceLabel.textColor = [UIColor mainColor];
    self.priceLabel.font = LSFont_Size_17;
    [self.contentView addSubview:self.priceLabel];
}

- (void)_viewLayout {
    [self.selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.height.width.offset(24);
        make.left.equalTo(self.contentView).offset(15);
    }];
    
    [self.goodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.selectedButton.mas_right).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        make.width.equalTo(self.goodsImage.mas_height).multipliedBy(1);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.left.equalTo(self.goodsImage.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImage.mas_right).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(- 15);
    }];
}

#pragma mark - Event
- (void)selectedClick:(HotSpotsButton *)sender {
    if (self.selectBlock) { self.selectBlock();}
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectShoppingCart:indexPath:)]) {
        [self.delegate selectShoppingCart:ShoppingCartTypeRow indexPath:self.indexPath];
    }
}

#pragma mark - Set
- (void)setGoodsModel:(ShopGoodsModel *)goodsModel {
    if (![LSSettingUtil dataAndStringIsNull:goodsModel]) {
        self.nameLabel.text = goodsModel.goodsName;
        self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",goodsModel.goodsPrice];
        [self.selectedButton setImage:[UIImage imageNamed:goodsModel.isSelect ? @"settingSelect" : @"settingUnselect"] forState:UIControlStateNormal];

    }
}

@end
