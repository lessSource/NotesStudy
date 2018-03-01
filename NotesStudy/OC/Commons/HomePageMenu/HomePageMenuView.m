//
//  HomePageMenuView.m
//  NoteDome
//
//  Created by Lj on 2018/1/18.
//  Copyright © 2018年 Lj. All rights reserved.
//

#import "HomePageMenuView.h"
#import "HomePageMenuCell.h"

static CGFloat const CorrectNumber = 0.2;

static NSString *homePageMenuCell = @"HomePageMenuCell";

@interface HomePageMenuView () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *iconArray;
@property (nonatomic, strong) NSArray *numberArray;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation HomePageMenuView

- (id)initWithFrame:(CGRect)frame {
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [self configDefaultValues];
    NSLog(@"------%ld------",self.column);
    if (self = [self initWithFrame:frame collectionViewLayout:self.flowLayout]) {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.backgroundColor = [UIColor whiteColor];
        self.flowLayout = (UICollectionViewFlowLayout *)layout;
        self.collectionViewLayout = self.flowLayout;
        NSLog(@"------%ld------",self.column);
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.delegate = self;
    self.dataSource = self;
    self.alwaysBounceVertical = NO;
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    [self registerClass:[HomePageMenuCell class] forCellWithReuseIdentifier:homePageMenuCell];    
}

- (void)configDefaultValues {
    self.interitemSpacing = 1;
    self.lineSpacing = 1;
    _column = 4;
    _iconImageSize = 50;
    _itemSizeHeight = 90;
}


- (void)reloadData {
    [super reloadData];
    
    CGFloat allWidth = CGRectGetWidth(self.frame) - (_column - 1) * _interitemSpacing - CorrectNumber;
    self.itemSize = CGSizeMake(allWidth/_column, _itemSizeHeight);
    self.nameArray = [self.menuDataSource homePageMenuName:self];
    CGRect frame = self.frame;
    if (self.nameArray.count == 0) frame.size.height = 0;
    else {
        frame.size.height = (_itemSize.height + _lineSpacing) * (self.nameArray.count/_column + (self.nameArray.count%_column == 0 ? 0 : 1)) + CorrectNumber - _lineSpacing;
    }
    self.frame = frame;
    if (self.menuDataSource && [self.menuDataSource respondsToSelector:@selector(homePageMenuImage:)]) {
        self.iconArray = [self.menuDataSource homePageMenuImage:self];
    }
    if (self.menuDataSource && [self.menuDataSource respondsToSelector:@selector(homePageMenuNumber:)]) {
        self.numberArray = [self.menuDataSource homePageMenuNumber:self];
    }
}

- (void)dealloc {
    NSLog(@"------dealloc------");
}

- (void)setColumn:(NSInteger)column {
    _column = column;
}

- (void)setLineSpacing:(CGFloat)lineSpacing {
    _lineSpacing = lineSpacing;
    self.flowLayout.minimumLineSpacing = _lineSpacing;
}

- (void)setInteritemSpacing:(CGFloat)interitemSpacing {
    _interitemSpacing = interitemSpacing;
    self.flowLayout.minimumInteritemSpacing = _interitemSpacing;
}

- (void)setItemSize:(CGSize)itemSize {
    _itemSize = itemSize;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.nameArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomePageMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:homePageMenuCell forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[HomePageMenuCell alloc]init];
    }
    [self _collectionView:cell cellForItemAtIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.menuDelegate && [self.menuDelegate respondsToSelector:@selector(menuView:didSelectItemAtIndexPath:)]) {
        [self.menuDelegate menuView:self didSelectItemAtIndexPath:indexPath];
    }
    if (self.menuDelegate && [self.menuDelegate respondsToSelector:@selector(menuView:didSleectCell:itemAtIndexPath:)]) {
        HomePageMenuCell *cell = (HomePageMenuCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [self.menuDelegate menuView:self didSleectCell:cell itemAtIndexPath:indexPath];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.menuDataSource && [self.menuDataSource respondsToSelector:@selector(homePageMenuView:sizeForItemAtIndexPath:)]) {
        return [self.menuDataSource homePageMenuView:self sizeForItemAtIndexPath:indexPath];
    }else {
        return self.itemSize;
    }
}

#pragma mark -
- (void)_collectionView:(HomePageMenuCell *)cell cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) cell.backgroundColor = [UIColor redColor];
    else cell.backgroundColor = [UIColor blueColor];
    
    cell.iconImage.backgroundColor = [UIColor whiteColor];
    cell.iconImageSize = self.iconImageSize;
    cell.nameLabel.text = self.nameArray[indexPath.item];
    if (self.iconArray.count != 0) {
        NSCAssert(self.nameArray.count == self.iconArray.count, @"The icon is different from the number of names");
        cell.iconImage.image = [UIImage imageNamed:self.iconArray[indexPath.item]];
    }
    if (self.numberArray.count == self.nameArray.count) {
        cell.numberStr = self.numberArray[indexPath.item];
    }else cell.numberLabel.hidden = YES;
}




@end
