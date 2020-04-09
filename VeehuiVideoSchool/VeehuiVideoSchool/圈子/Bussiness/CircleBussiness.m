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

+ (void) startLoadRecommandCircleList:(VHRequestResultHandler) result
                             complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[RecommandProfessorListFunction alloc] init];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:result complete:complete];
}
@end
