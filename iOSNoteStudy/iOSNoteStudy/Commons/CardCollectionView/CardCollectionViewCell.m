//
//  CardCollectionViewCell.m
//  NotesStudy
//
//  Created by Lj on 2018/3/21.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "CardCollectionViewCell.h"

@implementation CardCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor mainColor];
        self.layer.cornerRadius = 10;
        self.clipsToBounds = YES;
    }
    return self;
}

@end
