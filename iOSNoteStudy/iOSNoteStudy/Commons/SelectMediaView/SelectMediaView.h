//
//  SelectMediaView.h
//  iOSNoteStudy
//
//  Created by Lj on 2018/6/27.
//  Copyright © 2018年 lj. All rights reserved.
//  ------------------------------------------

#import <UIKit/UIKit.h>
@class SelectMediaView;

@protocol SelectMediaViewDelegate <NSObject>

@required
- (NSArray *)dataArrayNumberOfItems:(SelectMediaView *)mediaView;

@optional
- (CGSize)collectionMediaView:(SelectMediaView *)mediaView sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

- (void)collectionMediaView:(SelectMediaView *)mediaView frameHeight:(CGFloat)height;

- (void)selectDeleteMediaView:(SelectMediaView *)mediaView deleteItem:(NSInteger)item;

- (void)selectAddMediaView:(SelectMediaView *)mediaView;

- (void)selectVideoMediaView:(SelectMediaView *)mediaView videoItem:(NSInteger)item;

- (void)selectImageMediaView:(SelectMediaView *)mediaView imageItem:(NSInteger)item;

@end

@interface SelectMediaView : UIView

@property (nonatomic, assign) id <SelectMediaViewDelegate> delegate;

@property (nonatomic, assign) BOOL isDisplayDelete;

@property (nonatomic, assign) BOOL isImplement;

@property (nonatomic, assign) BOOL isAdapter;

@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;

@property (nonatomic, assign) UIEdgeInsets marginInsets;

@property (nonatomic, assign) CGFloat minimumLineSpacing;

@property (nonatomic, assign) CGFloat minimumInteritemSpacing;

@property (nonatomic, assign) NSInteger maxImageCount;

- (void)reloadDataSelectMediaView;

@end
