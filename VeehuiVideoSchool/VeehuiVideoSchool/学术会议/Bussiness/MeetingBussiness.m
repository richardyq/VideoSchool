//
//  MeetingBussiness.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/24.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingBussiness.h"
#import "MeetingGatherFunction.h"
#import "LiveMeetingListFunction.h"
#import "HomeMeetingListFunction.h"

@implementation MeetingBussiness

//获取会议汇总信息
+ (void) startLoadMeetingGather:(VHRequestResultHandler) result
                       complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[MeetingGatherFunction alloc] init];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:^(id resp) {
        if (result) {
            result(resp);
        }
    } complete:complete];
}

//获取直播列表
+ (void) startLoadLiveMeetingList:(NSInteger) pageNo
                         pageSize:(NSInteger) pageSize
                           result:(VHRequestResultHandler) result
                         complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[LiveMeetingListFunction alloc] initWithPageNo:pageNo pageSize:pageSize];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:result complete:complete];
}

//获取首页会议轮播数据
+ (void) startLoadHomeMeetings:(VHRequestResultHandler) result
                      complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[HomeMeetingListFunction alloc] init];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:result complete:complete];
}
@end
