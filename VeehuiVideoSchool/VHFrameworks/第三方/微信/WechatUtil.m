//
//  WechatUtil.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/17.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "WechatUtil.h"
#import <UMSocialCore/UMSocialCore.h>
#import "WXApi.h"

NSString* const kWeChatID = @"wx72478aedc8a1a3d7";

@implementation WechatUtil

+ (instancetype)shareInstance{
    static id instatnce = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instatnce=[[[self class] alloc] init];
    });
    return instatnce;
}

- (id) init{
    self = [super init];
    if (self) {
        [WXApi registerApp:kWeChatID];
        
    }
    return self;
}

- (BOOL) isWXAppInstalled{
    return [WXApi isWXAppInstalled];
}

#pragma mark - 授权登录
- (void) startWeChatLogin:(WechatAuthHandler) authHandler{
    if (![self isWXAppInstalled]) {
        return;
    }
    
    UIViewController* topmosController = [NSObject topMostController];
    NSLog(@"topmost view controller is %@", topmosController.className);
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:topmosController completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *resp = result;
        NSString* openid = resp.openid;
        NSString* accessToken = resp.accessToken;
        NSString* unionId = resp.unionId;
        
        NSLog(@"用户获取到微信授权:\n openid = %@\n accessToken = %@\n unionId = %@\n", openid, accessToken, unionId);
        if (authHandler) {
            WechatAuthRespModel* respModel = [[WechatAuthRespModel alloc] initWithOpenId:openid accessToken:accessToken unionId:unionId];
            authHandler(respModel);
        }
    }];
}

#pragma mark - WXApiDelegate
-(void) onReq:(BaseReq*)req{
    
}

-(void) onResp:(BaseResp*)resp{
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        //授权登录
        
    }
}
@end
