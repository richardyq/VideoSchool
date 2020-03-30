//
//  HomeMeetingInfo.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/27.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MeetingEntryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeMeetingInfo : EntryModel

@property (nonatomic) NSInteger appointmentNumber;            //预约人数
@property (nonatomic) NSInteger watchingNumber;               //预约人数
@property (nonatomic) BOOL haveLiveMeeting;                   //是否有直播会议 0:无直播 1:有直播
@property (nonatomic, strong) NSArray<MeetingEntryModel*>* meetingInfos;        //会议列表

@property (nonatomic, readonly) MeetingEntryModel* shownMeetingInfo;

@end

NS_ASSUME_NONNULL_END
