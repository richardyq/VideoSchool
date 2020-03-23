//
//  UserInfoFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/23.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "UserInfoFunction.h"
#import "UserModuleUtil.h"

@implementation UserInfoFunction

- (NSString*) requestUrl{
    //NSInteger userId = [UserModuleUtil shareInstance].loginedUserId ;
    return [NSString stringWithFormat:@"%@/v2/u/mime", kURL_BASE_NEWDOMAIN];
}

- (id) paraserResponse:(id) response{
    if (response && [response isKindOfClass:[NSDictionary class]]) {
        return [UserInfoModel mj_objectWithKeyValues:response];
    }
    return nil;
}

@end
