//
//  CardCollectionViewLayout.m
//  NotesStudy
//
//  Created by Lj on 2018/3/22.
//  Copyright © 2018年 lj. All rights reserved.
//

static CGFloat const ActiveDistance = 350;
static CGFloat const ScaleFator = 0.3;

#import "CardCollectionViewLayout.h"

@implementation CardCollectionViewLayout

- (instancetype)init {
    if (self = [super init]) {
        self.moveX = 0.0;
        self.isZoom = NO;
    }
    return self;
}

//返回rect中的所有的元素布局属性
//UICollectionViewLayoutAttributes可以是Cell，追加视图或装饰视图的信息，通过不同的UICollectionViewLayoutAttributes初始化方法可以得到不同类型的UICollectionViewLayoutAttributes
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    if (self.isZoom) {
        CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width / 2.0f;
        for (UICollectionViewLayoutAttributes *attribute in array) {
            CGFloat distance = fabs(attribute.center.x - centerX);
            CGFloat screenScale = distance / ActiveDistance;
            CGFloat zoom = 1 + ScaleFator * (1 - ABS(screenScale));
            NSLog(@"%f",zoom);
            attribute.transform3D = CATransform3DMakeScale(1.0, zoom, 1.0);
            attribute.zIndex = 1;
        }
    }
    return array;
}

//当边界发生改变时，是否应该刷新布局。如果Yes则在边界变化(一般是Scroll到其他地方)时，将重新计算需要的布局信息
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

////对于Item的细节计算
//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
//    proposedContentOffset.y = 0;
//    CGFloat setX = proposedContentOffset.x;
//    
//    if (setX > self.moveX) {
//        self.moveX += kScreenWidth - self.minimumLineSpacing * 2;
//    }else if (setX < self.moveX) {
//        self.moveX -= kScreenWidth - self.minimumLineSpacing * 2;
//    }
//    proposedContentOffset.x = self.moveX;
//    return proposedContentOffset;
//}











@end
