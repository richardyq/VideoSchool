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
#import "HomeMeetingInfoFunction.h"
#import "PreviewMeetingListFunction.h"
#import "ReplayFavoritesFunction.h"
#import "ReplayMeetingListFunction.h"
#import "MeetingDetailFunction.h"
#import "MeetingReplayDetailFunction.h"

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



//获取首页会议轮播数据
+ (void) startLoadHomeMeetings:(VHRequestResultHandler) resultHandler
                      complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[HomeMeetingInfoFunction alloc] init];
    NSString* cachePath = [kCachePrefixPath stringByAppendingString:@"homeMeetingModel"];
    //获取缓存数据
    HomeMeetingInfoModel* cachedValue = [VHCache loadFromeCache:cachePath];
    if (cachedValue && [cachedValue isKindOfClass:[HomeMeetingInfoModel class]]) {
        if (resultHandler) {
            resultHandler(cachedValue);
        }
    }
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:^(id result) {
        if ([result isKindOfClass:[HomeMeetingInfoModel class]]) {
            //保存数据到缓存
            [VHCache saveToCache:result cachePath:cachePath];
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

//获取会议预告列表
+ (void) startLoadPreviewMeetingList:(VHRequestResultHandler) result
                         complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[PreviewMeetingListFunction alloc] init];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:result complete:complete];
}

//获取直播列表
+ (void) startLoadReplayMeetingList:(NSString*) subjectCode
                             pageNo:(NSInteger) pageNo
                           pageSize:(NSInteger) pageSize
                             result:(VHRequestResultHandler) result
                           complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[ReplayMeetingListFunction alloc] initWithSubjectCode:subjectCode pageNo:pageNo pageSize:pageSize];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:result complete:complete];
}

//获取会议回放兴趣列表
+ (void) startLoadReplayFavoriteList:(VHRequestResultHandler) result
                            complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[ReplayFavoritesFunction alloc] init];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:result complete:complete];
}

//获取会议详情
+ (void) startLoadMeetingDetail:(NSInteger) meetingId
                         result:(VHRequestResultHandler) result
                           complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[MeetingDetailFunction alloc] initWithMeetingId:meetingId];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:result complete:complete];
}

//获取会议视频详情
+ (void) startLoadMeetingReplayDetail:(NSInteger) meetingId
                               result:(VHRequestResultHandler) result
                             complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[MeetingReplayDetailFunction alloc] initWithMeetingId:meetingId];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:result complete:complete];
}
@end
