//
//  CircleBussiness.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/30.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "CircleBussiness.h"
#import "UserJoinedCirclesFunction.h"
#import "UserJoinedCircleInfoFunction.h"
#import "RecommandProfessorListFunction.h"
#import "ActiveProfessorListFunction.h"
#import "FollowedProfessorListFunction.h"
#import "ClassifiedProfessorListFunction.h"

@implementation CircleBussiness

+ (void) startLoadUserJoinedCircles:(VHRequestResultHandler) result
                           complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[UserJoinedCirclesFunction alloc] init];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:result complete:complete];
}

+ (void) startLoadUserJoinedCircleInfo:(NSInteger) circleId
                                result:(VHRequestResultHandler) result
                              complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[UserJoinedCircleInfoFunction alloc] initWithCircleId:circleId];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:result complete:complete];
}

+ (void) startLoadActiveCircleList:(VHRequestResultHandler) result
                          complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[ActiveProfessorListFunction alloc] init];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:result complete:complete];
}

+ (void) startLoadProfessorCircleList:(NSInteger) pageNo
                               result:(VHRequestResultHandler) result
                             complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[RecommandProfessorListFunction alloc] initWtithPageNo:pageNo];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:result complete:complete];
}

+ (void) startLoadFollowedProfessorList:(NSInteger) pageNo
                               result:(VHRequestResultHandler) result
                             complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[FollowedProfessorListFunction alloc] initWtithPageNo:pageNo];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:result complete:complete];
}

+ (void) startLoadClassifiedProfessorList:(NSString*) code
                                   pageNo:(NSInteger) pageNo
                                   result:(VHRequestResultHandler) result
                                 complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[ClassifiedProfessorListFunction alloc] initWithCode:code pageNo:pageNo];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:result complete:complete];
}
@end
