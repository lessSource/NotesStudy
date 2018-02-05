//
//  HomePageMenuCell.m
//  NoteDome
//
//  Created by Lj on 2018/1/18.
//  Copyright © 2018年 Lj. All rights reserved.
//

#import "HomePageMenuCell.h"

@interface HomePageMenuCell ()

@end

@implementation HomePageMenuCell

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
}


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configDefaultValues];
        [self setUpUI];
        [self _viewLayout];
    }
    return self;
}


- (void)configDefaultValues {
    _iconImageSize = 50;
    _iconMarginTop = 10;
    _nameMarginTop = 5;
    _nameFont = [UIFont systemFontOfSize:15];
    _nameColor = [UIColor whiteColor];
}

#pragma mark -
- (void)setUpUI {
    self.iconImage = [[UIImageView alloc]init];
    self.iconImage.clipsToBounds = YES;
    self.iconImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.iconImage];
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.font = _nameFont;
    self.nameLabel.textColor = _nameColor;
    self.nameLabel.adjustsFontSizeToFitWidth = YES;
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.nameLabel];
    
    self.numberLabel = [[UILabel alloc]init];
    self.numberLabel.textColor = [UIColor whiteColor];
    self.numberLabel.backgroundColor = [UIColor orangeColor];
    self.numberLabel.clipsToBounds = YES;
    self.numberLabel.layer.cornerRadius = 9;
    self.numberLabel.hidden = YES;
    self.numberLabel.font = [UIFont systemFontOfSize:12];
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.numberLabel];
}

- (void)_viewLayout {
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(_iconMarginTop);
        make.width.height.offset(_iconImageSize);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(5);
        make.top.equalTo(self.iconImage.mas_bottom).offset(_nameMarginTop);
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.offset(18);
        make.left.equalTo(self.iconImage.mas_right).offset(- 9);
        make.top.equalTo(self.iconImage).offset(- 9);
    }];
}

- (void)setNumberStr:(NSString *)numberStr {
    _numberStr = numberStr;
    NSInteger number = [numberStr integerValue];
    if (number == 0) {
        self.numberLabel.hidden = YES;
    }else {
        self.numberLabel.hidden = NO;
        if (number > 99) {
            self.numberLabel.text = @"99+";
            [self.numberLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.offset(27);
            }];
        }else if (number > 9) {
            self.numberLabel.text = numberStr;
            [self.numberLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.offset(22);
            }];
        }else {
            self.numberLabel.text = numberStr;
            [self.numberLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.offset(18);
            }];
        }
    }
}

- (void)setIconImageSize:(CGFloat)iconImageSize {
    _iconImageSize = iconImageSize;
    [self.iconImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.width.offset(iconImageSize);
    }];
}

//- (void)setNameColor:(UIColor *)nameColor {
//    _nameColor = nameColor;
//}

//- (void)setNameFont:(UIFont *)nameFont {
//    _nameFont = nameFont;
//}


@end


