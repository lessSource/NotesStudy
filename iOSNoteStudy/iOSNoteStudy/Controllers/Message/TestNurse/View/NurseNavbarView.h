//
//  NurseNavbarView.h
//  iOSNoteStudy
//
//  Created by less on 2019/1/17.
//  Copyright © 2019 lj. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol NurseNavbarViewDelegate <NSObject>

@optional
- (void)nurseNavbarSelect:(NSInteger)row;

@end


NS_ASSUME_NONNULL_BEGIN

@interface NurseNavbarView : UIView

@property (nonatomic, assign) id <NurseNavbarViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
