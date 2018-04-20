//
//  VideoControlView.h
//  NotesStudy
//
//  Created by Lj on 2018/3/23.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VideoControlView;

@protocol VideoControlViewDelegate <NSObject>
@required
/**
 拖拽UISlider的knob的时间响应代理方法
 
 @param slider UISlider
 */
-(void)controlView:(VideoControlView *)controlView draggedPositionWithSlider:(UISlider *)slider ;


@end

@interface VideoControlView : UIView

//进度条当前值
@property (nonatomic,assign) CGFloat value;
//最小值
@property (nonatomic,assign) CGFloat minValue;
//最大值
@property (nonatomic,assign) CGFloat maxValue;
//当前时间
@property (nonatomic,copy) NSString *currentTime;
//总时间
@property (nonatomic,copy) NSString *totalTime;
//缓存条当前值
@property (nonatomic,assign) CGFloat bufferValue;

@property (nonatomic,weak) id<VideoControlViewDelegate> delegate;

@end
