//
//  MeetingPreviewDayModel.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/7.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingPreviewDayModel.h"

@implementation MeetingPreviewDayModel

- (id) initWithDate:(NSString*) date{
    self = [super init];
    if (self) {
        _date = date;
    }
    return self;
}

+ (NSDictionary*) mj_objectClassInArray{
    return @{@"meetings": [MeetingEntryModel class]};
}

- (NSMutableArray<MeetingEntryModel*>*) meetings{
    if (!_meetings) {
        _meetings = [NSMutableArray<MeetingEntryModel*> array];
    }
    return _meetings;
}

@end
