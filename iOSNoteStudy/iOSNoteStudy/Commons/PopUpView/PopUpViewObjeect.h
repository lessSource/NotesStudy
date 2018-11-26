//
//  PopUpViewObjeect.h
//  NotesStudy
//
//  Created by Lj on 2018/3/16.
//  Copyright © 2018年 lj. All rights reserved.
//

typedef NS_ENUM(NSInteger, PopUpViewDirectionType) {
    PopUpViewDirectionTypeNone,
    PopUpViewDirectionTypeUp,
    PopUpViewDirectionTypeDown,
    PopUpViewDirectionTypeLeft,
    PopUpViewDirectionTypeRight,
    PopUpViewDirectionTypeCenter,
};


#import <Foundation/Foundation.h>
#import "PopUpProtocol.h"

@class ContentView;

@interface PopUpViewObjeect : NSObject

+ (instancetype)sharrPopUpView;

@property (nonatomic, assign) CGFloat maskAlpha;

- (void)presentContentView:(ContentView *)contentView;

- (void)presentContentView:(ContentView *)contentView direction:(PopUpViewDirectionType)dircetionType;

- (void)cancalContentView:(ContentView *)contentView;

- (void)cancalContentView:(ContentView *)contentView direction:(PopUpViewDirectionType)dircetionType;

@end

@interface ContentView: UIView

@property (nonatomic, assign) id <PopUpProtocol> delegate;

- (void)willShowView;

- (void)didShwoView;

- (void)willCancelView;

- (void)didCancelView;

@end

