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
#import "APPVersionFunction.h"
#import "APPVersionInfo.h"
#import "UserInfoBusiness.h"
#import "RootLicensementView.h"
#import "UserPageRouter.h"
#import "CircleBussiness.h"
#import "CommonDataModel.h"
#import "FavoriteChooseViewController.h"

#define kUMENG_APPKEY @"589c350904e205b6b4002031"
#define kUMENG_APPCHANNELID @"App Store"
#define kUSHARE_APPKEY kUMENG_APPKEY

//APP升级地址
#define  kAPPSTORE_APPURL @"https://itunes.apple.com/cn/app/wei-yi-hui-shi-pin/id1203185372?mt=8"
NSString* const kLastCheckUpdateVersionKey = @"LastCheckUpdateVersion";
NSString* const kLicensementVersionKey = @"LicensementVersion";

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
        [self startInitialize];
    }
}

- (void) startInitialize{
    //检查版本更新
    //TODO: 检查版本更新
    [self startCheckVersion];
//    [VHPageRouter entryMainPage];
//    return;
    
   // [self startUserLogin];
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

#pragma mark - 获取版本更新信息
- (void) startCheckVersion{
    
    VHHTTPFunction* function = [[APPVersionFunction alloc] init];
    [MessageHubUtil showWait];
    __block APPVersionInfo* versionInfo = nil;
    WS(weakSelf)
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if ([result isKindOfClass:[APPVersionInfo class]]) {
            versionInfo = result;
        }
        versionInfo = result;
    } complete:^(NSInteger code, NSString *message) {
        [MessageHubUtil hideMessage];
        SAFE_WEAKSELF(weakSelf)
        if (code != 0) {
            [MessageHubUtil showMessage:message];
            return;
        }
        [weakSelf appVersionInfoChecked:versionInfo];
    }];
}

- (void) appVersionInfoChecked:(APPVersionInfo*) versionInfo{
    
    if (!versionInfo) {
        return;
    }
    
    NSString* needUpdate = versionInfo.update;
    if (!needUpdate || [needUpdate isEmpty] || [needUpdate isEqualToString:@"0"]) {
        //不需要升级, 下一步，用户登录
        [self showLicensement];
        return;
    }
    
    NSString* isForce = versionInfo.isForce;
    WS(weakSelf)
    if (isForce && ![isForce isEmpty] && [isForce isEqualToString:@"1"]) {
        //需要强制升级
        [AlertUtil showAlertWithTitle:versionInfo.title message:versionInfo.desc confirmTitle:@"立即升级" confirmHandler:^(UIAlertAction *action) {
            SAFE_WEAKSELF(weakSelf)
            [weakSelf showLicensement];
        }];
    }
    else{
        NSString* lastCheckVersion = [[NSUserDefaults standardUserDefaults] valueForKey:kLastCheckUpdateVersionKey];
        NSString* appVersion = [NSObject appVersion];
        if (lastCheckVersion && ![lastCheckVersion isEmpty] && [lastCheckVersion isEqualToString:appVersion]) {
            //已经检查过改版本，不弹出提示
            [self showLicensement];
            return;
        }
        //不需要强制升级
        [[NSUserDefaults standardUserDefaults] setValue:[NSObject appVersion] forKey:kLastCheckUpdateVersionKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [AlertUtil showAlertWithTitle:versionInfo.title message:versionInfo.desc confirmTitle:@"立即升级" confirmHandler:^(UIAlertAction *action) {
            SAFE_WEAKSELF(weakSelf)
            [weakSelf entryToUpdateAPP];
        } cancelTitle:@"以后再说" cancelHandler:^(UIAlertAction *action) {
            SAFE_WEAKSELF(weakSelf)
            [weakSelf showLicensement];
        }];
    }
}

#pragma mark 显示用户协议
- (void) showLicensement{
    //NSString* appVersion = [NSObject appVersion];
    NSString* licensementVersion = [[NSUserDefaults standardUserDefaults] stringForKey:kLicensementVersionKey];
    BOOL needShowLicensement = NO;
    
    if (!licensementVersion || [licensementVersion isEmpty]) {
        needShowLicensement = YES;
    }
    //needShowLicensement = ![licensementVersion isEqualToString:appVersion];
    if (!needShowLicensement) {
        [self startUserLogin];
        return;
    }
    
    WS(weakSelf)
    [RootLicensementView showWith:nil action:^(id ret) {
        SAFE_WEAKSELF(weakSelf)
        if (ret && [ret isKindOfClass:[NSNumber class]]) {
            NSNumber* retNum = (NSNumber*) ret;
            if (retNum.boolValue) {
                [weakSelf startUserLogin];
                [[NSUserDefaults standardUserDefaults] setObject:[NSObject appVersion] forKey:kLicensementVersionKey];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            else{
                //退出APP
                exit(0);
            }
        }
    }];
}

- (void) entryToUpdateAPP{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kAPPSTORE_APPURL]];
    exit(0);
}

#pragma mark 用户登录
- (void) startUserLogin{
    BOOL needUserLoginWithPage = NO;
    NSString* userToken = [UserModuleUtil shareInstance].userToken;
    if (!userToken || [userToken isEmpty]) {
        needUserLoginWithPage = YES;
    }
    
    if (needUserLoginWithPage) {
    //if (YES) {
        //跳转到登录界面进行登录
        
        [self entryLoginPage];
        return;
    }
    else{
        //验证userToken
        [MessageHubUtil showWait];
        WS(weakSelf)
        [UserInfoBusiness startValidateUserToken:^(id result) {
            SAFE_WEAKSELF(weakSelf)
        } complete:^(NSInteger code, NSString *message) {
            [MessageHubUtil hideMessage];
            SAFE_WEAKSELF(weakSelf)
            if (code != 0) {
                //[MessageHubUtil showErrorMessage:message];
                //验证token失败，进入登录界面t进行登录
                [[UserModuleUtil shareInstance] userLogout];
                [weakSelf entryLoginPage];
            }
            else{
                [weakSelf userLoginAction:YES];
            }
        }];
    }
}

- (void) entryLoginPage{
    BOOL needMobileLogin = NO;
    needMobileLogin = ![WXApi isWXAppInstalled];
    if (needMobileLogin) {
        //手机号登录
        WS(weakSelf)
        [UserPageRouter entryMobileLogin:^(id  _Nonnull ret) {
            SAFE_WEAKSELF(weakSelf)
            NSNumber* loginedNumber = (NSNumber*) ret;
            if (loginedNumber && [loginedNumber isKindOfClass:[NSNumber class]]) {
                BOOL logined = loginedNumber.boolValue;
                [weakSelf userLoginAction:logined];
            }
        }];
        return;
    }
    
    
    WS(weakSelf)
    [VHPageRouter entryIntoUserLoginPage:^(id  _Nonnull ret) {
        SAFE_WEAKSELF(weakSelf)
        
        NSNumber* loginedNumber = (NSNumber*) ret;
        if (loginedNumber && [loginedNumber isKindOfClass:[NSNumber class]]) {
            BOOL logined = loginedNumber.boolValue;
            [weakSelf userLoginAction:logined];
        }
    }];
}

- (void) userLoginAction:(BOOL) logined{
    if (!logined) {
        return;
    }
    
    //用户已经登录，获取用户基本信息
    [self startLoadUserBaseInfo];
}

#pragma mark - 获取用户基本信息
- (void) startLoadUserBaseInfo{
    [MessageHubUtil showWait];
    WS(weakSelf)
    [UserInfoBusiness startLoadUserInfo:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if ([result isKindOfClass:[UserInfoModel class]]) {
            //保存用户信息
            UserInfoModel* userModel = (UserInfoModel*) result;
            [[UserModuleUtil shareInstance] saveLoginedUser:userModel];
        }
    } complete:^(NSInteger code, NSString *message) {
        [MessageHubUtil hideMessage];
        SAFE_WEAKSELF(weakSelf)
        if (code != 0) {
            [MessageHubUtil showErrorMessage:message];
        }
        else{
            //获取用户信息成功
            [weakSelf checkMobileBind];
        }
        
    }];
}

- (void) checkMobileBind{
    if ([UserModuleUtil shareInstance].mobileBind) {
    //if (NO) {
        //已经绑定手机号
        [self mobileBindDone];
    }
    else{
        //需要绑定手机
        WS(weakSelf)
        [VHPageRouter entryBindMobilePage:^(id  _Nonnull ret) {
            SAFE_WEAKSELF(weakSelf)
            if ([ret isKindOfClass:[NSNumber class]]) {
                NSNumber* retNumber =  (NSNumber*)ret;
                if (retNumber.boolValue) {
                    [weakSelf mobileBindDone];
                }
            }
        }];
    }
}

- (void) mobileBindDone{
    //[VHPageRouter entryMainPage];
    [self startLoadJoinedCircles];
}

#pragma mark - 获取加入的圈子
- (void) startLoadJoinedCircles{
    [MessageHubUtil showWait];
    WS(weakSelf)
    [CircleBussiness startLoadUserJoinedCircles:^(id result) {
        if ([result isKindOfClass:[NSArray class]]) {
            [CommonDataModel shareInstance].joinedCircles = result;
        }
    } complete:^(NSInteger code, NSString *message) {
        SAFE_WEAKSELF(weakSelf)
        [MessageHubUtil hideMessage];
        if (code != 0) {
            [MessageHubUtil showMessage:message];
            return;
        }
        if ([CommonDataModel shareInstance].joinedCircles &&
            [CommonDataModel shareInstance].joinedCircles.count > 0) {
            NSInteger circleId = [CommonDataModel shareInstance].joinedCircles.firstObject.circleId;
            [weakSelf startLoadJoinedCircleInfo:circleId];
        }
        else
            [self startLoadUserFavorite];
    }];
}

- (void) startLoadJoinedCircleInfo:(NSInteger) circleId{
    [MessageHubUtil showWait];
    WS(weakSelf)
    [CircleBussiness startLoadUserJoinedCircleInfo:circleId result:^(id result) {
        if ([result isKindOfClass:[JoinedCircleEntryModel class]]) {
            [CommonDataModel shareInstance].joinedCircleInfo = result;
        }
    } complete:^(NSInteger code, NSString *message) {
        SAFE_WEAKSELF(weakSelf)
        [MessageHubUtil hideMessage];
        if (code != 0) {
            [MessageHubUtil showMessage:message];
            return;
        }
        [self startLoadUserFavorite];
    }];
}

#pragma mark - 获取用户的兴趣设置
- (void) startLoadUserFavorite{
    [MessageHubUtil showWait];
    WS(weakSelf)
    [UserInfoBusiness startLoadUserFavorite:^(id result) {
        if (result && [result isKindOfClass:[NSArray class]]) {
            [[UserModuleUtil shareInstance] setFavoriteSubject:result];
        }
    } complete:^(NSInteger code, NSString *message) {
        SAFE_WEAKSELF(weakSelf)
        [MessageHubUtil hideMessage];
        if (code != 0) {
            [MessageHubUtil showMessage:message];
            return;
        }
        
        NSArray<SubjectEntryModel*>* favoriteSubjects = [UserModuleUtil shareInstance].favoriteSubject;
        if (!favoriteSubjects || favoriteSubjects.count == 0) {
        //if (YES) {
            //用户没有设置感兴趣的学科，需要设置
            FavoriteChooseViewController* controller = [[FavoriteChooseViewController alloc] init];
            [VHPageRouter presentViewController:controller];
            
            [controller onDismissControllerHandler:^(id  _Nonnull ret) {
                //设置感兴趣学科成功
                [VHPageRouter entryMainPage];
            }];
            return;
        }
        [VHPageRouter entryMainPage];
    }];
}
@end
