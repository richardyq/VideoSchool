//
//  VideoFullPlayerView.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/29.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VideoFullPlayerView.h"
#import "VideoFullPlayerControl.h"

@implementation VideoFullPlayerView

- (Class) controlClass{
    return [VideoFullPlayerControl class];
}

@end
