//
//  VideoView.h
//  NotesStudy
//
//  Created by Lj on 2018/3/23.
//  Copyright © 2018年 lj. All rights reserved.
//

typedef NS_ENUM(NSInteger, AVPlayerStatusType) {
    AVPlayerStatusTypeReadyPlay,    //准备好视频
    AVPlayerStatusTypeLoadingView,  //加载视频
    AVPlayerStatusTypePlayEnd,      //播放结束
    AVPlayerStatusTypeCacheData,    //缓冲视频
    AVPlayerStatusTypeCacheEnd,     //缓冲结束
    AVPlayerStatusTypePlayStop,     //播放中断
    AVPlayerStatusTypeItemFailed,   //资源问题
    AVPlayerStatusTypeEnterBack,    //进入后台
    AVPlayerStatusTypeBecomeActive, //从后台返回
};



#import <UIKit/UIKit.h>

@interface VideoView : UIView

@end
