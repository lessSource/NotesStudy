//
//  AccordingLayerViewController.h
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/17.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "BaseViewController.h"
@class DrawCircle;

@interface AccordingLayerViewController : BaseViewController

@end


@interface DrawCircle : UIView

@property(nonatomic,assign) CGPoint centerPoint;

@property(nonatomic,assign) CGFloat radius;

@property(nonatomic,assign) CGFloat angleValue;　//圆环进度占有的角度，0~360

@property(nonatomic,assign) CGFloat lineWidth;

@property(nonatomic,strong) UIColor *bgLineColor;

@property(nonatomic,strong) UIColor *lineColor;

@end
