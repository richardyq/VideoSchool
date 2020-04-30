//
//  MeetingDetailModel.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/30.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingDetailModel.h"

@implementation MeetingConferenceVideoModel


@end

@implementation MeetingConferenceModel

+ (NSDictionary*) mj_objectClassInArray{
    return @{@"videoList": [MeetingConferenceModel class]};
}
@end

@implementation MeetingDetailModel

+ (NSDictionary*) mj_objectClassInArray{
    return @{@"conferenceInfos": [MeetingConferenceModel class]};
}
@end
