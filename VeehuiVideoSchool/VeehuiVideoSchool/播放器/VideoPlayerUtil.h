//
//  VideoPlayerUtil.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, VideoPlayerState) {
    PlayerState_None,
    PlayerState_Playing,
    PlayerState_Pause,
    PlayerState_PlayEnd,
};

@protocol VideoPlayerDelegate <NSObject>

- (void) playerEventChanged:(NSInteger) event;
//播放进度
- (void) playerPositionChanged:(NSInteger) position;
- (void) playerDurationLoaded:(NSInteger) duration;
@end

@interface VideoPlayerUtil : NSObject

@property (nonatomic, weak) id<VideoPlayerDelegate> delegate;
@property (nonatomic, readonly) VideoPlayerState playerState;

+ (instancetype)shareInstance;

- (void) setupPlayerModel:(VideoPlayerModel*) playerModel;
- (void) setPlayerStartPositon:(NSInteger) startPos;
- (void) setupPlayerView:(UIView*) playerView;


- (void) startPlay;
- (void) pause;
- (void) reset;
@end

NS_ASSUME_NONNULL_END
