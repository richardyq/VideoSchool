//
//  VHHTTPRequest.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class VHHTTPRequest;

typedef void(^VHHttpReqeustSuccssHandler)(VHHTTPRequest * _Nullable request, id response);
typedef void(^VHHttpReqeustFailedHandler)(VHHTTPRequest * request, NSError * err);


@interface VHHTTPRequest : NSObject

+ (instancetype)shareInstance;

#pragma mark GET请求 block回调
/**
 *功能：GET请求
 *参数：(1)请求的url: urlString
 *     (2)请求成功调用的Block: success
 *     (3)请求失败调用的Block: failure
 */
- (NSURLSessionDataTask*)GET:(NSString *)URLString
                  parameters:(NSDictionary*)parameters
                     success:(VHHttpReqeustSuccssHandler)success
                     failure:(VHHttpReqeustFailedHandler)failure;

#pragma mark POST请求 block回调
/**
 *功能：POST请求
 *参数：(1)请求的url: urlString
 *     (2)POST请求体参数:parameters
 *     (3)请求成功调用的Block: success
 *     (4)请求失败调用的Block: failure
 */
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(NSDictionary*)parameters
                       success:(VHHttpReqeustSuccssHandler)success
                       failure:(VHHttpReqeustFailedHandler)failure;

#pragma mark PUT请求 block回调
/**
 *功能：PUT请求
 *参数：(1)请求的url: urlString
 *     (2)PUT请求体参数:parameters
 *     (3)请求成功调用的Block: success
 *     (4)请求失败调用的Block: failure
 */
- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(NSDictionary*)parameters
                      success:(VHHttpReqeustSuccssHandler)success
                      failure:(VHHttpReqeustFailedHandler)failure;

- (void) setHTTPHeader:(NSString*) value headerField:(NSString*) headerField;
@end

NS_ASSUME_NONNULL_END
