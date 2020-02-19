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

@implementation UserInfoBusiness

+ (void) startWechatLogin:(NSString*) openId
              accessToken:(NSString*) accessToken
                  unionId:(NSString*) unionId
                   result:(VHRequestResultHandler) result
                 complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[UserLoginWithWechatFunction alloc] initWithOpenId:openId accessToken:accessToken unionId:unionId];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:result complete:complete];
}

+ (void) startMobileLogin:(NSString*) mobile
               verifyCode:(NSString*) verifyCode
                   result:(VHRequestResultHandler) result
                 complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[UserLoginWithMobileFunction alloc] initWithMobile:mobile verifyCode:verifyCode];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:result complete:complete];
}
@end
