//
//  UIView+Placeholder.h
//  Error
//
//  Created by Lj on 2017/9/26.
//  Copyright © 2017年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Placeholder)

/** 显示隐藏 */
@property (nonatomic, readonly, copy) UIView *(^placeholderShow)(BOOL);
/** 提示文字 */
@property (nonatomic, readonly, copy) UIView *(^prompt_title)(NSString *);
/** 提示文字大小 */
@property (nonatomic, readonly, copy) UIView *(^prompt_Font)(UIFont *);
/** 占位view的位置 */
@property (nonatomic, readonly, copy) UIView *(^prompt_view_frame)(CGRect);
/** 占位图片位置 */
@property (nonatomic, readonly, copy) UIView *(^prompt_frame)(CGRect);
/** 占位图片据上位置 */
@property (nonatomic, readonly, copy) UIView *(^prompt_image_top)(CGFloat);
/** 占位图片 */
@property (nonatomic, readonly, copy) UIView *(^prompt_image)(NSString *);
/** 按钮文字 */
@property (nonatomic, readonly, copy) UIView *(^button_name)(NSString *);
/** 按钮文字大小 */
@property (nonatomic, readonly, copy) UIView *(^button_Font)(UIFont *);
/** button显示 */
@property (nonatomic, readonly, copy) UIView *(^isButtonHidden)(BOOL);
/** button样式 */
- (void)getButtonUIView:(void(^)(UIButton *button))block;
/** buttonAction */
- (void)actionWithBlock:(dispatch_block_t)block;

@end
