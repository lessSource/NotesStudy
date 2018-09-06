//
//  LStarsView.h
//  iOSNoteStudy
//
//  Created by Lj on 2018/6/29.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LStarsView : UIView

/** 星星之间的间距 */
@property (nonatomic, assign) CGFloat spacing;
/** 星星的数量 */
@property (nonatomic, assign) NSUInteger starCount;
/** 星星的大小 */
@property (nonatomic, assign) CGFloat starSize;
/** 星星图片 */
@property (nonatomic, strong) UIImage *starImage;
/** 选中的数量 (NSInteger) */
@property (nonatomic, assign) NSInteger currentIndex;
/** 选中的数量 (CGFloat) */
@property (nonatomic, assign) CGFloat currentFloat;
/** 未选中颜色 */
@property (nonatomic, strong) UIColor *starNorColor;
/** 选中颜色 */
@property (nonatomic, strong) UIColor *starSelColor;
/** 是否小数 */
@property (nonatomic, assign) BOOL isDecimal;



@end
