//
//  HorizontalMenuView.h
//  iOSNoteStudy
//
//  Created by less on 2018/12/4.
//  Copyright © 2018 lj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MenuSoreTypeNone,        // 默认
    MenuSoreTypeDescending,  // 降序
    MenuSoreTypeAscending,   // 升序
} MenuSoreType;

NS_ASSUME_NONNULL_BEGIN

@protocol HorizontalMenuDelegate <NSObject>

@required
- (NSArray *)horizontalMenuArray:(UIView *)menuView;

@optional
- (void)menuView:(UIView *)menuView didSelectButton:(NSInteger)buttonSerial sort:(MenuSoreType)sortType;

/** 图标（必须包含默认、未选中、选中） */
- (NSArray <NSArray *>*)horizontalMenuImageArray:(UIView *)menuView;

@end


@interface HorizontalMenuView : UIView

/** 选中字体大小 */
@property (nonatomic, assign) NSInteger selectedSize;
/** 选择字体颜色 */
@property (nonatomic, strong) UIColor *selectedColor;
/** 未选中字体大小 */
@property (nonatomic, assign) NSInteger uncheckSize;
/** 未选中字体颜色 */
@property (nonatomic, strong) UIColor *uncheckColor;
/** 底部线的颜色 */
@property (nonatomic, strong) UIColor *lineColor;
/** 是否底部划线 */
@property (nonatomic, assign) BOOL lineHidden;
/** 间隔线的颜色 */
@property (nonatomic, strong) UIColor *intervalLineColor;
/** 是否间隔划线 */
@property (nonatomic, assign) BOOL intervalLineHidden;
/** 间隔线高度 */
@property (nonatomic, assign) CGFloat intervalLineHeight;
/** 当前点击index */
@property (nonatomic, assign, readonly) NSInteger currentIndex;


//@property
@property(nonatomic, assign)id <HorizontalMenuDelegate>delegate;

- (void)setSelectButton:(NSInteger)item;

@end

@interface MenuButton : UIButton

- (instancetype)initSoreType:(MenuSoreType)soreType;
/** 排序字段 */
@property (nonatomic, assign) MenuSoreType soreType;
/** 是否可以多次点击 */
@property (nonatomic, assign) BOOL isMoreClick;

- (void)lefttTtleImageHorizontalAlignmentWithSpace:(CGFloat)space;

@end


NS_ASSUME_NONNULL_END
