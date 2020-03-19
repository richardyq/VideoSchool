//
//  VideoPlayerView.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoPlayerControl.h"
NS_ASSUME_NONNULL_BEGIN

@interface VideoPlayerView : UIView

@property (nonatomic, readonly) VideoPlayerControl* playerControl;      //控制器

- (void) setPlayPosition:(NSInteger)playPosition;
- (void) setDuration:(NSInteger)duration;

- (void) setVideoIsPlaying:(BOOL) isPlaying;
@end

NS_ASSUME_NONNULL_END
