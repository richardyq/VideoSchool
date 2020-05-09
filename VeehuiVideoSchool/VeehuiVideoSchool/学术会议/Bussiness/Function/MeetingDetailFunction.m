//
//  MeetingDetailFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/30.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingDetailFunction.h"
#import "MeetingDetailModel.h"

@interface MeetingDetailFunction ()



@end

@implementation MeetingDetailFunction

- (id) initWithMeetingId:(NSInteger) meetingId{
    self = [super init];
    if (self) {
        _meetingId = meetingId;
    }
    return self;
}

- (NSString*) requestUrl{
    //return [NSString stringWithFormat:@"%@/v2/m/meetingGather", kURL_BASE_NEWDOMAIN];  liveAndPreviewCount
    return [NSString stringWithFormat:@"%@/v3/um/meeting/%ld", kURL_BASE_NEWDOMAIN, self.meetingId];
}

- (id) reqeustDictionary{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setValue:@(self.meetingId) forKey:@"meetingId"];
    return dict;
}

- (id) paraserResponse:(id) response{
    if (response && [response isKindOfClass:[NSDictionary class]]) {
        return [MeetingDetailModel mj_objectWithKeyValues:response];
    }
    return nil;
}


@end
