//
//  UserInfoBusiness.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "UserInfoBusiness.h"
#import "UserLoginWithWechatFunction.h"
#import "UserLoginWithMobileFunction.h"
#import "UserValidateTokenFunction.h"
#import "UserInfoFunction.h"

#import "UserAccountModel.h"
#import "UserModuleUtil.h"

@implementation UserInfoBusiness

+ (void) startWechatLogin:(NSString*) openId
              accessToken:(NSString*) accessToken
                  unionId:(NSString*) unionId
                   result:(VHRequestResultHandler) resultAction
                 complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[UserLoginWithWechatFunction alloc] initWithOpenId:openId accessToken:accessToken unionId:unionId];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:^(id result) {
        if ([result isKindOfClass:[UserAccountModel class]]) {
            UserAccountModel* userAccount = result;
            NSString* token = userAccount.token;
            [[UserModuleUtil shareInstance] saveUserToken:token];
            [[UserModuleUtil shareInstance] saveLoginedUserId:userAccount.userId];
        }
        if (resultAction) {
            resultAction(result);
        }
    } complete:complete];
}

+ (void) startMobileLogin:(NSString*) mobile
                 password:(NSString*) password
                   result:(VHRequestResultHandler) result
                 complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[UserLoginWithMobileFunction alloc] initWithMobile:mobile password:password];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:^(id result) {
        UserAccountModel* userAccount = result;
        NSString* token = userAccount.token;
        [[UserModuleUtil shareInstance] saveUserToken:token];
        [[UserModuleUtil shareInstance] saveLoginedUserId:userAccount.userId];
    } complete:complete];
}

//验证用户登录Token
+ (void) startValidateUserToken:(VHRequestResultHandler) result
                       complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[UserValidateTokenFunction alloc] init];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:^(id result) {
        if ([result isKindOfClass:[UserAccountModel class]]) {
            UserAccountModel* userAccount = (UserAccountModel*) result;
            [[UserModuleUtil shareInstance] saveLoginedUserId:userAccount.userId];
        }
    } complete:complete];
}

//获取当前用户的用户信息
+ (void) startLoadUserInfo:(VHRequestResultHandler) result
                  complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[UserInfoFunction alloc] init];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:^(id result) {
        if ([result isKindOfClass:[UserInfoModel class]]) {
            UserInfoModel* user = result;
            [[UserModuleUtil shareInstance] saveLoginedUser:user];
            [[UserModuleUtil shareInstance] saveLoginedUserId:user.id];
        }
    } complete:complete];
}


@end
