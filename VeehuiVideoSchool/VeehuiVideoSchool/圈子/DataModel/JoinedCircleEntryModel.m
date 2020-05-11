//
//  JoinedCircleEntryModel.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/30.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "JoinedCircleEntryModel.h"

@implementation JoinedCircleMeetingModel
MJCodingImplementation

@end


@implementation JoinedCircleVideoGroupModel
MJCodingImplementation

@end

@implementation JoinedCircleEntryModel
MJCodingImplementation
+ (NSDictionary*) mj_objectClassInArray{
    return @{@"circleMvgInfos": [JoinedCircleVideoGroupModel class],
             @"circleAnnouncements": [CircleAnnouncementEntryModel class]
    };
}


- (BOOL) haswork{
    return (self.haveWaitingProcess > 0);
}
@end
