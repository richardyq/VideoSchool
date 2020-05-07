//
//  MeetingPreviewGatherModel.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/7.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingPreviewGatherModel.h"

@implementation MeetingPreviewGatherModel

+ (NSDictionary*) mj_objectClassInArray{
    return @{@"meetings": [MeetingEntryModel class]};
}

@end
