//
//  UserPageRouter.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "UserPageRouter.h"
#import "UserMobileLoginViewController.h"

@implementation UserPageRouter

+ (void) entryMobileLogin:(dismissControllerHandler) handler{
    UserMobileLoginViewController* controller = [[UserMobileLoginViewController alloc] init];
    [controller onDismissControllerHandler:handler];
    [VHPageRouter presentViewController:controller];
}

@end
