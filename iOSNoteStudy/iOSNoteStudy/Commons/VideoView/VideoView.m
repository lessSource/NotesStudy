//
//  VideoView.m
//  NotesStudy
//
//  Created by Lj on 2018/3/23.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "VideoView.h"
#import "VideoControlView.h"
#import <AVFoundation/AVFoundation.h>

@interface VideoView () <VideoControlViewDelegate>
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVURLAsset *asset;
@property (nonatomic, strong) AVPlayerItem *item;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndeView;
@property (nonatomic, strong) id playbackTimerObserver;
@property (nonatomic, strong) VideoControlView *controlView;

@end

@implementation VideoView

#pragma mark - Lazy
-(UIActivityIndicatorView *)activityIndeView{
    if (!_activityIndeView) {
        _activityIndeView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityIndeView.hidesWhenStopped = YES;
    }
    return _activityIndeView;
}

-(VideoControlView *)controlView{
    if (!_controlView) {
        _controlView = [[VideoControlView alloc]init];
        _controlView.delegate = self;
        _controlView.backgroundColor = [UIColor clearColor];
//        [_controlView.tapGesture requireGestureRecognizerToFail:self.pauseOrPlayView.imageBtn.gestureRecognizers.firstObject];
    }
    return _controlView;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    //首先创建资产AVURLAsset
    NSDictionary *options = @{ AVURLAssetPreferPreciseDurationAndTimingKey : @YES };
    
    NSString *str = @"/Users/lj/Desktop/Document/Video/极乐净土.mp4";

    NSURL *sourceMovieUrl = [NSURL fileURLWithPath:str];

    self.asset = [[AVURLAsset alloc]initWithURL:sourceMovieUrl options:options];
    //使用AVURLAsset然后将asset对象导入到AVPlayerItem中
    self.item = [AVPlayerItem playerItemWithAsset:self.asset];
    //在将item对象添加到AVPlayer中
    self.player = [[AVPlayer alloc]initWithPlayerItem:self.item];
    //比直接使用AVPlayer初始化方法播放URL如
    //self.player=[[AVPlayer alloc]initWithURL:url];
    //的好处是，self.asset可以记录缓存大小，而直接使用AVPlayer初始化URL不利于多个控制器更好的衔接缓存大小。
    
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.bounds;
    [self.layer addSublayer:layer];
    
//    self.player.rate
    [self addSubview:self.activityIndeView];
    [self.activityIndeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.offset(80);
    }];
    
    [self.activityIndeView startAnimating];
    
    [self addPlayerObserver];
    
    [self addObserverWithPlayItem];
    
    [self addNotificatonForPlayer];
    
//    [self.player play];

    [self addSubview:self.controlView];
    [self.controlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        make.width.offset(kScreenWidth);
        make.height.offset(44);
    }];
    
    NSArray *keys = @[@"duration"];
    [self.asset loadValuesAsynchronouslyForKeys:keys completionHandler:^{
        NSError *error = nil;
        AVKeyValueStatus tracksStatus = [self.asset statusOfValueForKey:@"duration" error:&error];
        switch (tracksStatus) {
            case AVKeyValueStatusLoaded: {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (!CMTIME_IS_INDEFINITE(self.asset.duration)) {
                        CGFloat second = self.asset.duration.value / self.asset.duration.timescale;
                        self.controlView.totalTime = [self convertTime:second];
                        self.controlView.minValue = 0;
                        self.controlView.maxValue = second;
                    }
                });
            }
                break;
            case AVKeyValueStatusFailed: {
                NSLog(@"网络失败");
            }
                break;
            case AVKeyValueStatusCancelled: {
                NSLog(@"取消");
            }
                break;
            case AVKeyValueStatusUnknown: {
                NSLog(@"未知");
            }
                break;
            case AVKeyValueStatusLoading: {
                NSLog(@"正在加载....");
            }
                break;
        }
    }];
}

/*
 * rate ==1.0，表示正在播放；rate == 0.0，暂停；rate == -1.0，播放失败
 */
//播放
- (void)play {
    if (self.player.rate == 0) { [self.player play]; }
}

//暂停
- (void)pause {
    if (self.player.rate == 1.0) { [self.player pause]; }
}

//播放|暂停
- (void)playOrPause:(void (^)(BOOL isPlay))block {
    if (self.player.rate == 0) {
        [self.player play];
        block(YES);
    }else if (self.player.rate == 1.0) {
        [self.player pause];
        block(NO);
    }else {
        NSLog(@"播放器出错");
    }
}

#pragma mark -
- (NSString *)convertTime:(CGFloat)second {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (second/3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [formatter stringFromDate:date];
    return showtimeNew;
}

#pragma mark -
- (void)controlView:(VideoControlView *)controlView draggedPositionWithSlider:(UISlider *)slider {
    NSLog(@"%f",controlView.value);
    CMTime pointTime = CMTimeMake(controlView.value * self.item.currentTime.timescale, self.item.currentTime.timescale);
    [self.item seekToTime:pointTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}

#pragma mark - 播放状态
- (void)handlesStatusWithPlayer {
    AVPlayerItemStatus status = self.item.status;
    switch (status) {
        case AVPlayerItemStatusReadyToPlay: //准备好播放
            NSLog(@"准备好播放");
            break;
        case AVPlayerItemStatusFailed: //播放出错
            NSLog(@"播放出错");
            break;
        case AVPlayerItemStatusUnknown: //状态未知
            NSLog(@"状态未知");
            break;
        default:
            break;
    }
}

#pragma mark - 添加 监控
- (void)addPlayerObserver {
    __weak typeof(self)weakSelf = self;
    self.playbackTimerObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
//        CMTimeMake(1,1)表示1秒刷新一次
        float current = CMTimeGetSeconds(time);
        float total = CMTimeGetSeconds([weakSelf.item duration]);
        
        weakSelf.controlView.value = weakSelf.item.currentTime.value/weakSelf.item.currentTime.timescale;
        if (!CMTIME_IS_INDEFINITE(self.asset.duration)) {
            weakSelf.controlView.currentTime = [weakSelf convertTime:weakSelf.controlView.value];
        }
        
        NSLog(@"当前播放进度 %.2f/%.2f.",current,total);
    }];
}

//添加KVO
- (void)addObserverWithPlayItem {
    //监听状态属性
    [self.item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //监听网络加载情况属性
    [self.item addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    //监听播放的区域缓冲是否为空
    [self.item addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
    //缓存可以播放的时候调用
    [self.item addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
}

//移除KVO
- (void)removeObserverWithPlayItem {
    [self.item removeObserver:self forKeyPath:@"status"];
    [self.item removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [self.item removeObserver:self forKeyPath:@"playbackBufferEmpty"];
    [self.item removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
}

//添加关键通知
- (void)addNotificatonForPlayer {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    //视频播放结束通知
    [defaultCenter addObserver:self selector:@selector(videoPlayEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    //视频异常中断通知
    [defaultCenter addObserver:self selector:@selector(videoPlayError:) name:AVPlayerItemPlaybackStalledNotification object:nil];
    //进入后台通知
    [defaultCenter addObserver:self selector:@selector(videoPlayEnterBack:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    //进入前台通知
    [defaultCenter addObserver:self selector:@selector(videoPlayBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

//移除通知
- (void)removeNotification {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [defaultCenter removeObserver:self name:AVPlayerItemPlaybackStalledNotification object:nil];
    [defaultCenter removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [defaultCenter removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

//移除 time observer
- (void)removePlayerObserver {
    [self.player removeTimeObserver:self.playbackTimerObserver];
}

#pragma mark - 事件
//监听事件
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        //播放状态
        [self handlesStatusWithPlayer];
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        //缓冲进度
        NSArray *loadedTimeRanges = [self.item loadedTimeRanges];
        //获取缓冲区域
        CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        //计算缓冲进度
        NSTimeInterval timeInterval = startSeconds + durationSeconds;
        CMTime duration = self.item.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        //缓存值
        self.controlView.bufferValue = timeInterval/totalDuration;
    }else if ([keyPath isEqualToString:@"playbackBufferEmpty"]) {
        //跳转后没有数据
    }else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]) {
        //跳转后有数据
    }
}

/** 通知事件 */
// 视频播放结束
- (void)videoPlayEnd:(NSNotification *)notic {
    NSLog(@"视频播放结束");
    [self.player seekToTime:kCMTimeZero];
}

// 视频播放中断
- (void)videoPlayError:(NSNotification *)notic {
    NSLog(@"视频播放中断");
}

// 进入后台
- (void)videoPlayEnterBack:(NSNotification *)notic {
    NSLog(@"进入后台");
}

// 进入前台
- (void)videoPlayBecomeActive:(NSNotification *)notic {
    NSLog(@"进入前台");
}

- (void)dealloc {
    NSLog(@"video ----- dealloc");
    [self removePlayerObserver];
    [self removeObserverWithPlayItem];
    [self removeNotification];
}

@end

