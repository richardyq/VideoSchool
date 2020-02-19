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

+ (void) entryMobileLogin{
    UserMobileLoginViewController* loginViewController = [[UserMobileLoginViewController alloc] init];
    [VHPageRouter entryPageController:loginViewController];
}

@end
