//
//  HomePageMenuView.h
//  NoteDome
//
//  Created by Lj on 2018/1/18.
//  Copyright © 2018年 Lj. All rights reserved.
//



#import <UIKit/UIKit.h>
@class HomePageMenuView;

NS_ASSUME_NONNULL_BEGIN

@protocol HomePageMenuDelegate <NSObject>

@optional
- (void)menuView:(HomePageMenuView *)menuView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

- (void)menuView:(HomePageMenuView *)menuView didSleectCell:(UICollectionViewCell *)cell itemAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol HomePageMenuDataSource <NSObject>

@required
/** 名字 */
- (NSArray *)homePageMenuName:(HomePageMenuView *)menuView;
/** 图片 */
- (NSArray *)homePageMenuImage:(HomePageMenuView *)menuView;


@optional
/** 消息条数 */
- (NSArray *)homePageMenuNumber:(HomePageMenuView *)menuView;
/** Cell大小 */
- (CGSize)homePageMenuView:(HomePageMenuView *)menuView sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface HomePageMenuView : UICollectionView
@property (nonatomic, assign) id <HomePageMenuDelegate> menuDelegate;
@property (nonatomic, assign) id <HomePageMenuDataSource> menuDataSource;
/** 横向数量 */
@property (nonatomic, assign) NSInteger column;
/** 纵向间隔 */
@property (nonatomic, assign) CGFloat lineSpacing;
/** 横向间隔 */
@property (nonatomic, assign) CGFloat interitemSpacing;

/** itemHeight */
@property (nonatomic, assign) CGFloat itemSizeHeight;
/** itemSize */
@property (nonatomic, assign) CGSize itemSize;
/** menuFont */
@property (nonatomic, strong) UIFont *nameFont;
/** menuColor */
@property (nonatomic, strong) UIColor *menuColor;
/** icon image height width */
@property (nonatomic, assign) CGFloat iconImageSize;
/** icon image margin top */
@property (nonatomic, assign) CGFloat iconMarginTop;
/** name margin top */
@property (nonatomic, assign) CGFloat nameMarginTop;


@end

NS_ASSUME_NONNULL_END






