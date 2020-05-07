//
//  VHHTTPRequest.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHHTTPRequest.h"
#import "UserModuleUtil.h"

@interface VHHTTPRequest ()

/**
 *[AFNetWorking]的operationManager对象
 */
@property (nonatomic, strong) AFHTTPSessionManager* operationManager;

/**
 *当前的请求operation队列
 */
@property (nonatomic, strong) NSOperationQueue* operationQueue;

@end

@implementation VHHTTPRequest

+ (instancetype)shareInstance{
    static VHHTTPRequest *_request = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _request=[[VHHTTPRequest alloc] init];
    });
    return _request;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.operationManager = [AFHTTPSessionManager manager];
        self.operationQueue = self.operationManager.operationQueue;
        self.operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
        [self setHttpHeader];
    }
    return self;
}

- (void) setHttpHeader{
    self.operationManager.requestSerializer.timeoutInterval = 20.f;
    [self.operationManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    /*
    [self.operationManager.requestSerializer setValue:@"IOS" forHTTPHeaderField:@"os"];
    NSString* appVersion=[NSObject appVersion];
    if (appVersion && appVersion.length > 0) {
        [self.operationManager.requestSerializer setValue:appVersion forHTTPHeaderField:@"loginVersion"];
    }
     */
}

- (void) setHTTPHeader:(NSString*) value headerField:(NSString*) headerField{
    if (value && ![value isEmpty]) {
        [self.operationManager.requestSerializer setValue:value forHTTPHeaderField:headerField];
    }
    else{
        [self.operationManager.requestSerializer setValue:@"" forHTTPHeaderField:headerField];
    }
    
}

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
                     failure:(VHHttpReqeustFailedHandler)failure{
    self.operationManager.requestSerializer.timeoutInterval = 20.f;
    [self setUserTokenToHeaderField];
    NSString* appVersion=[NSObject appVersion];
    [self.operationManager.requestSerializer setValue:appVersion forHTTPHeaderField:@"loginVersion"];
    [self.operationManager.requestSerializer setValue:@"IOS" forHTTPHeaderField:@"os"];
    /*
    if(parameters!=nil&&[parameters count]>0){ //请求参数需要替换
        for (NSString *key in [parameters allKeys]) {
            NSString *value=[NSString stringWithFormat:@"%@",[parameters objectForKey:key]];
            URLString=[URLString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"{%@}",key] withString:value];
        }
    }
    parameters=nil;
    NSString *URL=URLString;
    if (![URLString hasPrefix:@"http"]) { //没有http才加
        URL=[NSString stringWithFormat:@"%@%@",kURL_BASE_NEWDOMAIN,URLString];
    }
     */
    WS(weakSelf)
    NSURLSessionDataTask *dataTask=[self.operationManager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
    }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        SAFE_WEAKSELF(weakSelf)
        if (success) {
            success(weakSelf,responseObject);
        }
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SAFE_WEAKSELF(weakSelf)
        if (failure) {
            failure(weakSelf,error);
        }
    }];
    return dataTask;
}

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
                       failure:(VHHttpReqeustFailedHandler)failure{
    [self setUserTokenToHeaderField];
    WS(weakSelf)
    NSURLSessionDataTask *dataTask=[self.operationManager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        SAFE_WEAKSELF(weakSelf)
        if (success) {
            success(weakSelf,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SAFE_WEAKSELF(weakSelf)
        if (failure) {
            failure(weakSelf,error);
        }
    }];
    return dataTask;
}

#pragma mark PUT请求 block回调
/**
 *功能：POST请求
 *参数：(1)请求的url: urlString
 *     (2)PUT请求体参数:parameters
 *     (3)请求成功调用的Block: success
 *     (4)请求失败调用的Block: failure
 */
- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(NSDictionary*)parameters
                      success:(VHHttpReqeustSuccssHandler)success
                      failure:(VHHttpReqeustFailedHandler)failure{
    [self setUserTokenToHeaderField];
    self.operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/javascript",@"text/json",@"text/plain", nil];
    
    // 设置请求头
    [self.operationManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSString* appVersion=[NSObject appVersion];
    [self.operationManager.requestSerializer setValue:appVersion forHTTPHeaderField:@"loginVersion"];
    [self.operationManager.requestSerializer setValue:@"IOS" forHTTPHeaderField:@"os"];
    
    WS(weakSelf)
    NSURLSessionDataTask *dataTask=[self.operationManager PUT:URLString parameters:parameters  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            SAFE_WEAKSELF(weakSelf)
            success(weakSelf,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            SAFE_WEAKSELF(weakSelf)
            failure(weakSelf,error);
        }
    }];
    return dataTask;
}

- (void)setUserTokenToHeaderField{
    NSString *userToken= [UserModuleUtil shareInstance].userToken;
    if (userToken!=nil&&[userToken length]>0) {
        [self.operationManager.requestSerializer setValue:userToken forHTTPHeaderField:@"Authorization"];
    }else{
        [self.operationManager.requestSerializer clearAuthorizationHeader];
        //[self.operationManager.requestSerializer setValue:@"" forHTTPHeaderField:@"Authorization"];
        //[self.operationManager.requestSerializer setValue:nil forHTTPHeaderField:@"Authorization"];
    }
}
@end
