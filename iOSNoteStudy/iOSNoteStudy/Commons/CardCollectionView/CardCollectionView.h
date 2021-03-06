//
//  CardCollectionView.h
//  NotesStudy
//
//  Created by Lj on 2018/3/21.
//  Copyright © 2018年 lj. All rights reserved.
//


#import <UIKit/UIKit.h>
@class CardCollectionView;

@protocol CardCollectionDelegate <NSObject>

- (void)cardCollectionView:(CardCollectionView *)menuView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface CardCollectionView : UIView

@property (nonatomic, assign) UIEdgeInsets edgeInsets;

@property (nonatomic, assign) BOOL isZoom;

@property (nonatomic, weak) id <CardCollectionDelegate> delegate;

@end
