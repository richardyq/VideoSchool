//
//  MeetingPlayerViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/30.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingPlayerViewController.h"

@interface MeetingPlayerViewController ()
<VideoPlayerDelegate, VideoPlayerViewControlDelegate>
@property (nonatomic, strong) UIView* topmostView;

@property (nonatomic, strong) VHNavigationBarView* navigationBarView;
@property (nonatomic, strong) UIView* tableHeaderView;

@property (nonatomic) BOOL isOrientationLocked;
@end

@implementation MeetingPlayerViewController

- (id) initWithMeetingDetail:(MeetingDetailModel*) detail{
    self = [super init];
    if (self) {
        _meetingDetail = detail;
    }
    return self;
}

- (void)viewDidLoad {
    self.topmostView.backgroundColor = [UIColor blackColor];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setFd_interactivePopDisabled:YES];
    [self setFd_prefersNavigationBarHidden:YES];
    
    [self.tableview setTableHeaderView:self.tableHeaderView];
    self.tableview.mj_header = nil;
    
    [self registerScreenRotateNotification];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [VideoPlayerUtil shareInstance].delegate = self;
    [[VideoPlayerUtil shareInstance] setupPlayerView:self.playerView];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [VideoPlayerUtil shareInstance].delegate = nil;
    [[VideoPlayerUtil shareInstance] reset];
}

- (void) updateViewConstraints{
    [super updateViewConstraints];

    __block CGFloat tableWidth = kScreenWidth;
    if ([UIDevice currentDevice].isPad) {
        tableWidth = kScreenWidth * 0.7;
    }
    __block CGFloat playerHeight = tableWidth * (225./375.);

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
    
    [self.navigationBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(@(Navi_height));
    }];
}

#pragma mark - settingAndGetting
- (UIView*) topmostView{
    if (!_topmostView) {
        _topmostView = [self.view addView];
        _topmostView.backgroundColor = [UIColor blackColor];
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

- (VHNavigationBarView*) navigationBarView{
    if (!_navigationBarView) {
        _navigationBarView = [[VHNavigationBarView alloc] initWithNavigationType:Navigation_Trans];
        [self.view addSubview:_navigationBarView];
    }
    return _navigationBarView;
}

- (UIView*) tableHeaderView{
    if (!_tableHeaderView) {
        CGFloat headerHeight = kScreenWidth * (225. / 375.);
        if ([[UIDevice currentDevice] isPad]) {
            headerHeight = kScreenWidth * 0.7 * (225. / 375.);
        }
        //headerHeight -= Status_Height;
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, headerHeight)];
        _tableHeaderView.backgroundColor = [UIColor whiteColor];
    }
    return _tableHeaderView;
}

#pragma mark - DZNEmptyDataSetDelegate
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return NO;
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
