//
//  VideoPlayerUtil.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VideoPlayerUtil.h"

@interface VideoPlayerUtil ()
<AVPDelegate>
@property (nonatomic, strong) AliPlayer* aliPlayer;

@end

@implementation VideoPlayerUtil

+ (instancetype)shareInstance{
    static VideoPlayerUtil *_isntance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _isntance=[[VideoPlayerUtil alloc] init];
    });
    return _isntance;
}

- (id) init{
    self = [super init];
    if (self) {
        _aliPlayer = [[AliPlayer alloc] init];
        _aliPlayer.delegate = self;
    }
    return self;
}

- (void) setupPlayerModel:(VideoPlayerModel*) playerModel{
    
    //准备播放
    AVPUrlSource* source = [[AVPUrlSource new] urlWithString:playerModel.playerUrl];
    source.title = playerModel.title;
    [self.aliPlayer setUrlSource:source];
    [self.aliPlayer prepare];
    _playerState = PlayerState_None;
}

- (void) setPlayerStartPositon:(NSInteger) startPos{
    [self.aliPlayer seekToTime:startPos * 1000 seekMode:AVP_SEEKMODE_INACCURATE];
}

- (void) setupPlayerView:(VideoPlayerView*) playerView{
    self.aliPlayer.playerView = playerView;
    [playerView setDuration:self.aliPlayer.duration / 1000];
    [playerView setPlayPosition:self.aliPlayer.currentPosition / 1000];
    BOOL isPlaying = (self.playerState == PlayerState_Playing);
    [playerView setVideoIsPlaying:isPlaying];
}

- (void) setOrientation:(UIDeviceOrientation)orientation{
    _orientation = orientation;
    switch (orientation) {
        case UIDeviceOrientationPortrait:
            [self.aliPlayer setRotateMode:AVP_ROTATE_0];
            break;
        case UIDeviceOrientationLandscapeLeft:
            [self.aliPlayer setRotateMode:AVP_ROTATE_90];
            break;
        case UIDeviceOrientationLandscapeRight:
            [self.aliPlayer setRotateMode:AVP_ROTATE_270];
            break;
        default:
            [self.aliPlayer setRotateMode:AVP_ROTATE_0];
            break;
    }
}

#pragma mark - AVPDelegate
-(void)onPlayerEvent:(AliPlayer*)player eventType:(AVPEventType)eventType{
    switch (eventType) {
        case AVPEventPrepareDone:{
            //初始化完成
            NSLog(@"VideoPlayerUtil PrepareDone ....");
            if (self.delegate && [self.delegate respondsToSelector:@selector(playerEventChanged:)] ) {
                [self.delegate playerEventChanged:VideoPlayer_Prepared];
            }
            NSInteger duration = self.aliPlayer.duration / 1000;
            if (self.delegate && [self.delegate respondsToSelector:@selector(playerDurationLoaded:)] ) {
                [self.delegate playerDurationLoaded:duration];
            }
            break;
        }
        case AVPEventSeekEnd:{
            //完成定位
            if (self.delegate && [self.delegate respondsToSelector:@selector(playerEventChanged:)] ) {
                [self.delegate playerEventChanged:VideoPlayer_Seeked];
            }
        }
        case AVPEventAutoPlayStart:
        case AVPEventFirstRenderedStart:{
            return;
            if (self.playerState == PlayerState_PlayEnd) {
                
            }
            //开始播放
            _playerState = PlayerState_Playing;
            if (self.delegate && [self.delegate respondsToSelector:@selector(playerEventChanged:)] ) {
                [self.delegate playerEventChanged:VideoPlayer_Playing];
            }
            break;
        }
        case AVPEventCompletion:{
            _playerState = PlayerState_PlayEnd;
            //播放结束
            if (self.delegate && [self.delegate respondsToSelector:@selector(playerEventChanged:)] ) {
                [self.delegate playerEventChanged:VideoPlayer_PlayEnd];
            }
                break;
        }
        default:
            break;
    }
}

- (void)onCurrentPositionUpdate:(AliPlayer*)player position:(int64_t)position {
// 更新进度条
    NSInteger pos = position / 1000;
    VideoPlayerView* playerView = self.aliPlayer.playerView;
    if (playerView && [playerView isKindOfClass:[VideoPlayerView class]]) {
        [playerView setPlayPosition:pos];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(playerPositionChanged:)] ) {
        [self.delegate playerPositionChanged:pos];
    }
}

#pragma mark - 播放器控制
- (void) startPlay{
    [self.aliPlayer start];
    _playerState = PlayerState_Playing;
    if (self.delegate && [self.delegate respondsToSelector:@selector(playerEventChanged:)] ) {
        [self.delegate playerEventChanged:VideoPlayer_Playing];
    }
}

- (void) pause{
    [self.aliPlayer pause];
    _playerState = PlayerState_Pause;
    if (self.delegate && [self.delegate respondsToSelector:@selector(playerEventChanged:)] ) {
        [self.delegate playerEventChanged:VideoPlayer_Paused];
    }
}

- (void) reset{
    [self.aliPlayer reset];
}
@end
