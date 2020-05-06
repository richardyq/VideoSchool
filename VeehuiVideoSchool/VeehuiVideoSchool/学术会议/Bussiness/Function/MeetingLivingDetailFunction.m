//
//  MeetingLivingDetailFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/6.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingLivingDetailFunction.h"

@implementation MeetingLivingDetailFunction

- (NSString*) requestUrl{
    //return [NSString stringWithFormat:@"%@/v2/m/meetingGather", kURL_BASE_NEWDOMAIN];  liveAndPreviewCount
    return [NSString stringWithFormat:@"%@/v3/um/meeting/%ld", kURL_BASE_NEWDOMAIN, self.meetingId];
}
@end
