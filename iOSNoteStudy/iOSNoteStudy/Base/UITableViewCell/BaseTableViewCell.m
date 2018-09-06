//
//  BaseTableViewCell.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/8.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    if (highlighted) {
        self.backgroundColor = [UIColor colorWithHexString:@"#F7F8FB" alpha:1.0];
    }else {
        self.backgroundColor = [UIColor whiteColor];
    }
    [super setHighlighted:highlighted animated:animated];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
