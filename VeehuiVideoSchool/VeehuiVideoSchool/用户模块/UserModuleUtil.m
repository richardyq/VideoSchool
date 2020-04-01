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
NSString* const kLoginedUserIdKey = @"LoginedUserId";

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
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLoginedUserTokenKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLoginedUserIdKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //[[VHHTTPRequest shareInstance] setHTTPHeader:nil headerField:@"Authorization"];
}

#pragma mark - settingAndGetting
- (NSString*) userToken{
    NSString* userToken = [[NSUserDefaults standardUserDefaults] stringForKey:kLoginedUserTokenKey];
    return userToken;
}

- (void) saveUserToken:(NSString*) userToken{
    if (!userToken || [userToken isEmpty]) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setValue:userToken forKey:kLoginedUserTokenKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSInteger) loginedUserId{
    NSInteger userId = [[NSUserDefaults standardUserDefaults] integerForKey:kLoginedUserIdKey];
    return userId;
}

- (void) saveLoginedUserId:(NSInteger) userId{
    if (userId == 0) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setInteger:userId forKey:kLoginedUserIdKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL) mobileBind{
    BOOL mobileBind = NO;
    UserInfoModel* userModel = self.loginedUserModel;
    if (!userModel) {
        return mobileBind;
    }
    
    NSString* isBindMobile = userModel.isBindMobile;
    if (!isBindMobile || [isBindMobile isEmpty]) {
        return mobileBind;
    }
    
    mobileBind = [isBindMobile isEqualToString:@"1"];
    return mobileBind;
}
@end
