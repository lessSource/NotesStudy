//
//  LSSingleButton.h
//  NotesStudy
//
//  Created by Lj on 2018/1/29.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSSingleButton : UIButton

@property (nonatomic, readonly, copy) LSSingleButton *(^button_name)(NSString *);

@property (nonatomic, readonly, copy) LSSingleButton *(^bcakColor)(UIColor *);

@property (nonatomic, readonly, copy) LSSingleButton *(^button_title_color)(UIColor *);

@property (nonatomic, readonly, copy) LSSingleButton *(^highlightedColor)(UIColor *,UIColor *);

@property (nonatomic, readonly, copy) LSSingleButton *(^border)(UIColor *borderColor, CGFloat borderWidth, CGFloat cornerRadius );

@property (nonatomic, readonly, copy) LSSingleButton *(^isSelect)(BOOL);

@end
