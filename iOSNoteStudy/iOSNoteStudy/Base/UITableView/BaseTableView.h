//
//  BaseTableView.h
//  iOSNoteStudy
//
//  Created by Lj on 2018/4/24.
//  Copyright © 2018年 lj. All rights reserved.
//

@protocol TabelViewRefreshDelegate <NSObject>

@required

- (void)tableView:(UITableView *)tableView Refresh:(BOOL)refresh PageCount:(NSInteger)pageCount;

@optional

@end

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>

@interface BaseTableView : UITableView

@property (nonatomic, assign) id <TabelViewRefreshDelegate> refreshDelegate;
/** footer */
@property (nonatomic, strong) MJRefreshBackNormalFooter *refreshFooter;
//是否刷新
@property (nonatomic, assign) BOOL isRefresh;
/** 没有更多数据 */
- (void)endRefreshingWithNoMoreData;
/** 马上进入刷新状态 */
- (void)beginRefreshing;
/** 刷新数据 */
- (void)headerRefresh;


@end
