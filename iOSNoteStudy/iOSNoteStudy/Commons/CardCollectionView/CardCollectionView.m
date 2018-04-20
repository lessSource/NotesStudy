//
//  CardCollectionView.m
//  NotesStudy
//
//  Created by Lj on 2018/3/21.
//  Copyright © 2018年 lj. All rights reserved.
//

#define Item_Width kScreenWidth/2


#import "CardCollectionView.h"
#import "CardCollectionViewCell.h"
#import "CardCollectionViewLayout.h"

static NSString *const cardCollectionViewCell = @"CardCollectionViewCell";

@interface CardCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) CGFloat startX;
@property (nonatomic, assign) CGFloat endX;
@property (nonatomic, assign) NSInteger currentIndex;



@end

@implementation CardCollectionView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
        self.backgroundColor = [UIColor clearColor];
        [self configDefaultValues];
    }
    return self;
}

- (void)configDefaultValues {
    self.edgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    self.isZoom = NO;
}

- (void)setUpUI {
    CardCollectionViewLayout *flowLayout = [[CardCollectionViewLayout alloc]init];
    flowLayout.scrollDirection  = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 10;

    self.collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor clearColor];
//    self.collectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    [self addSubview:self.collectionView];
    [self.collectionView registerClass:[CardCollectionViewCell class] forCellWithReuseIdentifier:cardCollectionViewCell];
}

#pragma mark <UICollectionViewDataSource>
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cardCollectionViewCell forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[CardCollectionViewCell alloc]init];
    }
    cell.backgroundColor = [UIColor randomColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(150, 200);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return self.edgeInsets;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.startX = scrollView.contentOffset.x;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    self.endX = scrollView.contentOffset.x;
    if (self.isZoom) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self cellToCenter];
        });
    }
}

- (void)cellToCenter {
    CGFloat drgaMinDistance = Item_Width/2;
    if (self.startX - self.endX >= drgaMinDistance) {
        self.currentIndex -= 1;
    }else if (self.endX - self.startX >= drgaMinDistance) {
        self.currentIndex += 1;
    }
    NSInteger maxIndex = [self.collectionView numberOfItemsInSection:0] - 1;
    self.currentIndex = self.currentIndex <= 0 ? 0 : self.currentIndex;
    self.currentIndex = self.currentIndex >= maxIndex ? maxIndex : self.currentIndex;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}



@end
