//
//  CircleFriendsTableViewCell.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/7/17.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "CircleFriendsTableViewCell.h"
#import <YYText/YYLabel.h>

@interface CircleFriendsTableViewCell ()
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) YYLabel *contentLabel;
@property (nonatomic, strong) UIImageView *replyImageView;
@property (nonatomic, strong) NSMutableArray *commentsArray;

@end

@implementation CircleFriendsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    
}

#pragma mark - Lazy
- (NSMutableArray *)commentsArray {
    if (_commentsArray == nil) {
        _commentsArray = [NSMutableArray array];
    }
    return _commentsArray;
}


@end
