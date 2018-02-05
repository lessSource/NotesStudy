//
//  LSSingleLabel.h
//  NotesStudy
//
//  Created by Lj on 2018/1/29.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSSingleLabel : UILabel

@property (nonatomic, readonly, copy) LSSingleLabel *(^label_text)(NSString *);

@property (nonatomic, readonly, copy) LSSingleLabel *(^text_bold)(CGFloat);

@property (nonatomic, readonly, copy) LSSingleLabel *(^text_font)(UIFont *);

@property (nonatomic, readonly, copy) LSSingleLabel *(^text_color)(UIColor *);

@end
