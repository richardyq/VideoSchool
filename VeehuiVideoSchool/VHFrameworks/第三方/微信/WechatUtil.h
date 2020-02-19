//
//  WechatUtil.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/17.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "WechatAuthRespModel.h"

NS_ASSUME_NONNULL_BEGIN

//微信
extern NSString* const kWeChatID;

//微信
//#define kWECHAT_APPKEY @"wx72478aedc8a1a3d7"
#define kWECHAT_APPSECRET @"8f283cac0bb4f53b93f2f6ae1dc0c0b5"
#define KWECHAT_REDIRECTURL @"http://api.veehui.com/view/downLoadView.html"

typedef void(^WechatAuthHandler)(WechatAuthRespModel* authRespModel);

@interface WechatUtil : NSObject
<WXApiDelegate>
+ (instancetype)shareInstance;
/**
 isWXAppInstalled
 用户手机是否已经安装了微型
 */
- (BOOL) isWXAppInstalled;

/**
 startWeChatLogin
 微信授权登录
 */
- (void) startWeChatLogin:(WechatAuthHandler) authHandler;

@end

NS_ASSUME_NONNULL_END
