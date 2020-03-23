//
//  UserLoginWithWechatFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "UserLoginWithWechatFunction.h"
#import "UserAccountModel.h"

@interface UserLoginWithWechatFunction ()

@property (nonatomic, strong) NSString* openId;
@property (nonatomic, strong) NSString* accessToken;
@property (nonatomic, strong) NSString* unionId;

@end

@implementation UserLoginWithWechatFunction

- (id) initWithOpenId:(NSString*) openId accessToken:(NSString*) accessToken unionId:(NSString*) unionId{
    self = [super init];
    if (self) {
        _openId = openId;
        _accessToken = accessToken;
        _unionId = unionId;
    }
    return self;
}

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v2/a/login", kURL_BASE_NEWDOMAIN];
}

- (EHTTPRequestMethod) requestMethod{
    return Request_POST;
}

- (NSDictionary*) reqeustDictionary{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    if (self.openId && ![self.openId isEmpty]) {
        [dict setValue:self.openId forKey:@"openId"];
    }
    if (self.accessToken && ![self.accessToken isEmpty]) {
        [dict setValue:self.accessToken forKey:@"accessToken"];
    }
    if (self.unionId && ![self.unionId isEmpty]) {
        [dict setValue:self.unionId forKey:@"unionId"];
    }
    
    NSString* systemName = [NSObject systemName];
    if (systemName && ![systemName isEmpty]) {
        [dict setValue:systemName forKey:@"systemName"];
    }
    return dict;
}

- (id) paraserResponse:(id) response{
    if (response && [response isKindOfClass:[NSDictionary class]]) {
        UserAccountModel* accountModel = [UserAccountModel mj_objectWithKeyValues:response];
        return accountModel;
    }
    return nil;
}
@end
