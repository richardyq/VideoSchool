//
//  UserLoginWithMobileFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "UserLoginWithMobileFunction.h"
#import "UserAccountModel.h"

@interface UserLoginWithMobileFunction ()

@property (nonatomic, strong) NSString* mobile;
@property (nonatomic, strong) NSString* password;

@end

@implementation UserLoginWithMobileFunction

- (id) initWithMobile:(NSString*) mobile password:(NSString*) password{
    self = [super init];
    if (self) {
        _mobile = mobile;
        _password = password;
    }
    return self;
}

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v2/app/login/%@/%@", kURL_BASE_NEWDOMAIN,self.mobile, self.password];
}



- (id) reqeustDictionary{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    if (self.mobile && ![self.mobile isEmpty]) {
        [dict setValue:self.mobile forKey:@"mobile"];
    }
    if (self.password && ![self.password isEmpty]) {
        [dict setValue:self.password forKey:@"password"];
    }
    
    return dict;
}

- (id) paraserResponse:(id) response{
    if (response && [response isKindOfClass:[NSString class]]) {
        UserAccountModel* accountModel = [UserAccountModel new];
        accountModel.token = response;
        //UserAccountModel* accountModel = [UserAccountModel mj_objectWithKeyValues:response];
        return accountModel;
    }
    return nil;
}

@end
