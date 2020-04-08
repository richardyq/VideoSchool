//
//  MedicalVideoListBussiness.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/19.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalVideoListBussiness.h"
#import "MedicalVideoClassifyListFunction.h"
#import "MedicalVideoSecondaryClassifyListFunction.h"
#import "ClassifiedMedicalVideosFunction.h"
#import "MedicalCourseListFunction.h"
#import "MedicalGroupDetailFunction.h"
#import "MedicalGroupOthersFunction.h"
#import "HomeRecommandCourseListFunction.h"
#import "HomeRecommandVideosFunction.h"
#import "HomeSubjectListFunction.h"
#import "MedicalVideoAdvertiseListFunction.h"

@implementation MedicalVideoListBussiness

+ (void) startLoadMediaclVideoClassify:(VHRequestResultHandler) result
                              complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[MedicalVideoClassifyListFunction alloc] init];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:^(id resp) {
        if (result) {
            result(resp);
        }
    } complete:complete];
}

+ (void) startLoadMedicalVideoSecondaryClassify:(NSString*) code
                                         result:(VHRequestResultHandler) result
                                       complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[MedicalVideoSecondaryClassifyListFunction alloc] initWithCode:code];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:^(id resp) {
        if (result) {
            result(resp);
        }
    } complete:complete];
}

+ (void) startLoadClassifiedMedicalVideos:(NSString*) code
                                   pageNo:(NSInteger) pageNo
                                 pageSize:(NSInteger) pageSize
                                   result:(VHRequestResultHandler) result
                                 complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[ClassifiedMedicalVideosFunction alloc] initWithCode:code pageNo:pageNo pageSize:pageSize];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:result complete:complete];
}

+ (void) startLoadMedicalCourseList:(NSInteger) pageNo
                           pageSize:(NSInteger) pageSize
                             result:(VHRequestResultHandler) result
                           complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[MedicalCourseListFunction alloc] initWithPageNo:pageNo pageSize:pageSize];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:result complete:complete];
}

+ (void) startLoadMedicalVideoGroupDetail:(NSInteger) groupId
                                   result:(VHRequestResultHandler) result
                       complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[MedicalGroupDetailFunction alloc] initWithGroupId:groupId];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:result complete:complete];
}

+ (void) startLoadMedicalGroupOthersVideos:(NSInteger) groupId
                                   sresult:(VHRequestResultHandler) result
                                  complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[MedicalGroupOthersFunction alloc] initWithGroupId:groupId];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:result complete:complete];
}

+ (void) startLoadHomeRecommandCoursesVideos:(VHRequestResultHandler) resultHandler
                                    complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[HomeRecommandCourseListFunction alloc] init];
    //读取缓存
    NSString* cachePath = [kCachePrefixPath stringByAppendingString:@"homeRecommandCourses"];
    MedicalVideoGroupInfoListModel* courseListModel = [VHCache loadFromeCache:cachePath];
    if (courseListModel && [courseListModel isKindOfClass:[MedicalVideoGroupInfoListModel class]]) {
        if (resultHandler) {
            resultHandler(courseListModel);
        }
    }
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:^(id result) {
        if (result && [result isKindOfClass:[MedicalVideoGroupInfoListModel class]]) {
            //缓存数据
            [VHCache saveToCache:result cachePath:cachePath];
        }
        
        if (resultHandler) {
            resultHandler(result);
        }
    } complete:complete];
}

+ (void) startLoadHomeRecommandVideos:(VHRequestResultHandler) resultHandler
                             complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[HomeRecommandVideosFunction alloc] init];
    //读取缓存
    NSString* cachePath = [kCachePrefixPath stringByAppendingString:@"homeRecommandVideos"];
    MedicalVideoGroupInfoListModel* videoListModel = [VHCache loadFromeCache:cachePath];
    if (videoListModel && [videoListModel isKindOfClass:[MedicalVideoGroupInfoListModel class]]) {
        if (resultHandler) {
            resultHandler(videoListModel);
        }
    }
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:^(id result) {
        if (result && [result isKindOfClass:[MedicalVideoGroupInfoListModel class]]) {
            //缓存数据
            [VHCache saveToCache:result cachePath:cachePath];
        }
        
        if (resultHandler) {
            resultHandler(result);
        }
    } complete:complete];
   
}

+ (void) startLoadHomeSubjectContent:(VHRequestResultHandler) resultHandler
                             complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[HomeSubjectListFunction alloc] init];
    //读取缓存
    NSString* cachePath = [kCachePrefixPath stringByAppendingString:@"homeSubjectsVideos"];
    HomeSubjectEntry* videoListModel = [VHCache loadFromeCache:cachePath];
    if (videoListModel && [videoListModel isKindOfClass:[HomeSubjectEntry class]]) {
        if (resultHandler) {
            resultHandler(videoListModel);
        }
    }
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:^(id result) {
        if (result && [result isKindOfClass:[HomeSubjectEntry class]]) {
            //缓存数据
            [VHCache saveToCache:result cachePath:cachePath];
        }
        
        if (resultHandler) {
            resultHandler(result);
        }
    } complete:complete];
}

+ (void) loadMedicalVideoAdvertiseList:(VHRequestResultHandler) resultHandler
                              complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[MedicalVideoAdvertiseListFunction alloc] init];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:resultHandler complete:complete];
}
@end
