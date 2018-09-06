//
//  LPhotoBrowser.h
//  iOSNoteStudy
//
//  Created by Lj on 2018/6/27.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "BaseViewController.h"
@class LPhotoBrowser;

@protocol PhotoBrowserDelegate <NSObject>

@optional
- (void)deletePhotoBrowser:(LPhotoBrowser *)photoBrowser deleteImage:(UIImage *)currentImage deleteIndex:(NSInteger)index;

@end

@interface LPhotoBrowser : BaseViewController

@property (nonatomic, assign) id <PhotoBrowserDelegate> delegate;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, assign) BOOL isDelete;

@end
