//
//  AliPlayerHeader.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#ifndef AliPlayerHeader_h
#define AliPlayerHeader_h

#import "VideoPlayerModel.h"
#import "VideoPlayerUtil.h"
#import "VideoPlayerView.h"
#import "VideoFullPlayerViewController.h"
#import "LivePlayerView.h"
#import "LiveFullPlayerView.h"
#import "LiveFullPlayerViewController.h"

//阿里云播放器
#import <AliyunPlayer/AliyunPlayer.h>

typedef NS_ENUM(NSUInteger, VideoPlayerEvent) {
    VideoPlayer_None,
    VideoPlayer_Prepared,       //准备好
    VideoPlayer_Seeked,         //完成定位
    VideoPlayer_Playing,        //正在播放
    VideoPlayer_Paused,         //暂停
    VideoPlayer_StartLoad,
    VideoPlayer_EndLoad,
    VideoPlayer_PlayEnd,        //播放完成
};



#endif /* AliPlayerHeader_h */
