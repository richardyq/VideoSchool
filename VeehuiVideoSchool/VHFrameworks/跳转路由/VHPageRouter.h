//
//  VHPageRouter.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/17.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VHBaseViewController.h"
#import "VHBaseListViewController.h"
#import "VHBaseNavigationViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface VHPageRouter : NSObject

/**
 entryIntoInitializePage
 跳转到App初始化界面
 */
+ (void) entryIntoInitializePage;

/**
entryIntoUserLoginPage
跳转到App登录页面，选择登录方式
*/
+ (void) entryIntoUserLoginPage:(dismissControllerHandler) handler;

/**
entryMainPage
进入APP主界面
*/
+ (void) entryMainPage;
/**
 entryPageController
 跳转到指定界面
 */
+ (void) entryPageController:(VHBaseViewController*) controller;

+ (void) presentViewController:(VHBaseViewController*) controller;
@end

NS_ASSUME_NONNULL_END
