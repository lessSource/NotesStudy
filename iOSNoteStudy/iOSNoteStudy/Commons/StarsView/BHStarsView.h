//
//  BHStarsView.h
//  Behing
//
//  Created by Lj on 10/01/2018.
//  Copyright © 2018 lj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BHStarsView : UIView

+ (id)evaluationViewWithChooseStarBlock:(void(^)(NSUInteger count))evaluateViewChoosedStarBlock;

/** 星星之间的间距 */
@property (nonatomic, assign, readwrite) CGFloat spacing;
/** 星星的数量 */
@property (nonatomic, assign, readwrite) NSUInteger starCount;
/** 星星的大小 */
@property (nonatomic, assign, readwrite) CGFloat starSize;
/** 选中的数量 */
@property (nonatomic, assign, readwrite) NSInteger selectNum;
/*
 *@pramas  tapEnabled 关闭星星点击手势，关闭就不能点击
 */
@property (nonatomic, assign, readwrite, getter=isTapEnabled) BOOL tapEnabled;



@end

