//
//  StarsView.h
//  iOSNoteStudy
//
//  Created by Lj on 2018/6/4.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarsView : UIView

+ (id)evaluationViewWithChooseStarBlock:(void(^)(NSUInteger count))evaluateViewChoosedStarBlock;

/** 星星之间的间距 */
@property (nonatomic, assign) CGFloat spacing;
/** 星星的数量 */
@property (nonatomic, assign) NSUInteger starCount;
/** 星星的大小 */
@property (nonatomic, assign) CGFloat starSize;
/** 选中的数量 */
@property (nonatomic, assign) NSInteger selectNum;
/** 获取选中数量 */
@property (nonatomic, assign, readonly) NSInteger selectCount;

/*
 *@pramas  tapEnabled 关闭星星点击手势，关闭就不能点击
 */
@property (nonatomic, assign, readwrite, getter=isTapEnabled) BOOL tapEnabled;

@end
