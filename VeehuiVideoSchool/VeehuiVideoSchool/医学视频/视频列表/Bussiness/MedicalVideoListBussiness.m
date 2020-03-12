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
@end
