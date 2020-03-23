//
//  UserValidateTokenFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "UserValidateTokenFunction.h"
#import "UserModuleUtil.h"
#import "UserAccountModel.h"

@implementation UserValidateTokenFunction

- (NSString*) requestUrl{
    NSString* token = [UserModuleUtil shareInstance].userToken;
    token = [token URLEncodedString];
    return [NSString stringWithFormat:@"%@/v2/a/validate/%@/1/%@", kURL_BASE_NEWDOMAIN, token, [NSObject appVersion]];
}

- (id) paraserResponse:(id) response{
    if (response && [response isKindOfClass:[NSDictionary class]]) {
        return [UserAccountModel mj_objectWithKeyValues:response];
    }
    return nil;
}
@end
