//
//  CheckMobileVerifyCodeFunction.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/23.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHHTTPFunction.h"

NS_ASSUME_NONNULL_BEGIN

@interface CheckMobileVerifyCodeFunction : VHHTTPFunction

- (id) initWithMobile:(NSString*) mobile verifyCode:(NSString*) verifyCode;

@end

NS_ASSUME_NONNULL_END
