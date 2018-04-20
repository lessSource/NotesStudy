//
//  BannerCycleView.h
//  NotesStudy
//
//  Created by Lj on 2018/3/20.
//  Copyright © 2018年 lj. All rights reserved.
//


#import <UIKit/UIKit.h>
@class BannerCycleView;

NS_ASSUME_NONNULL_BEGIN

@protocol BannerCycleViewDataSource <NSObject>

@required
/**
 *  @param cycleView 轮播视图
 *  @return 轮播总数
 */

- (NSInteger)numberOfRowsInCycleView:(BannerCycleView *)cycleView;

/**
 *  @param cycleView 轮播视图
 *  @param row       子视图索引
 *  @return 轮播子视图（继承自系统UICollectionViewCell）
 */

- (UICollectionViewCell *)cycleView:(BannerCycleView *)cycleView cellForItemAtRow:(NSInteger)row;

@end

@interface BannerCycleView : UIView

@property (nonatomic, weak) id <BannerCycleViewDataSource> dataSource;
/** 获取当前索引 */
@property (nonatomic, assign, readonly) NSInteger index;
/** 自动滚动间隔 */
@property (nonatomic, assign) CGFloat timeInterval;


/** 重新载入视图 */
- (void)reloadData;
/** 滚动到下个子视图 */
- (void)scrollNextIndex;
/** 滚动到上个子视图 */
- (void)scrollToPreviousIndex;
/** 滚动到指定索引 */
- (void)scrollToIndex:(NSInteger)index animation:(BOOL)animation;

/** 注册子视图 */
- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(nonnull NSString *)identifier;

/** 从缓存中取重用子视图 */
- (__kindof UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forRow:(NSInteger)row;

@end

NS_ASSUME_NONNULL_END
