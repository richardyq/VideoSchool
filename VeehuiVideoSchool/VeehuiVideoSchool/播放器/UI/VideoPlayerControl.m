//
//  VideoPlayerControl.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VideoPlayerControl.h"

@interface VHPlayerSlider : UISlider

@end

@implementation VHPlayerSlider

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    CGRect t = [self trackRectForBounds: [self bounds]];

    float v = [self minimumValue] + ([[touches anyObject] locationInView: self].x - t.origin.x - 4.0) * (([self maximumValue]-[self minimumValue]) / (t.size.width - 8.0));

    [self setValue: v];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    [super touchesBegan: touches withEvent: event];

}

@end

@implementation VideoPlayerControl

- (id) init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"00000064"];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    
    [self layoutElements];
}

- (void) layoutElements{
    [self.playAndPauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.left.equalTo(self).offset(11);
        make.bottom.equalTo(self).offset(-7.5);
    }];

    [self.fullScreenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.right.equalTo(self).offset(-11);
        make.bottom.equalTo(self).offset(-7.5);
    }];
    
    [self.progressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.playAndPauseButton);
        make.left.equalTo(self.playAndPauseButton.mas_right).offset(15);
        make.right.equalTo(self.fullScreenButton.mas_left).offset(-15);
    }];
    
    [self.positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.progressSlider);
        make.bottom.equalTo(self.progressSlider.mas_top);
    }];
    
    [self.durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.progressSlider);
        make.bottom.equalTo(self.progressSlider.mas_top);
    }];
}

#pragma mark - settingAndGetting

- (UIButton*) playAndPauseButton{
    if (!_playAndPauseButton) {
        _playAndPauseButton = [self addButtonWithImageName:@"ic_video_pause_button"];
        [_playAndPauseButton addTarget:self action:@selector(playAndPauseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playAndPauseButton;
}

- (UIButton*) fullScreenButton{
    if (!_fullScreenButton) {
        _fullScreenButton = [self addButtonWithImageName:@"ic_video_fullscreen_button"];
        [_fullScreenButton addTarget:self action:@selector(fullScreenButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullScreenButton;
}

- (UISlider*) progressSlider{
    if (!_progressSlider) {
        _progressSlider = [[VHPlayerSlider alloc] init];
        [self addSubview:_progressSlider];
        _progressSlider.thumbTintColor = [UIColor mainThemeColor];
        _progressSlider.maximumTrackTintColor = [UIColor whiteColor];
        _progressSlider.minimumTrackTintColor = [UIColor mainThemeColor];
        
        [_progressSlider setThumbImage:[UIImage imageNamed:@"ic_video_position"] forState:UIControlStateNormal];
        [_progressSlider setThumbImage:[UIImage imageNamed:@"ic_video_position"] forState:UIControlStateHighlighted];
        [_progressSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _progressSlider;
}

- (UILabel*) positionLabel{
    if (!_positionLabel) {
        _positionLabel = [self addLabel:[UIColor whiteColor] textSize:13];
        _positionLabel.text = @"00:00";
    }
    return _positionLabel;
}

- (UILabel*) durationLabel{
    if (!_durationLabel) {
        _durationLabel = [self addLabel:[UIColor whiteColor] textSize:13];
        _durationLabel.text = @"00:00";
    }
    return _durationLabel;
}

- (void) setPlayPosition:(NSInteger)playPosition{
    _playPosition = playPosition;
    [self.progressSlider setValue:playPosition];
    self.positionLabel.text = [NSString stringWithDuration:playPosition];
}

- (void) setDuration:(NSInteger)duration{
    _duration = duration;
    self.progressSlider.minimumValue = 0.0;//下限
    self.progressSlider.maximumValue = duration;//上限
    self.progressSlider.continuous = YES;
    
    self.durationLabel.text = [NSString stringWithDuration:duration];
}

#pragma mark - events
- (void) playAndPauseButtonClicked:(id) sender{
    if ([VideoPlayerUtil shareInstance].playerState == PlayerState_Playing) {
        [[VideoPlayerUtil shareInstance] pause];
        [self.playAndPauseButton setImage:[UIImage imageNamed:@"ic_video_play_button"] forState:UIControlStateNormal];
    }
    else{
         [[VideoPlayerUtil shareInstance] startPlay];
        [self.playAndPauseButton setImage:[UIImage imageNamed:@"ic_video_pause_button"] forState:UIControlStateNormal];
    }
    
}

- (void) setVideoIsPlaying:(BOOL) isPlaying{
    if (!isPlaying) {
        [self.playAndPauseButton setImage:[UIImage imageNamed:@"ic_video_play_button"] forState:UIControlStateNormal];
    }
    else{
        
        [self.playAndPauseButton setImage:[UIImage imageNamed:@"ic_video_pause_button"] forState:UIControlStateNormal];
    }
}

- (void) fullScreenButtonClicked:(id) sender{
    
}

- (void) sliderValueChanged:(id) sender{
    NSInteger position = self.progressSlider.value;
    NSLog(@"手动更改播放进度: %ld", position);
    
    [self setPlayPosition:position];
    //[[HSVideoPlayerHelper shareInstance] setPosition:position];
    [[VideoPlayerUtil shareInstance] setPlayerStartPositon:position];
}
@end
