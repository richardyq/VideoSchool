//
//  LivePlayerView.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/7.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "LivePlayerView.h"


@implementation LivePlayerView

- (Class) controlClass{
    return [LivePlayerControl class];
}

- (void) setStatusText:(NSString*) text{
    ((LivePlayerControl*) self.playerControl).statusLabel.text = text;
}

@end
