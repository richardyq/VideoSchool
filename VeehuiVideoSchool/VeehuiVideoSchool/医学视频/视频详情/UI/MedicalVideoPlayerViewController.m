//
//  MedicalVideoPlayerViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalVideoPlayerViewController.h"

@interface MedicalVideoPlayerViewController ()
<VideoPlayerDelegate>
@end

@implementation MedicalVideoPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [VideoPlayerUtil shareInstance].delegate = self;
    [[VideoPlayerUtil shareInstance] setupPlayerView:self.playerView];
}

- (void) updateViewConstraints{
    [super updateViewConstraints];
    
    __block CGFloat tableWidth = kScreenWidth;
    if ([UIDevice currentDevice].isPad) {
        tableWidth = kScreenWidth * 0.7;
    }
    __block CGFloat playerHeight = tableWidth * (275./375.);
    
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(Status_Height);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(@(tableWidth));
        make.height.mas_equalTo(@(playerHeight));
    }];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [VideoPlayerUtil shareInstance].delegate = nil;
    [[VideoPlayerUtil shareInstance] reset];
}

#pragma mark - settingAndGetting
- (VideoPlayerView*) playerView{
    if (!_playerView) {
        _playerView = (VideoPlayerView*)[self.view addView:[VideoPlayerView class]];
    }
    return _playerView;
}

- (void) playerPrepared{
    if (self.playerModel.startPosition == 0) {
        //直接开始播放
        [[VideoPlayerUtil shareInstance] startPlay];
    }
    else{
        //定位
        [[VideoPlayerUtil shareInstance] setPlayerStartPositon:self.playerModel.startPosition];
        if ([VideoPlayerUtil shareInstance].playerState == PlayerState_None) {
            [[VideoPlayerUtil shareInstance] startPlay];
        }
    }
}

#pragma mark - VideoPlayerDelegate
- (void) playerEventChanged:(NSInteger) event{
    switch (event) {
        case VideoPlayer_Prepared:{
            [self playerPrepared];
            break;
        }
        case VideoPlayer_Seeked:{
            if ([VideoPlayerUtil shareInstance].playerState == PlayerState_None) {
                //还没有开始播放，开始播放
                [[VideoPlayerUtil shareInstance] startPlay];
            }
             
            break;
        }
        case VideoPlayer_Playing:{
            [self.playerView setVideoIsPlaying:YES];
            break;
        }
        case VideoPlayer_PlayEnd:{
            //播放信息
            [self.playerView setVideoIsPlaying:NO];
            //重新定位到0
            [[VideoPlayerUtil shareInstance] setPlayerStartPositon:0];
            break;
        }
        default:
            break;
    }
}

//播放进度
- (void) playerPositionChanged:(NSInteger) position{
    self.playerModel.startPosition = position;
    
    [self.playerView setPlayPosition:position];
}

- (void) playerDurationLoaded:(NSInteger) duration{
    self.playerModel.duration = duration;
    [self.playerView setDuration:duration];
}

@end
