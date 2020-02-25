//
//  MeetingGatherFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/24.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingGatherFunction.h"
#import "MeetingGatherEntryModel.h"

@implementation MeetingGatherFunction

- (NSString*) requestUrl{
    //return [NSString stringWithFormat:@"%@/v2/m/meetingGather", kURL_BASE_NEWDOMAIN];  liveAndPreviewCount
    return [NSString stringWithFormat:@"%@/v3/m/liveAndPreviewCount", kURL_BASE_NEWDOMAIN];
}

- (id) paraserResponse:(id) response{
    if (response && [response isKindOfClass:[NSDictionary class]]) {
        MeetingGatherEntryModel* gatherModel = [MeetingGatherEntryModel mj_objectWithKeyValues:response];
        return gatherModel;
    }
    return nil;
}

@end
