//
//  UserLoginWithMobileFunction.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHHTTPFunction.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserLoginWithMobileFunction : VHHTTPFunction

- (id) initWithMobile:(NSString*) mobile verifyCode:(NSString*) verifyCode;

@end

NS_ASSUME_NONNULL_END
