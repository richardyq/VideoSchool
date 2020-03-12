//
//  MedicalVideoPageRouter.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/19.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalVideoPageRouter.h"
#import "MedicalVideoStartViewController.h"
#import "MedicalClassifyVideoListViewController.h"
#import "MedicalCourseListViewController.h"
#import "MedicalVideoDetailViewController.h"

@implementation MedicalVideoPageRouter

+ (void) entryMedicalVideoStartListPage{
    MedicalVideoStartViewController* controller = [[MedicalVideoStartViewController alloc] initWithNibName:nil bundle:nil];
    [VHPageRouter entryPageController:controller];
}

+ (void) entryClassifiedMedicalVideListPage:(MedicalVideoClassifyEntryModel*) classifyModel{
    MedicalClassifyVideoListViewController* controller = [[MedicalClassifyVideoListViewController alloc] initWithClassifyModel:classifyModel];
    [VHPageRouter entryPageController:controller];
}

+ (void) entryMedicalCourseListPage{
    VHBaseViewController* controller = [[MedicalCourseListViewController alloc] initWithNibName:nil bundle:nil];
    [VHPageRouter entryPageController:controller];
}

+ (void) entryMedicalVideoDetailPage:(NSInteger) groupId{
    VHBaseViewController* controller = [[MedicalVideoDetailViewController alloc] initWithVideoGroupId:groupId];
    [VHPageRouter entryPageController:controller];
}
@end
