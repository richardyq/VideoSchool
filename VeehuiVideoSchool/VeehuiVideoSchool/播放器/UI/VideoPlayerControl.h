//
//  VideoPlayerControl.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoPlayerControl.h"
NS_ASSUME_NONNULL_BEGIN

@interface VideoPlayerControl : UIControl

@property (nonatomic, strong) UIButton* playAndPauseButton;
@property (nonatomic, strong) UIButton* fullScreenButton;
@property (nonatomic, strong) UISlider* progressSlider;     //播放进度条

@property (nonatomic, strong) UILabel* positionLabel;
@property (nonatomic, strong) UILabel* durationLabel;

@property (nonatomic) NSInteger duration;
@property (nonatomic) NSInteger playPosition;

- (void) setVideoIsPlaying:(BOOL) isPlaying;

@end

NS_ASSUME_NONNULL_END
