//
//  InnerCirclePageRouter.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "InnerCirclePageRouter.h"
#import "InnerCircleStartViewController.h"


@implementation InnerCirclePageRouter

+ (void) entryInnerCircleStartPage:(NSInteger) circleId{
    VHBaseViewController* controller = [[InnerCircleStartViewController alloc] initWithCircleId:circleId];
    [VHPageRouter entryPageController:controller];
}

+ (void) entryInnerCircleCoursesPage:(InnerCircleCourseType) courseType{
    VHBaseViewController* controller = [[InnerCircleCourseListViewController alloc] initWithCourseType:courseType];
    [VHPageRouter entryPageController:controller];
}
@end
