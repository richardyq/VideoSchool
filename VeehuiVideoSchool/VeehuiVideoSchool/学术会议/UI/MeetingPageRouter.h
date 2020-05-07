//
//  MeetingPageRouter.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/24.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MedicalVideoClassifyEntryModel;

NS_ASSUME_NONNULL_BEGIN

@interface MeetingPageRouter : NSObject

/**
 entryMeetingStartPage
 跳转进入学术会议首页
 */
+ (void) entryMeetingStartPage;

/**
 entryMeetingReplayPage
 跳转到会议视频（回放）分类列表
 @param subject         主分类
 */

+ (void) entryMeetingReplayPage:(MedicalVideoClassifyEntryModel*) subject;

/**
entryMeetingPreviewsPage
跳转进入学术会议预告列表页面
*/
+ (void) entryMeetingPreviewsPage;

/**
 entryMeetingDatailPage
 跳转到会议详情页面（直播、预告、重播）
 
 @param meetingId         会议id
 */
+ (void) entryMeetingDatailPage:(NSInteger) meetingId;
@end

NS_ASSUME_NONNULL_END
