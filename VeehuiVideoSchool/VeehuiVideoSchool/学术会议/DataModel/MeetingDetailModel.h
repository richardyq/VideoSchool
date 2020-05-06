//
//  MeetingDetailModel.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/30.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingEntryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MeetingConferenceVideoModel : EntryModel

@property (nonatomic) NSInteger currentTime;        //
@property (nonatomic) NSInteger duration;           //时长（秒）
@property (nonatomic) BOOL isVip;              //是否vip视频
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* hdUrl;      //高清播放地址
@end

//会场信息
@interface MeetingConferenceModel : EntryModel

//播放地址
@property (nonatomic, strong) NSString* breakFhdUrl;        //超清播放地址
@property (nonatomic, strong) NSString* breakHdUrl;         //高清播放地址
@property (nonatomic, strong) NSString* breakLdUrl;         //流畅播放地址
@property (nonatomic, strong) NSString* breakSdUrl;         //标清播放地址
@property (nonatomic, strong) NSString* hdFlvUrl;           //窄带高清flv播放地址
@property (nonatomic, strong) NSString* hdRtmpUrl;          //窄带高清rtmp播放地址
@property (nonatomic, strong) NSString* originalFlvUrl;     //原画flv播放地址
@property (nonatomic, strong) NSString* originalMuUrl;      //原画m3u8播放地址
@property (nonatomic, strong) NSString* originalRtmpUrl;    //原画rtmp播放地址

@property (nonatomic) NSInteger count;                      //观看人数
@property (nonatomic, strong) NSString* nextStartTime;      //下次开始时间
@property (nonatomic, strong) NSString* nextStartTimeSeconds;      //离当前时间
@property (nonatomic, strong) NSString* speaker;
@property (nonatomic, strong) NSString* startTime;
@property (nonatomic, strong) NSString* endTime;
@property (nonatomic, strong) NSString* statusCode;         //会场状态编码 ['01':'预告','02':'直播中','03':'休息中','04':'结束']
@property (nonatomic, strong) NSString* title;


@property (nonatomic, strong) NSArray<MeetingConferenceVideoModel*>* videoList;     //视频信息
@end

@interface MeetingDetailModel : MeetingEntryModel
//会场信息
@property (nonatomic, strong) NSArray<MeetingConferenceModel*>* conferenceInfos;
//会议日程
@property (nonatomic, strong) NSString* schedule;

//描述
@property (nonatomic, strong) NSString* summary;
@property (nonatomic, strong) MeetingConferenceVideoModel* currentVideo;    //当前视频实体
@end

NS_ASSUME_NONNULL_END
