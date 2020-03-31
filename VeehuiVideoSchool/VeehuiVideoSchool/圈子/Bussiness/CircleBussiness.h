//
//  CircleBussiness.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/30.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CircleBussiness : NSObject

/**
 startLoadUserJoinedCircles
 获取用户加入的机构列表
 @param result          result 请求数据结果返回回调方法
 @param complete        complete 请求结束回调方法
 */
+ (void) startLoadUserJoinedCircles:(VHRequestResultHandler) result
                           complete:(VHRequestCompleteHandler) complete;

/**
startLoadUserJoinedCircleInfo
获取用户加入的机构信息
@param circleId        圈子Id
@param result          result 请求数据结果返回回调方法
@param complete        complete 请求结束回调方法
*/
+ (void) startLoadUserJoinedCircleInfo:(NSInteger) circleId
                                result:(VHRequestResultHandler) result
                              complete:(VHRequestCompleteHandler) complete;

@end

NS_ASSUME_NONNULL_END
