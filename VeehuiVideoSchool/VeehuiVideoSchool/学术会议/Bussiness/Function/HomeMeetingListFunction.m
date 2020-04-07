//
//  HomeMeetingListFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/27.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "HomeMeetingListFunction.h"

@implementation HomeMeetingListFunction

- (NSString*) requestUrl{
    //return [NSString stringWithFormat:@"%@/v2/m/meetingGather", kURL_BASE_NEWDOMAIN];  liveAndPreviewCount
    return [NSString stringWithFormat:@"%@/v3/m/meetingInfoInHomePage", kURL_BASE_NEWDOMAIN];
}

- (id) paraserResponse:(id) response{
    if (response && [response isKindOfClass:[NSDictionary class]]) {
        HomeMeetingInfo* info = [HomeMeetingInfo mj_objectWithKeyValues:response];
        return info;
    }
    return nil;
}
@end
