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

@implementation MedicalVideoPageRouter

+ (void) entryMedicalVideoStartListPage{
    MedicalVideoStartViewController* controller = [[MedicalVideoStartViewController alloc] initWithNibName:nil bundle:nil];
    [VHPageRouter entryPageController:controller];
}

+ (void) entryClassifiedMedicalVideListPage:(MedicalVideoClassifyEntryModel*) classifyModel{
    MedicalClassifyVideoListViewController* controller = [[MedicalClassifyVideoListViewController alloc] initWithClassifyModel:classifyModel];
    [VHPageRouter entryPageController:controller];
}

@end
