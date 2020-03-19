//
//  VideoPlayerView.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VideoPlayerView.h"
#import "VideoPlayerControl.h"

@interface VideoPlayerView ()

@property (nonatomic, readonly) UITapGestureRecognizer *tapGesturRecognizer;

@end

@implementation VideoPlayerView

@synthesize playerControl = _playerControl;

- (id) init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        _tapGesturRecognizer =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:self.tapGesturRecognizer];
    }
    return self;
}

- (Class) controlClass{
    return [VideoPlayerControl class];
}

- (VideoPlayerControl*) playerControl{
    if (!_playerControl) {
        _playerControl = (VideoPlayerControl*)[self addView:[self controlClass]];
        [_playerControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        _playerControl.hidden = YES;
        [self.playerControl addTarget:self action:@selector(closeControl) forControlEvents:UIControlEventAllTouchEvents];
        
    }
    return _playerControl;
}

#pragma mark -
-(void)tapAction:(id)tap{
    //显示控制器
    if (self.playerControl.hidden) {
        self.playerControl.hidden = NO;
        [self removeGestureRecognizer:self.tapGesturRecognizer];
    }
    
}

- (void) closeControl{
    if (!self.playerControl.hidden) {
        self.playerControl.hidden = YES;
        [self addGestureRecognizer:self.tapGesturRecognizer];
    }
}

- (void) setPlayPosition:(NSInteger)playPosition{
    self.playerControl.playPosition = playPosition;
}

- (void) setDuration:(NSInteger)duration{
    self.playerControl.duration = duration;
}

- (void) setVideoIsPlaying:(BOOL) isPlaying{
    [self.playerControl setVideoIsPlaying:isPlaying];
}
@end
