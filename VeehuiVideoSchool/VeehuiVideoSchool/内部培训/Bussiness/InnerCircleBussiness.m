//
//  InnerCircleBussiness.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "InnerCircleBussiness.h"
#import "InnerCircleInfoFunction.h"

@implementation InnerCircleBussiness

+ (void) startLoadInnerInfo:(NSInteger) circleId
                     result:(VHRequestResultHandler) result
                   complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[InnerCircleInfoFunction alloc] initWithCircleId:circleId];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:result complete:complete];
}
@end
