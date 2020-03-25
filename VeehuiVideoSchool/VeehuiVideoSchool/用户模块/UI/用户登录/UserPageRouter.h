//
//  UserPageRouter.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserPageRouter : NSObject

/**
 entryMobileLogin
 跳转到手机号登录界面
 */
+ (void) entryMobileLogin:(dismissControllerHandler) handler;

@end

NS_ASSUME_NONNULL_END
