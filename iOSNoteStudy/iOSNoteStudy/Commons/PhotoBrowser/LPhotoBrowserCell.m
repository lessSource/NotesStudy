//
//  LPhotoBrowserCell.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/6/27.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "LPhotoBrowserCell.h"

@implementation LPhotoBrowserCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    CGRect rect = self.bounds;
    rect.size.width -= 10;
    rect.origin.x = 5;
    self.browseImageView = [[LBrowserImageView alloc]initWithFrame:rect];
    self.browseImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.contentView addSubview:self.browseImageView];
}

- (void)layoutSubviews {
    _browseImageView.zoomScale = 1.0;
    _browseImageView.contentSize = _browseImageView.bounds.size;
}

@end
