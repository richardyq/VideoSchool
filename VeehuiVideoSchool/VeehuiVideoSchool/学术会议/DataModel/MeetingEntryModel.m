//
//  MeetingEntryModel.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/24.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingEntryModel.h"

@implementation MeetingEntryModel

- (EMeetingStatus) meetingStatus{
    EMeetingStatus status = MeetingStatus_Unknown;
    if (self.statusCode && ![self.statusCode isEmpty]) {
        NSString* meetingStatusCode = self.statusCode;
        if ([meetingStatusCode isEqualToString:@"01"]) {
            //预告
            status = MeetingStatus_Preview;
        }
        else if ([meetingStatusCode isEqualToString:@"02"] ||
            [meetingStatusCode isEqualToString:@"03"]) {
            //直播
            status = MeetingStatus_Living;
        }
        else if ([meetingStatusCode isEqualToString:@"04"] ||
            [meetingStatusCode isEqualToString:@"05"]) {
            //重播
            status = MeetingStatus_Replay;
        }
    }
    return status;
}

@end

@implementation MeetingListModel

+ (NSDictionary*) mj_objectClassInArray{
    return @{@"content": [MeetingEntryModel class]};
}

@end
