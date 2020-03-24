//
//  BindMobileFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/23.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "BindMobileFunction.h"
#import "UserModuleUtil.h"

@interface BindMobileFunction ()

@property (nonatomic, strong) NSString* mobile;

@end

@implementation BindMobileFunction

- (id) initWithMobile:(NSString*) mobile{
    self = [super init];
    if (self) {
        _mobile = mobile;
    }
    return self;
}

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v2/u/bindMobile/01/86", kURL_BASE_NEWDOMAIN];
}

- (EHTTPRequestMethod) requestMethod{
    return Request_POST;
}

- (NSDictionary*) reqeustDictionary{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    if (self.mobile && ![self.mobile isEmpty]) {
        [dict setValue:self.mobile forKey:@"mobile"];
    }
    NSInteger userId = [UserModuleUtil shareInstance].loginedUserId;
    [dict setValue:@"86" forKey:@"mobileAreaCode"];
    [dict setValue:@"07" forKey:@"type"];
    [dict setValue:@(userId) forKey:@"userId"];
    return dict;
}
@end
