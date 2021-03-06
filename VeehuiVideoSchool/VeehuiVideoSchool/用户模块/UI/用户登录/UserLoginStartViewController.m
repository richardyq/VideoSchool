//
//  UserLoginStartViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/17.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "UserLoginStartViewController.h"
#import "UserLoginTypeView.h"
#import "UserInfoBusiness.h"
#import "UserPageRouter.h"

@interface UserLoginStartViewController ()

@property (nonatomic, strong) UIImageView* logoImageView;
//@property (nonatomic, strong) UIButton* closeButton;
@property (nonatomic, strong) UserLoginTypeView* loginTypeView;


@end

@implementation UserLoginStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor commonBackgroundColor];
    
    [self setFd_prefersNavigationBarHidden:YES];
    [self setFd_interactivePopDisabled:YES];
}

- (void) updateViewConstraints{
    [super updateViewConstraints];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-213);
    }];
    
    [self.loginTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.logoImageView.mas_bottom).offset(45);
    }];
}

#pragma mark - settingAndGetting
- (UIImageView*) logoImageView{
    if (!_logoImageView) {
        _logoImageView = [self.view addImageView:@"img_init_logo"];
    }
    return _logoImageView;
}



- (UserLoginTypeView*) loginTypeView{
    if (!_loginTypeView) {
        WS(weakSelf)
        _loginTypeView = [[UserLoginTypeView alloc] initWithLoginTypeHandler:^(EUserLoginType loginType) {
            SAFE_WEAKSELF(weakSelf)
            [weakSelf loginTypeSelected:loginType];
        }];
        [self.view addSubview:_loginTypeView];
    }
    return _loginTypeView;
}

#pragma mark - control events

- (void) loginTypeSelected:(EUserLoginType) loginType{
    switch (loginType) {
        case Login_Wechat:{
            WS(weakSelf)
            [[WechatUtil shareInstance] startWeChatLogin:^(WechatAuthRespModel * _Nonnull authRespModel) {
                SAFE_WEAKSELF(weakSelf)
                [ weakSelf wechatLogin:authRespModel];
            }];
            break;
        }
        case Login_Mobile:{
            //跳转到手机号登录界面
            //[UserPageRouter entryMobileLogin];
            break;
        }
        default:
            break;
    }
}

#pragma mark -
- (void) wechatLogin:(WechatAuthRespModel*) authRespModel{
    WS(weakSelf)
    [UserInfoBusiness startWechatLogin:authRespModel.openid accessToken:authRespModel.accessToken unionId:authRespModel.unionId result:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        
    } complete:^(NSInteger code, NSString *message) {
        SAFE_WEAKSELF(weakSelf)
        if (code != 0) {
            [MessageHubUtil showErrorMessage:message];
            return;
        }
        [weakSelf userLogined];
    }];
}

#pragma mark - 登录完成
- (void) userLogined{
    [self dismissController:[NSNumber numberWithBool:YES]];
}
@end
