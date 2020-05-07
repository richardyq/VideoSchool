//
//  MeetingPreviewSectionModel.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/7.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingPreviewSectionModel.h"

@interface MeetingEntryModel (DayExt)

- (NSString*) startDate;

@end

@implementation MeetingEntryModel (DayExt)

- (NSString*) startDate{
    //08月31日 08:30
    NSDate* date = [NSDate dateWithString:self.startTime format:@"MM月dd日 HH:mm"];
    if (!date) {
        return nil;
    }
    
    NSString* dateString = [date stringWithFormat:@"dd日"];
    //缺少年份信息，无法获取到星期几
    return dateString;
}

@end

@implementation MeetingPreviewSectionModel

+ (NSDictionary*) mj_objectClassInArray{
    return @{@"meetings": [MeetingEntryModel class]};
}

- (NSArray<MeetingPreviewDayModel*>*) meetingsInDays{
    NSMutableArray<MeetingPreviewDayModel*>* meetingsInDays = [NSMutableArray<MeetingPreviewDayModel*> array];
    [self.meetings enumerateObjectsUsingBlock:^(MeetingEntryModel * _Nonnull meeting, NSUInteger idx, BOOL * _Nonnull stop) {
        __block NSString* meetingDate = [meeting startDate];
        if (!meetingDate) {
            return ;
        }
        
        __block MeetingPreviewDayModel* dayModel = nil;
        [meetingsInDays enumerateObjectsUsingBlock:^(MeetingPreviewDayModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([model.date isEqualToString:meetingDate]) {
                dayModel = model;
                *stop = YES;
            }
        }];
        
        if (!dayModel) {
            dayModel = [[MeetingPreviewDayModel alloc] initWithDate:meetingDate];
            [meetingsInDays addObject:dayModel];
        }
        
        [dayModel.meetings addObject:meeting];
    }];
    return meetingsInDays;
}
@end
