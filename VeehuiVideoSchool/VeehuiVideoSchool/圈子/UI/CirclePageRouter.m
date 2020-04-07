//
//  CirclePageRouter.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/3.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "CirclePageRouter.h"
#import "ProfessorStartViewController.h"

@implementation CirclePageRouter

+ (void) entryProfessorStartPage{
    ProfessorStartViewController* controller = [[ProfessorStartViewController alloc] initWithNibName:nil bundle:nil];
    [VHPageRouter entryPageController:controller];
}

@end
