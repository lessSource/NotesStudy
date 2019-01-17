//
//  NurseHeaderView.m
//  iOSNoteStudy
//
//  Created by less on 2019/1/17.
//  Copyright © 2019 lj. All rights reserved.
//

#import "NurseHeaderView.h"
#import "UIImage+Category.h"

@interface NurseHeaderView ()
@property (nonatomic, strong) UIImageView *headerImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *signatureLabel;


@end

@implementation NurseHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark - initView
- (void)initView {
    self.backgroundColor = [UIColor whiteColor];
    UIImage *backGroundImage = [UIImage imageNamed:@"picture"];
    self.layer.contents = (__bridge id _Nullable)([UIImage imageByAppleingImage:backGroundImage alpha:0.2].CGImage);
    UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    [self addSubview:backView];
    
    self.headerImage = [[UIImageView alloc]init];
    self.headerImage.backgroundColor = [UIColor whiteColor];
    self.headerImage.layer.cornerRadius = 80;
    self.headerImage.clipsToBounds = true;
    [self addSubview:self.headerImage];
    [self.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(20 + kNavbarAndStatusBar);
    }];
    
}

@end
