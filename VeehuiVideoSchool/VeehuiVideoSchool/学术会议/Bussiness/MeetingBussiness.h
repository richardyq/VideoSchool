//
//  MeetingBussiness.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/24.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MeetingBussiness : NSObject

/**
 startLoadMeetingGather
 获取会议汇总信息
 @param result          result 请求数据结果返回回调方法
 @param complete        complete 请求结束回调方法
 */
+ (void) startLoadMeetingGather:(VHRequestResultHandler) result
                       complete:(VHRequestCompleteHandler) complete;

/**
 startLoadLiveMeetingList
 获取会议直播列表
 @param pageNo          pageNo  页码
 @param pageSize        pageSize  行数
 @param result          result 请求数据结果返回回调方法
 @param complete        complete 请求结束回调方法
 */
+ (void) startLoadLiveMeetingList:(NSInteger) pageNo
                         pageSize:(NSInteger) pageSize
                           result:(VHRequestResultHandler) result
                         complete:(VHRequestCompleteHandler) complete;

/**
startLoadPreviewMeetingList
获取会议预告列表

@param result          result 请求数据结果返回回调方法
@param complete        complete 请求结束回调方法
*/
+ (void) startLoadPreviewMeetingList:(VHRequestResultHandler) result
                            complete:(VHRequestCompleteHandler) complete;


/**
startLoadReplayMeetingList
获取会议重播列表
@param subjectCode     subjectCode  编码
@param pageNo          pageNo  页码
@param pageSize        pageSize  行数
@param result          result 请求数据结果返回回调方法
@param complete        complete 请求结束回调方法
*/
+ (void) startLoadReplayMeetingList:(NSString*) subjectCode
                             pageNo:(NSInteger) pageNo
                           pageSize:(NSInteger) pageSize
                             result:(VHRequestResultHandler) result
                           complete:(VHRequestCompleteHandler) complete;

/**
 startLoadHomeMeetings
 获取首页会议轮播信息
 @param result          result 请求数据结果返回回调方法
 @param complete        complete 请求结束回调方法
 */
+ (void) startLoadHomeMeetings:(VHRequestResultHandler) result
                      complete:(VHRequestCompleteHandler) complete;

/**
startLoadHomeMeetings
获取会议回放兴趣列表
@param result          result 请求数据结果返回回调方法
@param complete        complete 请求结束回调方法
*/
+ (void) startLoadReplayFavoriteList:(VHRequestResultHandler) result
                            complete:(VHRequestCompleteHandler) complete;

/**
startLoadMeetingDetail
获取会议详情信息
@param meetingId       meetingId  会议id
@param result          result 请求数据结果返回回调方法
@param complete        complete 请求结束回调方法
*/
+ (void) startLoadMeetingDetail:(NSInteger) meetingId
                         result:(VHRequestResultHandler) result
                       complete:(VHRequestCompleteHandler) complete;

/**
startLoadMeetingReplayDetail
获取会议视频（重播）详情信息
@param meetingId       meetingId  会议id
@param result          result 请求数据结果返回回调方法
@param complete        complete 请求结束回调方法
*/
+ (void) startLoadMeetingReplayDetail:(NSInteger) meetingId
                               result:(VHRequestResultHandler) result
                             complete:(VHRequestCompleteHandler) complete;

@end

NS_ASSUME_NONNULL_END
