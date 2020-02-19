//
//  InitializeUtil.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/17.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "InitializeUtil.h"
#import "UserModuleUtil.h"
#import "IQKeyboardManager.h"
#import <UMSocialCore/UMSocialCore.h>

#define kUMENG_APPKEY @"589c350904e205b6b4002031"
#define kUMENG_APPCHANNELID @"App Store"
#define kUSHARE_APPKEY kUMENG_APPKEY


@interface InitializeUtil ()

@property (nonatomic, readonly) BOOL networkChecked;

@end

@implementation InitializeUtil

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
        [self initializeKeyBord];
        [self startCheckNetStatus];
        [self initailizeThirdLibs];
        
    }
    return self;
}

- (void) initializeKeyBord{
    //初始化键盘
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
}

- (void) startCheckNetStatus{
    _networkChecked = NO;
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    WS(weakSelf)
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (!weakSelf) {
            return ;
        }
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                //未知网络
                NSLog(@"未知网络");
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                //无法联网
                NSLog(@"无法联网");
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                //手机自带网络
                NSLog(@"当前使用的是2g/3g/4g网络");
                [weakSelf networkReachabled:YES];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                //WIFI
                NSLog(@"当前在WIFI网络下");
                [weakSelf networkReachabled:YES];
                break;
            }
                
        }
    }];
    [manager startMonitoring];
}

- (void) networkReachabled:(BOOL) reachable{
    _networkChecked = YES;
    
    if (reachable) {
        //[self startInitialize];
    }
}

- (void) startInitialize{
    
    //检查版本更新
    //TODO: 检查版本更新
    
    [self startUserLogin];
}

#pragma mark - 第三方库初始化
- (void) initailizeThirdLibs{
    [WechatUtil shareInstance];

    [[UMSocialManager defaultManager] setUmSocialAppkey:kUMENG_APPKEY];
    /* 设置微信分享的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession
                                          appKey:kWeChatID
                                       appSecret:kWECHAT_APPSECRET
                                     redirectURL:KWECHAT_REDIRECTURL];
    
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
}

#pragma mark 用户登录
- (void) startUserLogin{
    BOOL needUserLoginWithPage = NO;
    NSString* userToken = [UserModuleUtil shareInstance].userToken;
    if (!userToken || [userToken isEmpty]) {
        needUserLoginWithPage = YES;
    }
    
    if (needUserLoginWithPage) {
        //跳转到登录界面进行登录
        WS(weakSelf)
        [VHPageRouter entryIntoUserLoginPage:^(id  _Nonnull ret) {
            SAFE_WEAKSELF(weakSelf)
            
            NSNumber* loginedNumber = (NSNumber*) ret;
            if (loginedNumber && [loginedNumber isKindOfClass:[NSNumber class]]) {
                BOOL logined = loginedNumber.boolValue;
                [weakSelf userLoginAction:logined];
            }
        }];
        return;
    }
    
}

- (void) userLoginAction:(BOOL) logined{
    if (!logined) {
        return;
    }
    
    //用户已经登录
}
@end
