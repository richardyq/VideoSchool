//
//  MeetingReplayDetailFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/30.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingReplayDetailFunction.h"

@implementation MeetingReplayDetailFunction

- (NSString*) requestUrl{
    //return [NSString stringWithFormat:@"%@/v2/m/meetingGather", kURL_BASE_NEWDOMAIN];  liveAndPreviewCount
    return [NSString stringWithFormat:@"%@/v3/um/replayMeetingInfo/%ld", kURL_BASE_NEWDOMAIN, self.meetingId];
}
@end
