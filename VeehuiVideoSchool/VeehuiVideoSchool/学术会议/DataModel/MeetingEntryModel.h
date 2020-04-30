//
//  MeetingEntryModel.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/24.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, EMeetingStatus) {
    MeetingStatus_Unknown,
    MeetingStatus_Preview,
    MeetingStatus_Living,
    MeetingStatus_Replay,
};

@interface MeetingEntryModel : EntryModel

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* undertake;      //承办单位
@property (nonatomic, strong) NSString* organizer;      //主办单位
@property (nonatomic, strong) NSString* pictureUrl;
@property (nonatomic, strong) NSString* speaker;        //speaker
@property (nonatomic, strong) NSString* startTime;      //开始时间
@property (nonatomic) NSInteger startTimeTimeStamp;
@property (nonatomic, strong) NSString* endTime;        //结束时间
@property (nonatomic) NSInteger endTimeTimeStamp;

@property (nonatomic, strong) NSString* statusCode;     //会议状态编码 ['01':'预告','02':'直播中','03':'休息中','04':'结束']
@property (nonatomic) NSInteger watchingNumber;         //观看人数
@property (nonatomic, strong) NSString* watchingNumberInfo;

@property (nonatomic, strong) NSString* appointmentNumberInfo;
@property (nonatomic) NSInteger liveCount;

@property (nonatomic, strong) NSString* circleName;
@property (nonatomic, strong) NSString* circlePortraitUrl;

- (EMeetingStatus) meetingStatus;
@end

@interface MeetingListModel : ListModel

@end

NS_ASSUME_NONNULL_END
