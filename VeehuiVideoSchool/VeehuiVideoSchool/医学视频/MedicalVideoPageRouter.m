//
//  MedicalVideoPageRouter.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/19.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalVideoPageRouter.h"
#import "MedicalVideoStartViewController.h"
@implementation MedicalVideoPageRouter

+ (void) entryMedicalStartListPage{
    MedicalVideoStartViewController* controller = [[MedicalVideoStartViewController alloc] initWithNibName:nil bundle:nil];
    [VHPageRouter entryPageController:controller];
}
@end
