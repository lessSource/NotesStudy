//
//  LSSingleTextField.h
//  NotesStudy
//
//  Created by Lj on 2018/1/28.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionText) (NSString *);

@interface LSSingleTextField : UITextField

@property (nonatomic, readonly, copy) LSSingleTextField *(^placeholderStr)(NSString *);

@property (nonatomic, readonly, copy) LSSingleTextField *(^placeholderColor)(UIColor *);

@property (nonatomic, readonly, copy) LSSingleTextField *(^backColor)(UIColor *);

@property (nonatomic, readonly, copy) LSSingleTextField *(^leftImage)(NSString *, CGFloat height);

@property (nonatomic, readonly, copy) LSSingleTextField *(^border)(UIColor *borderColor, CGFloat borderWidth, CGFloat cornerRadius );

@property (nonatomic, readonly, copy) LSSingleTextField *(^text_font)(UIFont *);

@property (nonatomic, readonly, copy) LSSingleTextField *(^isMe)(BOOL);

@property (nonatomic, readonly, copy) LSSingleTextField *(^action)(ActionText);

@property (nonatomic, readonly, copy) LSSingleTextField *(^leftMargin)(CGFloat);

@property (nonatomic, readonly, copy) LSSingleTextField *(^buttonMode)(UITextFieldViewMode);


@end
