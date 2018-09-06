//
//  ShoppingCartHeaderView.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/30.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "ShoppingCartHeaderView.h"
#import "HotSpotsButton.h"

@interface ShoppingCartHeaderView ()
@property (nonatomic, strong) HotSpotsButton *selectedButton;
@property (nonatomic, strong) UIButton *storeButton;
@property (nonatomic, strong) UIButton *storImageButton;

@end

@implementation ShoppingCartHeaderView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpUI];
        [self _viewLayout];
    }
    return self;
}

- (void)setUpUI {
    self.selectedButton = [[HotSpotsButton alloc]init];
    [self.selectedButton setImage:[UIImage imageNamed:@"settingUnselect"] forState:UIControlStateNormal];
    [self.selectedButton addTarget:self action:@selector(selectedClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.selectedButton];
    
    self.storImageButton = [[UIButton alloc]init];
    [self.storImageButton setImage:[UIImage imageNamed:@"icon_shop"] forState:UIControlStateNormal];
    [self addSubview:self.storImageButton];
    
    self.storeButton = [[UIButton alloc]init];
    self.storeButton.titleLabel.font = LSFont_Size_14;
    self.storeButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.storeButton setTitle:@"商店商店商店" forState:UIControlStateNormal];
    [self.storeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.storeButton];
}

- (void)_viewLayout {
    [self.selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.height.width.offset(24);
        make.left.equalTo(self).offset(15);
    }];
    
    [self.storImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.height.width.offset(24);
        make.left.equalTo(self.selectedButton.mas_right).offset(10);
    }];
    
    [self.storeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.storImageButton.mas_right).offset(5);
        make.width.lessThanOrEqualTo(@(kScreenWidth - 90));
    }];
}

#pragma mark - Event
- (void)selectedClick:(HotSpotsButton *)sender {
    if (self.selectBlock) { self.selectBlock(); }
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectShoppingCart:indexPath:)]) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:self.section];
        [self.delegate selectShoppingCart:ShoppingCartTypeSection indexPath:index];
    }
}

#pragma mark - Set
- (void)setStoreModel:(ShopStoreModel *)storeModel {
    if (![LSSettingUtil dataAndStringIsNull:storeModel]) {
        [self.storeButton setTitle:storeModel.shopName forState:UIControlStateNormal];
        [self.selectedButton setImage:[UIImage imageNamed:storeModel.isSelect ? @"settingSelect" : @"settingUnselect"] forState:UIControlStateNormal];
    }
}


@end
