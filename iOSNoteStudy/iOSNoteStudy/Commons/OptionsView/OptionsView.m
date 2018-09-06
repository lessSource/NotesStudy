//
//  OptionsView.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/6/22.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "OptionsView.h"

static CGFloat const BUTTONADDWIDTH = 20;
static NSInteger const BUTTONTAG = 12312;

@interface OptionsView ()
@property (nonatomic, assign) CGFloat allViewWidth;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation OptionsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self defaultParameters];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self defaultParameters];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self optionsViewReloadData];
}

- (void)defaultParameters {
    _marginInsets = UIEdgeInsetsMake(10, 15, 10, 15);
    _allViewWidth = (kScreenWidth - _marginInsets.left - _marginInsets.right);
    _horizontalSpacing = _verticalSpacing = 10;
    _buttonHeight = 40;
    _isWidthFixed = NO;
    _isMultiSelect = NO;
    _isTextField = NO;
    _horizontalCount = 1;
    _maxSelect = 0;
}

- (void)optionsViewReloadData {
    if (self.delegate) {
        self.dataArray = [self.delegate optionsViewData:self];
    }
    if (self.dataArray.count == 0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(optionsViewHeight:)]) {
            [self.delegate optionsViewHeight:0];
        }else {
            self.height = 0;
        }
    }else {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.buttonArray removeAllObjects];
        [self _optionsViewButton];
    }
}

#pragma mark - Event
- (void)optionsButtonClick:(OptionsButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(optionsView:didSelect:selectRow:)]) {
        [self.delegate optionsView:self didSelect:sender.currentTitle selectRow:sender.tag - BUTTONTAG];
    }
    if (self.isMultiSelect) {
        if ([self.buttonArray containsObject:sender.currentTitle]) {
            [self.buttonArray removeObject:sender.currentTitle];
            sender.title_color(self.buttonStyle.titColorNor).back_color(self.buttonStyle.backColorNor);
        }else {
            if (self.buttonArray.count < self.maxSelect || self.maxSelect == 0) {
                [self.buttonArray addObject:sender.currentTitle];
                sender.title_color(self.buttonStyle.titColorSel).back_color(self.buttonStyle.backColorSel);
            }else {
//                [[LSAlertUtil alertManager] showPromptInfo:[NSString stringWithFormat:@"最多选择%ld",self.maxSelect]];
            }
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(optionsView:didSelect:)]) {
            [self.delegate optionsView:self didSelect:self.buttonArray];
        }
        return;
    }
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[OptionsButton class]]) {
            OptionsButton *button = (OptionsButton *)obj;
            if (button.tag == sender.tag) {
                button.title_color(self.buttonStyle.titColorSel).back_color(self.buttonStyle.backColorSel);
            }else {
                button.title_color(self.buttonStyle.titColorNor).back_color(self.buttonStyle.backColorNor);
            }
        }
    }
}

#pragma mark - private
- (void)_optionsViewButton {
    NSInteger column = 1, row = 0;
    CGFloat allButtonWidth = 0, width = 0;
    for (int i = 0; i < self.dataArray.count; i ++) {
        OptionsButton *optionsButton = [[OptionsButton alloc]initWithFrame:CGRectZero];
        optionsButton.button_nameFont(self.dataArray[i], self.buttonStyle.textFontNor).back_color(self.buttonStyle.backColorNor).title_color(self.buttonStyle.titColorNor);
        if (self.buttonStyle.isBorder) {
            optionsButton.layer.borderColor = self.buttonStyle.borderColorNor.CGColor;
            optionsButton.layer.borderWidth = self.buttonStyle.borderWidth;
        }
        optionsButton.layer.cornerRadius = self.buttonStyle.cornerRadius;
        
        if (self.isWidthFixed) {
            width = self.buttonWidth;
        }else {
            width = optionsButton.buttonSize.width + BUTTONADDWIDTH;
        }
        allButtonWidth += width;
        if (allButtonWidth + (row - 1) * self.horizontalSpacing > self.allViewWidth) {
            allButtonWidth = width;
            row = 1;
            column += 1;
        }else {
            row += 1;
        }
        CGFloat buttonX = self.marginInsets.left + self.horizontalSpacing * (row - 1) + allButtonWidth - width;
        CGFloat buttonY = (self.buttonHeight + self.verticalSpacing) * (column - 1) + self.marginInsets.top;
        optionsButton.frame = CGRectMake(buttonX, buttonY, width, self.buttonHeight);
        optionsButton.tag = BUTTONTAG + i;
        [optionsButton addTarget:self action:@selector(optionsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:optionsButton];
    }
    
    CGFloat viewHeight = (self.buttonHeight + self.verticalSpacing) * column - self.verticalSpacing + self.marginInsets.top + self.marginInsets.bottom;
    if (self.delegate && [self.delegate respondsToSelector:@selector(optionsViewHeight:)]) {
        [self.delegate optionsViewHeight:viewHeight];
    }else {
        self.height = viewHeight;
    }
}

- (void)_optionsButtonWidth:(BOOL)isWidthFixed {
    if (isWidthFixed) {
        _buttonWidth = (self.allViewWidth - self.horizontalSpacing * (self.horizontalCount - 1))/self.horizontalCount;
    }
}

#pragma mark - Set
- (void)setHorizontalSpacing:(CGFloat)horizontalSpacing {
    _horizontalSpacing = horizontalSpacing;
    [self _optionsButtonWidth:self.isWidthFixed];
}

- (void)setIsWidthFixed:(BOOL)isWidthFixed {
    _isWidthFixed = isWidthFixed;
    [self _optionsButtonWidth:self.isWidthFixed];
}

- (void)setHorizontalCount:(NSInteger)horizontalCount {
    _horizontalCount = horizontalCount;
    [self _optionsButtonWidth:self.isWidthFixed];
}

- (void)setButtonWidth:(CGFloat)buttonWidth {
    _buttonWidth = buttonWidth;
    [self _optionsButtonWidth:self.isWidthFixed];
}

- (void)setMarginInsets:(UIEdgeInsets)marginInsets {
    _marginInsets = marginInsets;
    self.allViewWidth = (kScreenWidth - marginInsets.left - marginInsets.right);
    [self _optionsButtonWidth:self.isWidthFixed];
}


#pragma mark - Lazy
- (NSMutableArray *)buttonArray {
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (ButtonStyle *)buttonStyle {
    if (_buttonStyle == nil) {
        _buttonStyle = [[ButtonStyle alloc]init];
    }
    return _buttonStyle;
}

@end


@implementation OptionsButton

- (OptionsButton *(^)(NSString *buttonName, UIFont *buttonFont))button_nameFont {
    return ^id(NSString *name, UIFont *font) {
        [self setTitle:name forState:UIControlStateNormal];
        self.titleLabel.font = font;
        CGSize size = L_TEXTSIZE(name, font);
        self->_buttonSize = size;
        return self;
    };
}

- (OptionsButton *(^)(UIColor *color))title_color {
    return ^id(UIColor *color) {
        [self setTitleColor:color forState:UIControlStateNormal];
        return self;
    };
}

- (OptionsButton *(^)(UIColor *color))back_color {
    return ^id(UIColor *color) {
        self.backgroundColor = color;
        return self;
    };
}

@end



@implementation ButtonStyle

- (instancetype)init {
    if (self = [super init]) {
        [self defaultParameters];
    }
    return self;
}

- (void)defaultParameters {
    _borderWidth = 1;
    _cornerRadius = 5;
    _isBorder = YES;
    _textFontNor = _textFontSel = LSFont_Size_12;
    _backColorNor = [UIColor whiteColor];
    _titColorNor = [UIColor mainColor];
    _backColorSel = [UIColor mainColor];
    _titColorSel = [UIColor whiteColor];
    _borderColorNor = [UIColor mainColor];
    _borderColorSel = [UIColor mainColor];
    
}

@end
