//
//  VHPageRouter.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/17.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHPageRouter.h"

#import "InitializationViewController.h"
#import "UserLoginStartViewController.h"
#import "MainStartTabbarViewController.h"

@implementation VHPageRouter

//跳转到初始化
+ (void) entryIntoInitializePage{
    InitializationViewController* initializationController = [[InitializationViewController alloc] initWithNibName:nil bundle:nil];
    [[NSObject rootWindow] setRootViewController:initializationController];
}

+ (void) entryIntoUserLoginPage:(dismissControllerHandler) handler{
    UserLoginStartViewController* loginController = [[UserLoginStartViewController alloc] init];
    [loginController onDismissControllerHandler:handler];
    [self presentViewController:loginController];
}

+ (void) entryMainPage{
    MainStartTabbarViewController* startController = [[MainStartTabbarViewController alloc] initWithNibName:nil bundle:nil];
    [[NSObject rootWindow] setRootViewController:startController];
}

//跳转到指定的界面
+ (void) entryPageController:(VHBaseViewController*) controller{
    UIViewController* topmostController = [NSObject topMostController];
    UINavigationController* navigationContoller = topmostController.navigationController;
    if (!navigationContoller || ![navigationContoller isKindOfClass:[UINavigationController class]]) {
        return;
    }
    
    NSArray<UIViewController*>* controllers = navigationContoller.viewControllers;
    __block UIViewController* existedController = nil;
    
    [controllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull ctrl, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![ctrl isKindOfClass:[VHBaseViewController class]]) {
            return ;
        }
        
        VHBaseViewController* baseController = (VHBaseViewController*) ctrl;
        if ([baseController.controllerId isEqualToString:controller.controllerId]) {
            existedController = baseController;
            *stop = YES;
        }
    }];
    
    if (existedController) {
        [navigationContoller popToViewController:existedController animated:YES];
        return;
    }
    
    [navigationContoller pushViewController:controller animated:YES];
}

+ (void) presentViewController:(VHBaseViewController*) controller{
    UIViewController* topmostController = [NSObject topMostController];
    UINavigationController* navigationController = [[VHBaseNavigationViewController alloc] initWithRootViewController:controller];
    navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
    [topmostController presentViewController:navigationController animated:YES completion:nil];
}
@end
