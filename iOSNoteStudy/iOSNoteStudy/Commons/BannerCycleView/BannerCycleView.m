//
//  BannerCycleView.m
//  NotesStudy
//
//  Created by Lj on 2018/3/20.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "BannerCycleView.h"

@interface BannerCycleView () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectioView;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger itemCount;

@property (nonatomic, assign) BOOL cycleEnabled;

@end

@implementation BannerCycleView

#pragma mark - Lazy
- (UICollectionView *)collectioView {
    if (_collectioView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        flowLayout.minimumLineSpacing = 1;
        flowLayout.minimumInteritemSpacing = 1;
        _collectioView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectioView.backgroundColor = [UIColor whiteColor];
        _collectioView.delegate = self;
        _collectioView.dataSource = self;
        _collectioView.showsHorizontalScrollIndicator = NO;
        _collectioView.pagingEnabled = YES;
    }
    return _collectioView;
}

- (NSTimer *)timer {
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(scrollNextIndex) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.cycleEnabled = YES;
        self.timeInterval = 3.0f;
        self.collectioView.frame = self.bounds;
        [self addSubview:self.collectioView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect frame = self.bounds;
    if (frame.size.width > 0 && frame.size.height > 0) {
        self.collectioView.frame = frame;
    }
    if (@available(iOS 11.0, *)) {
        self.collectioView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfRowsInCycleView:)]) {
        self.itemCount = MAX([self.dataSource numberOfRowsInCycleView:self], self.itemCount);
    }
    [self startTimer];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfRowsInCycleView:)]) {
        self.itemCount = MAX([self.dataSource numberOfRowsInCycleView:self], self.itemCount);
    }
    return self.cycleEnabled ? self.itemCount + 1 : self.itemCount;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(cycleView:cellForItemAtRow:)]) {
        if (indexPath.row < self.itemCount) {
            cell = [self.dataSource cycleView:self cellForItemAtRow:indexPath.row];
        }else {
            cell = [self.dataSource cycleView:self cellForItemAtRow:0];
        }
    }
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.bounds.size;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self resumeTime];
}

#pragma mark - public
/** 重新载入视图 */
- (void)reloadData {
    if (self.bounds.size.width > 0 && self.bounds.size.height > 0) {
        self.collectioView.frame = self.bounds;
    }
    [self.collectioView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self  scrollToIndex:0 animation:false];
    });
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfRowsInCycleView:)]) {
        self.itemCount = MAX([self.dataSource numberOfRowsInCycleView:self], self.itemCount);
    }
    [self startTimer];
}


/** 滚动到下个子视图 */
- (void)scrollNextIndex {
    NSIndexPath *index = [self returnIndexPath];
    NSInteger item = index.row + 1;
    NSInteger section = index.section;
    if (self.cycleEnabled) {
        if (item == self.itemCount + 1) {
            item = 1;
            [self.collectioView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:false];
        }
    }else {
        if (item == self.itemCount) {
            [self stopTimer];
            return;
        }
    }
    NSIndexPath *nextIndex = [NSIndexPath indexPathForRow:item inSection:section];
    [self.collectioView scrollToItemAtIndexPath:nextIndex atScrollPosition:UICollectionViewScrollPositionLeft animated:true];
}

//滚动到上个子视图
- (void)scrollToPreviousIndex {
    NSIndexPath *index = [self returnIndexPath];
    NSInteger previousIndex = index.row;
    if (previousIndex == 0) {
        previousIndex = self.itemCount - 1;
    }else {
        previousIndex --;
    }
    [self.collectioView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:previousIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:false];
}

/** 滚动到指定索引 */
- (void)scrollToIndex:(NSInteger)index animation:(BOOL)animation {
    [self collectionScrollIndex:index animation:animation];
}

//注册子视图
- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(nonnull NSString *)identifier {
    [self.collectioView registerClass:cellClass forCellWithReuseIdentifier:identifier];
}

//从缓存中取重用子视图
- (__kindof UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forRow:(NSInteger)row {
    return [self.collectioView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
}

#pragma mark - private
- (NSIndexPath *)returnIndexPath {
    NSIndexPath *index = self.collectioView.indexPathsForVisibleItems.lastObject;
//    NSLog(@"%@",index);
    [_collectioView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionLeft animated:false];
    return index;
}

- (void)collectionScrollIndex:(NSInteger)index animation:(BOOL)animation {
    if (index < self.itemCount && index >= 0) {
        [self.collectioView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:animation];
    }
}

- (void)startTimer {
    [self stopTimer];
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.timeInterval]];
}

//暂停定时器
- (void)pauseTimer {
    if (!self.timer.isValid) { return; }
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)stopTimer {
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)resumeTime {
    if (!self.timer.isValid) { return; }
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.timeInterval]];
}

#pragma mark -
- (NSInteger)index {
    NSIndexPath *indexPath = self.collectioView.indexPathsForVisibleItems.lastObject;
    return indexPath.row;
}


@end
