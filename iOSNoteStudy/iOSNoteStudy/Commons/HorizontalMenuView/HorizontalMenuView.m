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
@property (nonatomic, assign) CGFloat titleWidth;
@property (nonatomic, assign) CGFloat SPACE;

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
    self.frameWidth = self.frame.size.width;
    self.titleWidth = 0;
    
    NSArray *nameArray = [self.delegate horizontalMenuArray:self];
    NSArray<NSArray *> *imageArray = [self.delegate horizontalMenuImageArray:self];
    NSAssert(nameArray.count != 0, @"数组为空");
    NSAssert(imageArray.count != 0 && imageArray.count == nameArray.count, @"图标和名字数量不等");
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.menuWidthArray removeAllObjects];
    NSInteger imageCount = imageArray.count;
    
    /** 计算文字宽度 */
    for (int i = 0; i < nameArray.count; i ++) {
        CGFloat width = [self widthForText:nameArray[i] strSize:self.selectedSize];
        if (imageCount > 0 && imageArray[i].count == 2) {
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
        MenuButton *button = [[MenuButton alloc]initSoreType:MenuSoreTypeNone];
        button.tag = BUTTONTAG + i;
        if (i == 0) {
            button.selected = YES;
        }else {
            buttonX += ([self.menuWidthArray[i - 1] floatValue] + self.SPACE);
            button.selected = NO;
        }
        button.frame = CGRectMake(buttonX, 0, [self.menuWidthArray[i] floatValue] + self.SPACE, CGRectGetHeight(self.scrollView.bounds));
        // 设置按钮的字体大小、颜色、状态、图片
        NSMutableAttributedString *norString = [[NSMutableAttributedString alloc]initWithString:nameArray[i]];
        [norString addAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:self.uncheckSize], NSForegroundColorAttributeName: self.uncheckColor} range:NSMakeRange(0, [norString length])];
        if (imageCount > 0 && imageArray[i].count == 2) {
            NSTextAttachment *norTextAtt = [[NSTextAttachment alloc]init];
            norTextAtt.image = [UIImage imageNamed:imageArray[i][0]];
            norTextAtt.bounds = CGRectMake(0, 0, 12, 14);
            NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:norTextAtt];
            [norString appendAttributedString:imageStr];
        }
        [button setAttributedTitle:norString forState:UIControlStateNormal];
        
        // 点击后
        NSMutableAttributedString *selString = [[NSMutableAttributedString alloc]initWithString:nameArray[i]];
        [selString addAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:self.uncheckSize], NSForegroundColorAttributeName: self.uncheckColor} range:NSMakeRange(0, [norString length])];
        if (imageCount > 0 && imageArray[i].count == 2) {
            NSTextAttachment *selTextAtt = [[NSTextAttachment alloc]init];
            selTextAtt.image = [UIImage imageNamed:imageArray[i][1]];
            selTextAtt.bounds = CGRectMake(0, 0, 12, 14);
            NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:selTextAtt];
            [selString appendAttributedString:imageStr];
        }
        [button setAttributedTitle:selString forState:UIControlStateDisabled];
        [self.scrollView addSubview:button];
    }
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
        [self initView];
    }
    return self;
}

#pragma mark - initView
- (void)initView {
    
}

@end
