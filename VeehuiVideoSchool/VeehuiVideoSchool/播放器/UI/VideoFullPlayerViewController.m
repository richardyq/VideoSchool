//
//  VideoFullPlayerViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/29.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VideoFullPlayerViewController.h"

@interface VideoFullPlayerViewController ()

@property (nonatomic) UIDeviceOrientation orientation;
@property (nonatomic) CGRect originalFrame;

//@property (nonatomic, strong) VideoPlayerView* playerView;

@property (nonatomic, copy) FullPlayerClosedAction closeAction;

@end

@implementation VideoFullPlayerViewController

+ (void) showWithOrientation:(UIDeviceOrientation) orientation
               originalFrame:(CGRect) frame
                 closeAction:(FullPlayerClosedAction) closeAction{
        //parentViewController:(UIViewController*) parentViewController{
    VideoFullPlayerViewController* fullViewController = [[[self class] alloc] initWithOrientation:orientation originalFrame:frame closeAction:closeAction];
    UIViewController* topmostController = [NSObject topMostController];
    [topmostController addChildViewController:fullViewController];
    [topmostController.view addSubview:fullViewController.view];
    
    [fullViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(topmostController.view);
    }];
    
}

- (id) initWithOrientation:(UIDeviceOrientation) orientation
             originalFrame:(CGRect) frame
               closeAction:(FullPlayerClosedAction) closeAction{
    self = [super init];
    if (self) {
        _orientation = orientation;
        _originalFrame = frame;
        _closeAction = closeAction;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor commonTransColor];
    [[VideoPlayerUtil shareInstance] setupPlayerView:self.playerView];
    [self startShowFull];
}

#pragma mark - settingAndGetting
- (VideoPlayerView*) playerView{
    if (!_playerView) {
        _playerView = (VideoPlayerView*)[self.view addView:[self playerViewClass] frame:self.originalFrame];
        _playerView.backgroundColor = [UIColor blackColor];
        _playerView.controlDelegate = self;
    }
    
    return _playerView;
}

- (Class) playerViewClass{
    return [VideoFullPlayerView class];
}

#pragma mark - 旋转动画
- (void) startShowFull{
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(90 *M_PI / 180.0);
    if (self.orientation == UIDeviceOrientationLandscapeRight) {
        transform = CGAffineTransformMakeRotation(-90 *M_PI / 180.0);
    }
    WS(weakSelf)
    [UIView animateWithDuration:0.22 animations:^{
        SAFE_WEAKSELF(weakSelf)
        [weakSelf.playerView setFrame:CGRectMake((kScreenWidth - kScreenHeight) / 2, (kScreenHeight - kScreenWidth) / 2, kScreenHeight, kScreenWidth)];
        [weakSelf.playerView setTransform:transform];
    } completion:^(BOOL finished) {
        
    }];
}

- (void) startCloseFull{
    WS(weakSelf)
    [UIView animateWithDuration:0.22 animations:^{
        SAFE_WEAKSELF(weakSelf)
        
        [weakSelf.playerView setTransform:CGAffineTransformIdentity];
        [weakSelf.playerView setFrame:self.originalFrame];
    } completion:^(BOOL finished) {
        SAFE_WEAKSELF(weakSelf)
        [weakSelf closeController];
        if (weakSelf.closeAction) {
            weakSelf.closeAction();
        }
    }];
}

- (void) closeController{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

#pragma mark VideoPlayerViewControlDelegate
- (void) fullScreenButtonAction{
    [self startCloseFull];
}

@end
