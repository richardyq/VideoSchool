//
//  LivePlayerView.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/7.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VideoPlayerView.h"
#import "LivePlayerControl.h"

NS_ASSUME_NONNULL_BEGIN

@interface LivePlayerView : VideoPlayerView

- (void) setStatusText:(NSString*) text;

@end

NS_ASSUME_NONNULL_END
