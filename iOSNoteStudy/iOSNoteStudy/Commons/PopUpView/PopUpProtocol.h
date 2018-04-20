//
//  PopUpProtocol.h
//  NotesStudy
//
//  Created by Lj on 2018/3/15.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PopUpProtocol <NSObject>

@optional
- (void)canclePopUpView:(UIView *)popUpView;

- (void)selectViewData:(id)data showView:(UIView *)view;

@end
