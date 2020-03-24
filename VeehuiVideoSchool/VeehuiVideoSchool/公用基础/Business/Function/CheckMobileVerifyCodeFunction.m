//
//  CheckMobileVerifyCodeFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/23.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "CheckMobileVerifyCodeFunction.h"

@interface CheckMobileVerifyCodeFunction ()

@property (nonatomic, strong) NSString* mobile;
@property (nonatomic, strong) NSString* verifyCode;     //验证码
@end

@implementation CheckMobileVerifyCodeFunction

- (id) initWithMobile:(NSString*) mobile verifyCode:(NSString*) verifyCode{
    self = [super init];
    if (self) {
        _mobile = mobile;
        _verifyCode = verifyCode;
    }
    return self;
}

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v2/o/checkAuthVCode/01/86/%@/%@", kURL_BASE_NEWDOMAIN, self.mobile, self.verifyCode];
}

- (id) paraserResponse:(id) response{
    if (response && [response isKindOfClass:[NSDictionary class]]) {
        
    }
    return nil;
}
@end
