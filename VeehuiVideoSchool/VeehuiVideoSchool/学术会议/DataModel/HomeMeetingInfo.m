//
//  HomeMeetingInfo.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/27.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "HomeMeetingInfo.h"

@implementation HomeMeetingInfo

@synthesize shownMeetingInfo = _shownMeetingInfo;

+ (NSDictionary*) mj_objectClassInArray{
    return @{@"meetingInfos": [MeetingEntryModel class]};
}

- (MeetingEntryModel*) shownMeetingInfo{
    if (_shownMeetingInfo) {
        return _shownMeetingInfo;
    }
    
    if (!self.meetingInfos || self.meetingInfos.count == 0) {
        return _shownMeetingInfo;
    }
    
    NSMutableArray<MeetingEntryModel*>* liveMeetings = [NSMutableArray<MeetingEntryModel*> array];
    NSMutableArray<MeetingEntryModel*>* appointmentMeetings = [NSMutableArray<MeetingEntryModel*> array];
    NSArray<MeetingEntryModel*>* meetings = liveMeetings;
    
    [self.meetingInfos enumerateObjectsUsingBlock:^(MeetingEntryModel * _Nonnull meetingEntryModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([meetingEntryModel.statusCode isEqualToString:@"01"]) {
            //预约
            [appointmentMeetings addObject:meetingEntryModel];
        }
        else if ([meetingEntryModel.statusCode isEqualToString:@"02"] || [meetingEntryModel.statusCode isEqualToString:@"03"]){
            //直播
            [liveMeetings addObject:meetingEntryModel];
        }
    }];
    
    if (!self.haveLiveMeeting) {
        meetings = appointmentMeetings;
    }
    if (meetings.count == 0) {
        return _shownMeetingInfo;
    }
    
    NSInteger randIndex = (arc4random() % meetings.count);
    _shownMeetingInfo = meetings[randIndex];
    
    return _shownMeetingInfo;
}


@end
