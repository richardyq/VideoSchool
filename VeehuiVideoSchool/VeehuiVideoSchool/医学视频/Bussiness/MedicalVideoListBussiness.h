//
//  MedicalVideoListBussiness.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/19.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MedicalVideoListBussiness : NSObject

/**
 startLoadMediaclVideoClassify
 获取医学视频分类列表
 @param result          result 请求数据结果返回回调方法
 @param complete        complete 请求结束回调方法
 */
+ (void) startLoadMediaclVideoClassify:(VHRequestResultHandler) result
                              complete:(VHRequestCompleteHandler) complete;

/**
startLoadMedicalVideoSecondaryClassify
获取医学视频二级分类列表
 @parma code           一级学科code
@param result          result 请求数据结果返回回调方法
@param complete        complete 请求结束回调方法
*/
+ (void) startLoadMedicalVideoSecondaryClassify:(NSString*) code
                                         result:(VHRequestResultHandler) result
                                       complete:(VHRequestCompleteHandler) complete;

/**
startLoadClassifiedMedicalVideos
按照分类获取视频列表
 @parma code           学科code
 @parma pageNo          页码
 @parma pageSize        页大小
 @param result          result 请求数据结果返回回调方法
 @param complete        complete 请求结束回调方法
*/
+ (void) startLoadClassifiedMedicalVideos:(NSString*) code
                                   pageNo:(NSInteger) pageNo
                                 pageSize:(NSInteger) pageSize
                                   result:(VHRequestResultHandler) result
                                 complete:(VHRequestCompleteHandler) complete;
/**
 startLoadMedicalCourseList
 精品课程首页获取课程列表
 @parma pageNo          页码
 @parma pageSize        页大小
 @param result          result 请求数据结果返回回调方法
 @param complete        complete 请求结束回调方法
 */
+ (void) startLoadMedicalCourseList:(NSInteger) pageNo
                           pageSize:(NSInteger) pageSize
                             result:(VHRequestResultHandler) result
                           complete:(VHRequestCompleteHandler) complete;
/**
startLoadMedicalVideoGroupDetail
获取医学视频详情
@param groupId         groupId
@param result          result 请求数据结果返回回调方法
@param complete        complete 请求结束回调方法
*/
+ (void) startLoadMedicalVideoGroupDetail:(NSInteger) groupId
                                   result:(VHRequestResultHandler) result
                                 complete:(VHRequestCompleteHandler) complete;

/**
startLoadMedicalGroupOthersVideos
获取看了本视频的人也在学
@param groupId         groupId
@param result          result 请求数据结果返回回调方法
@param complete        complete 请求结束回调方法
*/
+ (void) startLoadMedicalGroupOthersVideos:(NSInteger) groupId
                                   sresult:(VHRequestResultHandler) result
                                  complete:(VHRequestCompleteHandler) complete;

/**
startLoadHomeRecommandCoursesVideos
获取首页推荐课程列表
@param result          result 请求数据结果返回回调方法
@param complete        complete 请求结束回调方法
*/
+ (void) startLoadHomeRecommandCoursesVideos:(VHRequestResultHandler) result
                                    complete:(VHRequestCompleteHandler) complete;
/**
startLoadHomeRecommandVideos
获取首页推荐医学视频列表
@param result          result 请求数据结果返回回调方法
@param complete        complete 请求结束回调方法
*/
+ (void) startLoadHomeRecommandVideos:(VHRequestResultHandler) result
                             complete:(VHRequestCompleteHandler) complete;

/**
startLoadHomeSubjectContent
获取首页分类列表内容
@param result          result 请求数据结果返回回调方法
@param complete        complete 请求结束回调方法
*/
+ (void) startLoadHomeSubjectContent:(VHRequestResultHandler) result
                            complete:(VHRequestCompleteHandler) complete;

/**
loadMedicalVideoAdvertiseList
获取医学视频首页顶部广告列表
@param result          result 请求数据结果返回回调方法
@param complete        complete 请求结束回调方法
*/
+ (void) loadMedicalVideoAdvertiseList:(VHRequestResultHandler) resultHandler
                              complete:(VHRequestCompleteHandler) complete;
@end

NS_ASSUME_NONNULL_END
