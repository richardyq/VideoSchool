//
//  UserInfoBusiness.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoBusiness : NSObject

/**
 startWechatLogin
 通过微信登录，获取到微信授权后，调用接口，获取用户token
 @param openId          openId
 @param accessToken     accessToken
 @param unionId         unionId
 @param result          result 请求数据结果返回回调方法
 @param complete        complete 请求结束回调方法
 */
+ (void) startWechatLogin:(NSString*) openId
              accessToken:(NSString*) accessToken
                  unionId:(NSString*) unionId
                   result:(VHRequestResultHandler) result
                 complete:(VHRequestCompleteHandler) complete;

/**
startMobileLogin
通过手机号登录，获取到微信授权后，调用接口，获取用户token
@param mobile          手机号
@param verifyCode      验证码
@param result          result 请求数据结果返回回调方法
@param complete        complete 请求结束回调方法
*/
+ (void) startMobileLogin:(NSString*) mobile
               verifyCode:(NSString*) verifyCode
                   result:(VHRequestResultHandler) result
                 complete:(VHRequestCompleteHandler) complete;

@end

NS_ASSUME_NONNULL_END
