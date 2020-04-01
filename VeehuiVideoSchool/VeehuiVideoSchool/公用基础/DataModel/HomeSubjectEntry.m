//
//  HomeSubjectEntry.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/1.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "HomeSubjectEntry.h"

@implementation HomeSubjectEntry

+ (NSDictionary*) mj_objectClassInArray{
    return @{@"meetingInfos": [MeetingEntryModel class],
             @"lengthwaysMedicalVideos": [MedicalVideoGroupInfoEntryModel class],
             @"transverseMedicalVideos": [MedicalVideoGroupInfoEntryModel class]
    };
}

@end

@implementation HomeSubjectListModel

+ (NSDictionary*) mj_objectClassInArray{
    return @{@"content": [HomeSubjectEntry class]};
}

@end
