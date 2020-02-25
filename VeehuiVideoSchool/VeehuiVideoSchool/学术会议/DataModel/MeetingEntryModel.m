//
//  MeetingEntryModel.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/24.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingEntryModel.h"

@implementation MeetingEntryModel

@end

@implementation MeetingListModel

+ (NSDictionary*) mj_objectClassInArray{
    return @{@"content": [MeetingEntryModel class]};
}

@end
