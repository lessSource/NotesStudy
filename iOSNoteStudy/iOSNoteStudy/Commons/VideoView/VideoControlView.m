//
//  VideoControlView.m
//  NotesStudy
//
//  Created by Lj on 2018/3/23.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "VideoControlView.h"

@interface VideoControlView ()
//当前时间
@property (nonatomic,strong) UILabel *timeLabel;
//总时间
@property (nonatomic,strong) UILabel *totalTimeLabel;
//进度条
@property (nonatomic,strong) UISlider *slider;
//缓存进度条
@property (nonatomic,strong) UISlider *bufferSlier;

@end

static NSInteger padding = 8;

@implementation VideoControlView

#pragma mark - Lazy
- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.text = @"00:00";
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor whiteColor];
    }
    return _timeLabel;
}

- (UILabel *)totalTimeLabel{
    if (_totalTimeLabel == nil) {
        _totalTimeLabel = [[UILabel alloc]init];
        _totalTimeLabel.textAlignment = NSTextAlignmentLeft;
        _totalTimeLabel.font = [UIFont systemFontOfSize:12];
        _totalTimeLabel.textColor = [UIColor whiteColor];
    }
    return _totalTimeLabel;
}

- (UISlider *)slider{
    if (_slider == nil) {
        _slider = [[UISlider alloc]init];
//        [_slider setThumbImage:[UIImage imageNamed:@"knob"] forState:UIControlStateNormal];
        _slider.continuous = YES;
//        self.tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        [_slider addTarget:self action:@selector(handleSliderPosition:) forControlEvents:UIControlEventValueChanged];
//        [_slider addGestureRecognizer:self.tapGesture];
        _slider.maximumTrackTintColor = [UIColor clearColor];
        _slider.minimumTrackTintColor = [UIColor whiteColor];
    }
    return _slider;
}

- (UISlider *)bufferSlier{
    if (_bufferSlier == nil) {
        _bufferSlier = [[UISlider alloc]init];
        [_bufferSlier setThumbImage:[UIImage new] forState:UIControlStateNormal];
        _bufferSlier.continuous = YES;
        _bufferSlier.minimumTrackTintColor = [UIColor redColor];
        _bufferSlier.minimumValue = 0.f;
        _bufferSlier.maximumValue = 1.f;
        _bufferSlier.userInteractionEnabled = NO;
    }
    return _bufferSlier;
}

- (id)init {
    if (self = [super init]) {
        [self setUpUI];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
//    [self setUpUI];
}

- (void)setUpUI {
    [self addSubview:self.timeLabel];
    [self addSubview:self.bufferSlier];
    [self addSubview:self.slider];
    [self addSubview:self.totalTimeLabel];
    [self viewLayout];
}

- (void)viewLayout {
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(- padding);
        make.right.equalTo(self.slider).offset(- padding).priorityLow();
        make.width.offset(50);
    }];
    
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel.mas_right).offset(padding);
        make.right.equalTo(self.totalTimeLabel.mas_left).offset(- padding);
        make.width.offset(kScreenWidth - padding * 2 - 100);
        make.centerY.equalTo(self.timeLabel);
    }];
    
    [self.totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.slider.mas_right).offset(padding);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom).offset(- padding);
        make.width.offset(50).priorityHigh();
    }];

    [self.bufferSlier mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.slider);
    }];
}

#pragma mark - set
- (void)setValue:(CGFloat)value {
    _value = value;
    self.slider.value = value;
}

- (void)setMinValue:(CGFloat)minValue {
    _minValue = minValue;
    self.slider.minimumValue = minValue;
}

- (void)setMaxValue:(CGFloat)maxValue {
    _maxValue = maxValue;
    self.slider.maximumValue = maxValue;
}

- (void)setCurrentTime:(NSString *)currentTime {
    _currentTime = currentTime;
    self.timeLabel.text = currentTime;
}

- (void)setTotalTime:(NSString *)totalTime {
    _totalTime = totalTime;
    self.totalTimeLabel.text = totalTime;
}

- (void)setBufferValue:(CGFloat)bufferValue {
    _bufferValue = bufferValue;
    self.bufferSlier.value = bufferValue;
}

#pragma mark -
-(void)handleSliderPosition:(UISlider *)slider{
    if ([self.delegate respondsToSelector:@selector(controlView:draggedPositionWithSlider:)]) {
        [self.delegate controlView:self draggedPositionWithSlider:self.slider];
    }
}


@end
