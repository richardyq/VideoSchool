//
//  UserLoginWithMobileFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "UserLoginWithMobileFunction.h"

@interface UserLoginWithMobileFunction ()

@property (nonatomic, strong) NSString* mobile;
@property (nonatomic, strong) NSString* verifyCode;

@end

@implementation UserLoginWithMobileFunction

- (id) initWithMobile:(NSString*) mobile verifyCode:(NSString*) verifyCode{
    self = [super init];
    if (self) {
        _mobile = mobile;
        _verifyCode = verifyCode;
    }
    return self;
}

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v2/a/mobileLogin", kURL_BASE_NEWDOMAIN];
}

- (EHTTPRequestMethod) requestMethod{
    return Request_POST;
}

- (NSDictionary*) reqeustDictionary{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    if (self.mobile && ![self.mobile isEmpty]) {
        [dict setValue:self.mobile forKey:@"mobile"];
    }
    if (self.verifyCode && ![self.verifyCode isEmpty]) {
        [dict setValue:self.verifyCode forKey:@"verifyCode"];
    }
    [dict setValue:@"01" forKey:@"msgType"];
    
    NSString* systemName = [NSObject systemName];
    if (systemName && ![systemName isEmpty]) {
        [dict setValue:systemName forKey:@"systemName"];
    }
    return dict;
}

- (id) paraserResponse:(id) response{
    if (response && [response isKindOfClass:[NSDictionary class]]) {
        
    }
    return nil;
}

@end
