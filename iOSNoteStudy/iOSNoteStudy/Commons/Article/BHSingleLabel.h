//
//  BHSingleLabel.h
//  Behing
//
//  Created by Lj on 2017/10/19.
//  Copyright © 2017年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BHSingleLabel : UILabel

@property (nonatomic, readonly, copy) BHSingleLabel *(^label_text)(NSString *);

@property (nonatomic, readonly, copy) BHSingleLabel *(^text_bold)(CGFloat);

@property (nonatomic, readonly, copy) BHSingleLabel *(^text_font)(UIFont *);

@property (nonatomic, readonly, copy) BHSingleLabel *(^text_color)(UIColor *);

@end
