//
//  BannerViewCell.m
//  BannerCycleView
//
//  Created by Michael on 2017/2/8.
//  Copyright © 2017年 com.chinabidding. All rights reserved.
//

#import "BannerViewCell.h"

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@implementation BannerViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.image = [[UIImageView alloc]initWithFrame:self.bounds];
    self.clipsToBounds = YES;
    self.image.contentMode = UIViewContentModeScaleAspectFill;
    self.image.image = [UIImage imageNamed:@"moren_zhanwei"];
    [self addSubview:self.image];
}


@end
