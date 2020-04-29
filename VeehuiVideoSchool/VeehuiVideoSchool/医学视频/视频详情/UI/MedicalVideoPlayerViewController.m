//
//  MedicalVideoPlayerViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalVideoPlayerViewController.h"

@interface MedicalVideoPlayerViewController ()
<VideoPlayerDelegate, VideoPlayerViewControlDelegate>
@property (nonatomic, strong) UIView* topmostView;
@property (nonatomic) BOOL isOrientationLocked;

@end

@implementation MedicalVideoPlayerViewController

- (void)viewDidLoad {
    self.topmostView.backgroundColor = [UIColor blackColor];
    //self.view.backgroundColor = [UIColor blackColor];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [VideoPlayerUtil shareInstance].delegate = self;
    [[VideoPlayerUtil shareInstance] setupPlayerView:self.playerView];
    
    [self registerScreenRotateNotification];
}

- (void) updateViewConstraints{
    [super updateViewConstraints];
    
    __block CGFloat tableWidth = kScreenWidth;
    if ([UIDevice currentDevice].isPad) {
        tableWidth = kScreenWidth * 0.7;
    }
    __block CGFloat playerHeight = tableWidth * (275./375.);
    
    [self.topmostView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(@(Status_Height));
    }];
    
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(Status_Height);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(@(tableWidth));
        make.height.mas_equalTo(@(playerHeight));
    }];
    
    [self.tableview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.top.equalTo(self.topmostView.mas_bottom);
        make.centerX.equalTo(self.view);
        if ([UIDevice currentDevice].isPad) {
            make.width.equalTo(self.view).multipliedBy(0.7);
        }
        else{
            make.width.equalTo(self.view);
        }
    }];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [VideoPlayerUtil shareInstance].delegate = nil;
    [[VideoPlayerUtil shareInstance] reset];
}

#pragma mark - settingAndGetting
- (UIView*) topmostView{
    if (!_topmostView) {
        _topmostView = [self.view addView];
        _topmostView.backgroundColor;
    }
    return _topmostView;
}

- (VideoPlayerView*) playerView{
    if (!_playerView) {
        _playerView = (VideoPlayerView*)[self.view addView:[VideoPlayerView class]];
        _playerView.controlDelegate = self;
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

- (UIStatusBarStyle) preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - 屏幕旋转
- (void) registerScreenRotateNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didChangeRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
}

- (void)didChangeRotate:(NSNotification*)notice {
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    [self changeOrientationPortrait:orientation];
    
}

- (void) changeOrientationPortrait:(UIDeviceOrientation) orientation{
    NSLog(@"屏幕旋转事件捕获：%ld", orientation);
    if (self.isOrientationLocked) {
        //已上锁，不再支持旋转
        return;
    }
    switch (orientation) {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:{
            //竖屏
            [self closeFullScreenPlayerView];
            break;
        }
        case UIDeviceOrientationLandscapeLeft:{
            //左旋
            [self showFullScreenPlayerView:orientation];
            break;
        }
        case UIDeviceOrientationLandscapeRight:{
            //右旋
            [self showFullScreenPlayerView:orientation];
            break;
        }
        default:
            [self closeFullScreenPlayerView];
            return;
            break;
    }
}

- (void) showFullScreenPlayerView:(UIDeviceOrientation) orientation{
    __block VideoFullPlayerViewController* fullController = nil;
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull controller, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([controller isKindOfClass:[VideoFullPlayerViewController class]] ||
            [controller isMemberOfClass:[VideoFullPlayerViewController class]]) {
            fullController = controller;
            *stop = YES;
        }
    }];
    if (fullController) {
        return;
    }
    WS(weakSelf)
    [VideoFullPlayerViewController showWithOrientation:orientation originalFrame:self.playerView.frame closeAction:^{
        SAFE_WEAKSELF(weakSelf)
        [[VideoPlayerUtil shareInstance] setupPlayerView:weakSelf.playerView];
    }];
}

- (void) closeFullScreenPlayerView{
    __block VideoFullPlayerViewController* fullController = nil;
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull controller, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([controller isKindOfClass:[VideoFullPlayerViewController class]] ||
            [controller isMemberOfClass:[VideoFullPlayerViewController class]]) {
            fullController = controller;
            *stop = YES;
        }
    }];
    if (fullController) {
       //[fullController.view removeFromSuperview];
        [fullController startCloseFull];
    }
    //[[VideoPlayerUtil shareInstance] setupPlayerView:self.playerView];
    [[VideoPlayerUtil shareInstance] setOrientation:UIInterfaceOrientationPortrait];
}

#pragma mark VideoPlayerViewControlDelegate
- (void) fullScreenButtonAction{
    [self changeOrientationPortrait:UIDeviceOrientationLandscapeLeft];
}
@end
