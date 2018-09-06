//
//  OptionsView.h
//  iOSNoteStudy
//
//  Created by Lj on 2018/6/22.
//  Copyright © 2018年 lj. All rights reserved.
//  ------------------------------------------|

#import <UIKit/UIKit.h>
@class OptionsView, ButtonStyle;

@protocol OptionsViewDelegate <NSObject>

@required
- (NSArray *)optionsViewData:(OptionsView *)optionsView;

@optional
- (void)optionsView:(OptionsView *)optionsView didSelect:(NSString *)buttonStr selectRow:(NSInteger)row;

- (void)optionsView:(OptionsView *)optionsView didSelect:(NSArray *)buttonArray;

- (void)optionsViewHeight:(CGFloat)height;

@end

@interface OptionsView : UIView

@property (nonatomic, assign) id <OptionsViewDelegate> delegate;
/** 水平间距 */
@property (nonatomic, assign) CGFloat horizontalSpacing;
/** 纵向间距 */
@property (nonatomic, assign) CGFloat verticalSpacing;
/** button宽度 */
@property (nonatomic, assign) CGFloat buttonWidth;
/** button高度 */
@property (nonatomic, assign) CGFloat buttonHeight;
/** 边距 */
@property (nonatomic, assign) UIEdgeInsets marginInsets;
/** 是否等宽 */
@property (nonatomic, assign) BOOL isWidthFixed;
/** 横向个数 (isWidthFixed = Yes) */
@property (nonatomic, assign) NSInteger horizontalCount;
/** 是否多选 */
@property (nonatomic, assign) BOOL isMultiSelect;
/** 最后一个是否是输入框 */
@property (nonatomic, assign) BOOL isTextField;
/** 最多选多少 (默认0) */
@property (nonatomic, assign) NSInteger maxSelect;
/** button样式 */
@property (nonatomic, strong) ButtonStyle *buttonStyle;

- (void)optionsViewReloadData;

@end


@interface OptionsButton: UIButton

@property (nonatomic, readonly, assign) CGSize buttonSize;

@property (nonatomic, readonly, copy) OptionsButton *(^button_nameFont)(NSString *, UIFont *);

@property (nonatomic, readonly, copy) OptionsButton *(^title_color)(UIColor *);

@property (nonatomic, readonly, copy) OptionsButton *(^back_color)(UIColor *);

@end


@interface ButtonStyle: NSObject
/** 未选中背景色 */
@property (nonatomic, strong) UIColor *backColorNor;
/** 选中背景色 */
@property (nonatomic, strong) UIColor *backColorSel;
/** 未选中字体颜色 */
@property (nonatomic, strong) UIColor *titColorNor;
/** 选中字体颜色 */
@property (nonatomic, strong) UIColor *titColorSel;
/** 未选中字体大小 */
@property (nonatomic, strong) UIFont *textFontNor;
/** 选中字体大小 */
@property (nonatomic, strong) UIFont *textFontSel;
/** 未选中边框颜色 */
@property (nonatomic, strong) UIColor *borderColorNor;
/** 选中边框颜色 */
@property (nonatomic, strong) UIColor *borderColorSel;
/** 是否有边框 */
@property (nonatomic, assign) BOOL isBorder;
/** 边框宽度 */
@property (nonatomic, assign) CGFloat borderWidth;
/** 圆角 */
@property (nonatomic, assign) CGFloat cornerRadius;

@end

