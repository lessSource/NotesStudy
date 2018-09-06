//
//  SelectMediaCell.h
//  iOSNoteStudy
//
//  Created by Lj on 2018/6/27.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectMediaCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *image;

@property (nonatomic, assign) BOOL isDelete;

@property (nonatomic, assign) BOOL isImplement;

@property (nonatomic, assign) BOOL isVideo;

@property (nonatomic, copy) dispatch_block_t deleteBlock;


@end

