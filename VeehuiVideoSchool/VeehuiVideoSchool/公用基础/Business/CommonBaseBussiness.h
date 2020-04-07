//
//  CommonBaseBussiness.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonBaseBussiness : NSObject

/**
 obtainMobileVerifyCode
 获取手机验证码
 @param mobile  手机号
 @param result          result 请求数据结果返回回调方法
 @param complete        complete 请求结束回调方法
 */
+ (void) obtainMobileVerifyCode:(NSString*) mobile
                         result:(VHRequestResultHandler) result
                       complete:(VHRequestCompleteHandler) complete;

/**
checkMobileVerifyCode
验证手机验证码
@param mobile           手机号
@param verifyCode       手机验证码
@param result          result 请求数据结果返回回调方法
@param complete        complete 请求结束回调方法
*/
+ (void) checkMobileVerifyCode:(NSString*) mobile
                    verifyCode:(NSString*) verifyCode
                        result:(VHRequestResultHandler) result
                      complete:(VHRequestCompleteHandler) complete;

/**
startbindMobile
绑定手机号
@param mobile  手机号
@param result          result 请求数据结果返回回调方法
@param complete        complete 请求结束回调方法
*/
+ (void) startbindMobile:(NSString*) mobile
                  result:(VHRequestResultHandler) result
                complete:(VHRequestCompleteHandler) complete;

/**
startSeniorSubjects
获取一级学科
@param result          result 请求数据结果返回回调方法
@param complete        complete 请求结束回调方法
*/
+ (void) startSeniorSubjects:(VHRequestResultHandler) result
                    complete:(VHRequestCompleteHandler) complete;
@end

NS_ASSUME_NONNULL_END
