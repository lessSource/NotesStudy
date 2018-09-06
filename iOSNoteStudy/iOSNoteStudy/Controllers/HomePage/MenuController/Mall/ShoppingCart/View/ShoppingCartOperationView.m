//
//  ShoppingCartOperationView.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/6/1.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "ShoppingCartOperationView.h"
#import "HotSpotsButton.h"

@interface ShoppingCartOperationView ()
@property (nonatomic, strong) UIButton *operationButton;
@property (nonatomic, strong) HotSpotsButton *selectedButton;
@property (nonatomic, strong) UILabel *selectLabel;

@end

@implementation ShoppingCartOperationView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpUI];
        [self _viewLayout];
    }
    return self;
}

- (void)setUpUI {
    self.operationButton = [[UIButton alloc]init];
    self.operationButton.backgroundColor = [UIColor mainColor];
    [self.operationButton addTarget:self action:@selector(operationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.operationButton];
    
    self.selectedButton = [[HotSpotsButton alloc]init];
    [self.selectedButton setImage:[UIImage imageNamed:@"settingUnselect"] forState:UIControlStateNormal];
    [self.selectedButton addTarget:self action:@selector(selectedClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.selectedButton];
    
    self.selectLabel = [[UILabel alloc]init];
    self.selectLabel.textColor = [UIColor randomColor];
    self.selectLabel.font = LSFont_Size_13;
    [self addSubview:self.selectLabel];
    
    self.priceLabel = [[UILabel alloc]init];
    self.priceLabel.textColor = [UIColor mainColor];
    self.priceLabel.font = LSFont_Size_13;
    [self addSubview:self.priceLabel];
}

- (void)_viewLayout {
    [self.operationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.right.equalTo(self.mas_right);
        make.height.offset(50);
        make.width.offset(kScreenWidth/4);
    }];
    
    [self.selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.centerY.equalTo(self.operationButton);
        make.height.width.offset(24);
    }];
    
    [self.selectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.selectedButton);
        make.left.equalTo(self.selectedButton.mas_right).offset(5);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.operationButton);
        make.right.equalTo(self.operationButton.mas_left).offset(- 10);
    }];
}

- (void)shoppingCartSelect:(NSString *)name isSelect:(BOOL)isSelect {
    [self.operationButton setTitle:name forState:UIControlStateNormal];
    [self.selectedButton setImage:[UIImage imageNamed:isSelect ? @"settingSelect" : @"settingUnselect"] forState:UIControlStateNormal];
    self.selectLabel.text = isSelect ? @"全不选" : @"全选";
}

#pragma mark - Event
- (void)operationButtonClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(operationShoppingCart:)]) {
        if ([sender.currentTitle isEqualToString:@"结算"]) {
            [self.delegate operationShoppingCart:ShoppingCartOperationTypePay];
        }else if ([sender.currentTitle isEqualToString:@"删除"]) {
            [self.delegate operationShoppingCart:ShoppingCartOperationTypeDelete];
        }
    }
}

- (void)selectedClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectShoppingCart:indexPath:)]) {
        [self.delegate selectShoppingCart:ShoppingCartTypeAll indexPath:[NSIndexPath indexPathWithIndex:0]];
    }
}

@end
