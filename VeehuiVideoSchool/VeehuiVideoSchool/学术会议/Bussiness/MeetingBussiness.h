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
 startLoadHomeMeetings
 获取首页会议轮播信息
 @param result          result 请求数据结果返回回调方法
 @param complete        complete 请求结束回调方法
 */
+ (void) startLoadHomeMeetings:(VHRequestResultHandler) result
                      complete:(VHRequestCompleteHandler) complete;

@end

NS_ASSUME_NONNULL_END
