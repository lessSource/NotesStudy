//
//  SelectMediaView.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/6/27.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "SelectMediaView.h"
#import "SelectMediaCell.h"
#import "UIView+Category.h"

static NSString *const selectMediaCell = @"SelectMediaCell";

@interface SelectMediaView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIViewControllerPreviewingDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation SelectMediaView

- (instancetype)init {
    if (self = [super init]) {
        [self defaultValue];
        [self setUpUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self defaultValue];
        [self setUpUI];
    }
    return self;
}

- (void)defaultValue {
    self.maxImageCount = 6;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.marginInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    self.minimumLineSpacing = 1;
    self.minimumInteritemSpacing = 1;
}

- (void)setUpUI {
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayout.minimumLineSpacing = self.minimumLineSpacing;
    self.flowLayout.minimumInteritemSpacing = self.minimumInteritemSpacing;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.contentInset = self.marginInsets;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[SelectMediaCell class] forCellWithReuseIdentifier:selectMediaCell];
    [self addSubview:self.collectionView];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
    [self.collectionView addGestureRecognizer:longPressGesture];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
    [self _reloadDataView];
}

- (void)reloadDataSelectMediaView {
    [self _reloadDataView];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.delegate) {
        return MIN(self.imageArray.count + (self.isImplement ? 1 : 0), self.maxImageCount);
    }else {
        return 0;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SelectMediaCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:selectMediaCell forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[SelectMediaCell alloc]init];
    }
    [self _collectionView:cell cellForItemAtIndexPath:indexPath];
    [self _registerForPreviewingView:cell cellForItemAtIndexPath:indexPath];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionMediaView:sizeForItemAtIndexPath:)]) {
        return [self.delegate collectionMediaView:self sizeForItemAtIndexPath:indexPath];
    }else {
        return CGSizeMake((kScreenWidth - 23)/4, (kScreenWidth - 23)/4);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isImplement && self.imageArray.count == indexPath.item) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectAddMediaView:)]) {
            [self.delegate selectAddMediaView:self];
        }else { }
    }else {
        SelectMediaCell *cell = (SelectMediaCell *)[collectionView cellForItemAtIndexPath:indexPath];
        if (cell.isVideo) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(selectVideoMediaView:videoItem:)]) {
                [self.delegate selectVideoMediaView:self videoItem:indexPath.item];
            }else { }
        }else {
            if (self.delegate && [self.delegate respondsToSelector:@selector(selectImageMediaView:imageItem:)]) {
                [self.delegate selectImageMediaView:self imageItem:indexPath.item];
            }else { }
        }
    }
}

//- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
//    //根据indexPath判断单元格是否可以移动
//    if (self.isImplement && self.imageArray.count == indexPath.item) {
//        return NO;
//    }else {
//        return YES;
//    }
//}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    //sourceIndexPath 原始数据indexPath
    //destinationIndexPath 移动到目标数据的indexPath
//    NSMutableArray *dataArr = [NSMutableArray arrayWithArray:self.imageArray];
//    [dataArr exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
//    self.imageArray = dataArr;
}


#pragma mark - UIViewControllerPreviewingDelegate
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location NS_AVAILABLE_IOS(9_0) {
//    NSIndexPath *indexPath = [self.collectionView indexPathForCell:(UICollectionViewCell *)[previewingContext sourceView]];
    
    UIViewController *viewController = [[UIViewController alloc]init];
    CGRect rect = CGRectMake(0, 0, kScreenWidth, 300);
    previewingContext.sourceRect = rect;
    return viewController;
}

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit NS_AVAILABLE_IOS(9_0) {
    [self.viewController showViewController:viewControllerToCommit sender:self];
}

#pragma mark - Event
- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {
    CGPoint point = [longPress locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
            if (!indexPath) {
                break;
            }
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            break;
        case UIGestureRecognizerStateChanged:
            [self.collectionView updateInteractiveMovementTargetPosition:point];
            break;
        case UIGestureRecognizerStateEnded:
            [self.collectionView endInteractiveMovement];
            break;
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}

#pragma mark - private
- (void)_reloadDataView {
    if (self.delegate) {
        self.imageArray = [self.delegate dataArrayNumberOfItems:self];
    }
    CGFloat height = self.collectionView.collectionViewLayout.collectionViewContentSize.height;
    height = height + self.marginInsets.bottom + self.marginInsets.top;
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionMediaView:frameHeight:)]) {
        [self.delegate collectionMediaView:self frameHeight:height];
        if (self.isAdapter) {
            self.collectionView.height = height;
        }
    }else {
        if (self.isAdapter) {
            self.height = height;
            self.collectionView.height = height ;
        }
    }
    [self.collectionView reloadData];
}

- (void)_registerForPreviewingView:(SelectMediaCell *)cell cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (![self.viewController respondsToSelector:@selector(traitCollection)]) {
        return;
    }
    if (![self.viewController.traitCollection respondsToSelector:@selector(forwardingTargetForSelector:)]) {
        return;
    }
    if (@available(iOS 9.0, *)) {
        if (self.viewController.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
            if (!(self.isImplement && self.imageArray.count == indexPath.item)) {
                [self.viewController registerForPreviewingWithDelegate:(id)self sourceView:cell];
            }
        }
    }
}

- (void)_collectionView:(SelectMediaCell *)cell cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    cell.isDelete = self.isDisplayDelete;
    cell.isVideo = YES;
    @WeakObj(self);
    cell.deleteBlock = ^{
        if (selfWeak.delegate && [selfWeak.delegate respondsToSelector:@selector(selectDeleteMediaView:deleteItem:)]) {
            [selfWeak.delegate selectDeleteMediaView:selfWeak deleteItem:indexPath.item];
        }
    };
    id obj;
    if (self.isImplement && indexPath.item == self.imageArray.count && self.imageArray.count <= self.maxImageCount) {
        obj = @"icon_add_image";
        cell.isImplement = YES;
        cell.isVideo = NO;
    }else {
        obj = self.imageArray[indexPath.item];
        cell.isImplement = NO;
    }
    
    if ([LSSettingUtil dataAndStringIsNull:obj]) {
        cell.image.image = [UIImage imageNamed:@"icon_coding"];
    }else if ([obj isKindOfClass:[UIImage class]]) {
        cell.image.image = (UIImage *)obj;
    }else if ([obj isKindOfClass:[NSString class]]) {
        if([(NSString *)obj hasPrefix:@"http://"]) {
            [cell.image sd_setImageWithURL:[NSURL URLWithString:(NSString *)obj] placeholderImage:[UIImage imageNamed:@"icon_coding"]];
        }else {
            cell.image.image = [UIImage imageNamed:(NSString *)obj];
        }
    }
}

#pragma mark - Set
- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    _scrollDirection = scrollDirection;
    self.flowLayout.scrollDirection = scrollDirection;
}

- (void)setMarginInsets:(UIEdgeInsets)marginInsets {
    _marginInsets = marginInsets;
    self.collectionView.contentInset = marginInsets;
}

- (void)setMinimumLineSpacing:(CGFloat)minimumLineSpacing {
    _minimumLineSpacing = minimumLineSpacing;
    self.flowLayout.minimumLineSpacing = minimumLineSpacing;
}

- (void)setMinimumInteritemSpacing:(CGFloat)minimumInteritemSpacing {
    _minimumInteritemSpacing = minimumInteritemSpacing;
    self.flowLayout.minimumInteritemSpacing = minimumInteritemSpacing;
}

@end
