//
//  MeetingPageRouter.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/24.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingPageRouter.h"
#import "MeetingStartViewController.h"
#import "MeetingReplayListViewController.h"
#import "MeetingBussiness.h"
#import "MeetingDetailModel.h"
#import "MeetingReplayViewController.h"
#import "MeetingLivingViewController.h"
#import "MeetingPreviewListViewController.h"
#import "MeetingPreviewDetailViewController.h"

@implementation MeetingPageRouter

// 跳转进入学术会议首页
+ (void) entryMeetingStartPage{
    MeetingStartViewController* controller = [[MeetingStartViewController alloc] init];
    [VHPageRouter entryPageController:controller];
}

//跳转到会议视频（回放）分类列表
+ (void) entryMeetingReplayPage:(MedicalVideoClassifyEntryModel*) subject{
    VHBaseViewController* controller = [[MeetingReplayListViewController alloc] initWithSeniorSubject:subject];
    [VHPageRouter entryPageController:controller];
}

//跳转到会议预告列表
+ (void) entryMeetingPreviewsPage{
    VHBaseViewController* controller = [[MeetingPreviewListViewController alloc] init];
    [VHPageRouter entryPageController:controller];
}

//跳转到会议详情页面
+ (void) entryMeetingDatailPage:(NSInteger) meetingId{
    [MessageHubUtil showWait:@"请稍等，正在加载。。"];
    __block MeetingDetailModel* meetingDetail = nil;
    //获取会议详情信息
    WS(weakSelf)
    [MeetingBussiness startLoadMeetingDetail:meetingId result:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if ([result isKindOfClass:[MeetingEntryModel class]]) {
            meetingDetail = result;
        }
    } complete:^(NSInteger code, NSString *message) {
        SAFE_WEAKSELF(weakSelf)
        [MessageHubUtil hideMessage];
        if (code != 0) {
            [MessageHubUtil showErrorMessage:message];
            return;
        }
        VHBaseViewController* controller = nil;
        if (meetingDetail) {
            switch ([meetingDetail meetingStatus]) {
                case MeetingStatus_Preview:{
                    //预告
                    controller = [[MeetingPreviewDetailViewController alloc] initWithMeetingDetail:meetingDetail];
                    break;
                }
                case MeetingStatus_Living:{
                    //直播
                    controller = [[MeetingLivingViewController alloc] initWithMeetingDetail:meetingDetail];
                    break;
                }
                case MeetingStatus_Replay:{
                    //重播
                    controller = [[MeetingReplayViewController alloc] initWithMeetingDetail:meetingDetail];
                    break;
                }
                default:
                    break;
            }
            
        }
        
        if (controller) {
            [VHPageRouter entryPageController:controller];
        }
    }];
}

@end
