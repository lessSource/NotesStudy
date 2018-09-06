//
//  BaseTableView.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/4/24.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "BaseTableView.h"

@interface BaseTableView ()
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, strong) MJRefreshNormalHeader *refreshHeader;

@end

@implementation BaseTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.backgroundColor = [UIColor mainBackgroundColor];
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            self.estimatedSectionFooterHeight = 0;
            self.estimatedSectionHeaderHeight = 0;
            self.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
        } else {
            // Fallback on earlier versions
        }
    }
    return self;
}

- (void)setIsRefresh:(BOOL)isRefresh {
    if (isRefresh) [self tabelViewSetupRefresh];
    else return;
}


#pragma mark - Private
- (void)tabelViewSetupRefresh {
    self.refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    self.refreshHeader.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    self.refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    [self.refreshFooter setTitle:@"没有更多数据了" forState:(MJRefreshStateNoMoreData)];
    self.mj_header = self.refreshHeader;
    self.mj_footer = self.refreshFooter;
}

//下拉刷新
- (void)headerRefresh {
    self.pageCount = 1;
    [self.mj_header endRefreshing];
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(tableView:Refresh:PageCount:)]) {
        [self.refreshDelegate tableView:self Refresh:YES PageCount:self.pageCount];
    }
    [self.mj_footer resetNoMoreData];
}

//上拉加载
- (void)footerRefresh {
    self.pageCount ++;
    [self.mj_footer endRefreshing];
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(tableView:Refresh:PageCount:)]) {
        [self.refreshDelegate tableView:self Refresh:NO PageCount:self.pageCount];
    }
}

//没有更多数据
- (void)endRefreshingWithNoMoreData {
    [self.mj_footer endRefreshingWithNoMoreData];
}

// 马上进入刷新状态
- (void)beginRefreshing {
    [self.mj_header beginRefreshing];
}


@end
