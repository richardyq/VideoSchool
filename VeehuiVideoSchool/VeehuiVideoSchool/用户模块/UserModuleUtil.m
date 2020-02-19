//
//  UserModuleUtil.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/17.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "UserModuleUtil.h"

NSString* const kLoginedUserModelKey = @"LoginedUserModel";
NSString* const kLoginedUserTokenKey = @"LoginedUserToken";

@implementation UserModuleUtil

+ (instancetype)shareInstance{
    static id instatnce = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instatnce=[[[self class] alloc] init];
    });
    return instatnce;
}

- (void) saveLoginedUser:(UserInfoModel* _Nullable) userModel{
    _loginedUserModel = userModel;
    if (!userModel) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLoginedUserModelKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else{
        NSDictionary* userDictionary = [userModel mj_keyValues];
        [[NSUserDefaults standardUserDefaults] setObject:userDictionary forKey:kLoginedUserModelKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void) userLogout{
    [self saveLoginedUser:nil];
}

#pragma mark - settingAndGetting
- (NSString*) userToken{
    NSString* userToken = [[NSUserDefaults standardUserDefaults] stringForKey:kLoginedUserTokenKey];
    return userToken;
}
@end
