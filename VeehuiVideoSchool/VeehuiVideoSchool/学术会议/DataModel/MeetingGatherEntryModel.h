//
//  MeetingGatherEntryModel.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/24.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "EntryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MeetingGatherEntryModel : EntryModel

@property (nonatomic) NSInteger liveCount;          //今日直播数量
@property (nonatomic) NSInteger previewCount;       //预告会议数量
@property (nonatomic) NSInteger startTimeSeconds;   //开始时间倒计时

@end

NS_ASSUME_NONNULL_END
