//
//  MeetingPageRouter.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/24.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingPageRouter.h"
#import "MeetingStartViewController.h"

@implementation MeetingPageRouter

// 跳转进入学术会议首页
+ (void) entryMeetingStartPage{
    MeetingStartViewController* controller = [[MeetingStartViewController alloc] init];
    [VHPageRouter entryPageController:controller];
}
@end
