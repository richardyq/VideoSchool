//
//  HomeMeetingInfoFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/27.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "HomeMeetingInfoFunction.h"

@implementation HomeMeetingInfoFunction

- (NSString*) requestUrl{
    //return [NSString stringWithFormat:@"%@/v2/m/meetingGather", kURL_BASE_NEWDOMAIN];  liveAndPreviewCount
    return [NSString stringWithFormat:@"%@/v3/m/homePage/live", kURL_BASE_NEWDOMAIN];
}

- (id) paraserResponse:(id) response{
    if (response && [response isKindOfClass:[NSDictionary class]]) {
        HomeMeetingInfoModel* info = [HomeMeetingInfoModel mj_objectWithKeyValues:response];
        return info;
    }
    return nil;
}
@end
