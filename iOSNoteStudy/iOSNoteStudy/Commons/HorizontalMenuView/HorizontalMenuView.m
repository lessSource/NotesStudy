//
//  HorizontalMenuView.m
//  iOSNoteStudy
//
//  Created by less on 2018/12/4.
//  Copyright © 2018 lj. All rights reserved.
//

#define BUTTONTAG 687638

#import "HorizontalMenuView.h"

@interface HorizontalMenuView ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *menuWidthArray;
@property (nonatomic, assign) CGFloat frameWidth;
@property (nonatomic, assign) CGFloat titleWidth;   // 所有按钮的宽度
@property (nonatomic, assign) CGFloat SPACE;        // 按钮直接间隔
@property (nonatomic, assign) NSInteger lastSelect; // 上次点击
@property (nonatomic, strong) NSArray<NSArray *> *iconArray;  // 图标

@end

@implementation HorizontalMenuView

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

#pragma mark - defaultParameters
- (void)defaultParameters {
    self.intervalLineHidden = YES;
    self.selectedSize = 14;
    self.selectedColor = [UIColor redColor];
    self.uncheckSize = 14;
    self.uncheckColor = [UIColor blackColor];
    self.lineColor = [UIColor redColor];
    self.intervalLineColor = [UIColor blueColor];
    self.intervalLineHeight = self.frame.size.height - 16;
    self.menuWidthArray = [NSMutableArray array];
}

- (void)reloadData {
    [self initView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self initView];
}

#pragma mark - initView
- (void)initView {
    if (!self.delegate) { return; }
    self.frameWidth = self.frame.size.width;
    self.titleWidth = 0;
    
    NSArray *nameArray = [self.delegate horizontalMenuArray:self];
    if ([self.delegate respondsToSelector:@selector(horizontalMenuImageArray:)]) {
        self.iconArray = [self.delegate horizontalMenuImageArray:self];
    }    
    NSAssert(nameArray.count != 0, @"数组为空");
//    NSAssert(imageArray.count != 0 && imageArray.count == nameArray.count, @"图标和名字数量不等");
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.menuWidthArray removeAllObjects];
    NSInteger imageCount = self.iconArray.count;
    
    /** 计算文字宽度 */
    for (int i = 0; i < nameArray.count; i ++) {
        CGFloat width = [self widthForText:nameArray[i] strSize:self.selectedSize];
        if (imageCount > 0 && self.iconArray[i].count == 3) {
            width += 20;
        }
        self.titleWidth += width;
        [self.menuWidthArray addObject:[NSString stringWithFormat:@"%f",width]];
    }
    
    if (self.titleWidth > self.frame.size.width) {
        self.scrollView.contentSize = CGSizeMake(self.titleWidth, 0);
        self.SPACE = 0.0;
    }else {
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width, 0);
        self.SPACE = (self.frame.size.width - self.titleWidth) / nameArray.count;
    }
    CGFloat buttonX = 0.0;
    for (int i = 0; i < nameArray.count; i ++) {
        NSString *nameString = nameArray[i];
        MenuButton *button = [[MenuButton alloc]initSoreType:MenuSoreTypeNone];
        button.isMoreClick = NO;
        button.tag = BUTTONTAG + i;
        if (i == 0) {
            button.selected = YES;
            self.lastSelect = button.tag;
        }else {
            buttonX += ([self.menuWidthArray[i - 1] floatValue] + self.SPACE);
            button.selected = NO;
        }
        button.frame = CGRectMake(buttonX, 0, [self.menuWidthArray[i] floatValue] + self.SPACE, CGRectGetHeight(self.scrollView.bounds));
        // 设置按钮的字体大小、颜色、状态、图片
        NSMutableAttributedString *norString = [[NSMutableAttributedString alloc]initWithString:nameString];
        [norString addAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:self.uncheckSize], NSForegroundColorAttributeName: self.uncheckColor} range:NSMakeRange(0, nameString.length)];
        [button setAttributedTitle:norString forState:UIControlStateNormal];
        
        // 点击后
        NSMutableAttributedString *selString = [[NSMutableAttributedString alloc]initWithString:nameString];
        [selString addAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:self.selectedSize], NSForegroundColorAttributeName: self.selectedColor} range:NSMakeRange(0, [selString length])];
        [button setAttributedTitle:selString forState:UIControlStateSelected];
        
        if (imageCount > 0 && self.iconArray[i].count == 3) {
            button.isMoreClick = YES;
            [button setImage:[UIImage imageNamed:self.iconArray[i][0]] forState:UIControlStateNormal];
            [button lefttTtleImageHorizontalAlignmentWithSpace:5];
        }
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuView:didSelectButton:sort:)]) {
        [self.delegate menuView:self didSelectButton:0 sort:MenuSoreTypeNone];
    }
}

#pragma mark - Event
- (void)buttonClick:(UIButton *)sender {
    for (UIView *subView in self.scrollView.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            MenuButton *menuButton = (MenuButton *)subView;
            if (menuButton.tag == sender.tag) {
                [menuButton setSelected:YES];
            }else {
                menuButton.soreType = MenuSoreTypeNone;
                if (menuButton.isMoreClick) {
                    [menuButton setImage:[UIImage imageNamed:self.iconArray[menuButton.tag - BUTTONTAG][0]] forState:UIControlStateNormal];
                }
                [menuButton setSelected:NO];
            }
        }
    }
    MenuButton *menuButton = (MenuButton *)sender;
    NSInteger row = menuButton.tag - BUTTONTAG;
    if (menuButton.isMoreClick) {
        switch (menuButton.soreType) {
            case MenuSoreTypeNone:
            case MenuSoreTypeAscending:
                menuButton.soreType = MenuSoreTypeDescending;
                [menuButton setImage:[UIImage imageNamed:self.iconArray[row][1]] forState:UIControlStateNormal];
                break;
            default:
                menuButton.soreType = MenuSoreTypeAscending;
                [menuButton setImage:[UIImage imageNamed:self.iconArray[row][2]] forState:UIControlStateNormal];
                break;
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuView:didSelectButton:sort:)]) {
        if (!(!menuButton.isMoreClick && sender.tag == self.lastSelect)) {
            [self.delegate menuView:self didSelectButton:row sort:menuButton.soreType];
        }
    }
    self.lastSelect = sender.tag;
}

#pragma mark - Public
- (void)setSelectButton:(NSInteger)item {
    
}

#pragma mark - Private
// 计算Lable的宽度
- (CGFloat)widthForText:(NSString *)string strSize:(NSInteger)strSize {
    CGSize size = [string sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:strSize]}];
    return size.width + 20;
}

#pragma mark - Lazy
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.backgroundColor = self.backgroundColor;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (NSMutableArray *)menuWidthArray {
    if (_menuWidthArray == nil) {
        _menuWidthArray = [NSMutableArray array];
    }
    return _menuWidthArray;
}


@end


@implementation MenuButton

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (instancetype)initSoreType:(MenuSoreType)soreType {
    if (self = [self init]) {
        self.soreType = soreType;
    }
    return self;
}


- (void)lefttTtleImageHorizontalAlignmentWithSpace:(CGFloat)space {
    [self resetEdgeInsets];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGRect contentRect = [self contentRectForBounds:self.bounds];
    CGSize titleSize = [self titleRectForContentRect:contentRect].size;
    CGSize imageSize = [self imageRectForContentRect:contentRect].size;
    
    
    [self setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, space)];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, - imageSize.width, 0, imageSize.width)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, titleSize.width + space, 0, - titleSize.width - space)];
}

- (void)resetEdgeInsets {
    [self setContentEdgeInsets:UIEdgeInsetsZero];
    [self setImageEdgeInsets:UIEdgeInsetsZero];
    [self setTitleEdgeInsets:UIEdgeInsetsZero];
}



@end
