//
//  SelectMediaCell.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/6/27.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "SelectMediaCell.h"
#import "HotSpotsButton.h"

@interface SelectMediaCell ()
@property (nonatomic, strong) HotSpotsButton *deleteButton;
@property (nonatomic, strong) UIImageView *palyImage;

@end

@implementation SelectMediaCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.image = [[UIImageView alloc]initWithFrame:self.bounds];
    self.image.layer.cornerRadius = 3;
    self.image.clipsToBounds = YES;
    self.image.userInteractionEnabled = YES;
    self.image.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF" alpha:1.0];
    self.image.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.image];
}

#pragma mark - Event
- (void)deleteClick:(UIButton *)sender {
    self.deleteBlock == nil ? : self.deleteBlock();
}

#pragma mark - Set
- (void)setIsDelete:(BOOL)isDelete {
    _isDelete = isDelete;
    self.deleteButton.hidden = !isDelete;
}

- (void)setIsImplement:(BOOL)isImplement {
    _isImplement = isImplement;
    if (self.isDelete && isImplement) {
        self.deleteButton.hidden = YES;
    }
}

- (void)setIsVideo:(BOOL)isVideo {
    _isVideo = isVideo;
    self.palyImage.hidden = !isVideo;
    self.palyImage.center = CGPointMake(CGRectGetWidth(self.image.bounds)/2, CGRectGetHeight(self.image.bounds)/2 + 5);
}

#pragma mark - Lazy
- (HotSpotsButton *)deleteButton {
    if (_deleteButton == nil) {
        _deleteButton = [[HotSpotsButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.bounds) - 20, 0, 20, 20)];
        _deleteButton.backgroundColor = [UIColor whiteColor];
        _deleteButton.layer.cornerRadius = 3;
        [_deleteButton setImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_deleteButton];
    }
    return _deleteButton;
}

- (UIImageView *)palyImage {
    if (_palyImage == nil) {
        _palyImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        _palyImage.center = CGPointMake(0, 0);
        _palyImage.image = [UIImage imageNamed:@"icon_password"];
        [self.contentView addSubview:_palyImage];
    }
    return _palyImage;
}

@end
