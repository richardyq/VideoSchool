//
//  UserMobileLoginViewController.m
//  VeehuiVideoSchool
//  
//  Created by 殷全 on 2020/2/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "UserMobileLoginViewController.h"
#import "CommonBaseBussiness.h"
#import "UserInfoBusiness.h"

@interface UserMobileLoginViewController ()

@property (nonatomic, strong) UIView* mobileView;
@property (nonatomic, strong) UIImageView* mobileIconImageView;
@property (nonatomic, strong) UITextField* mobileTextField;

@property (nonatomic, strong) UIView* confirmView;
@property (nonatomic, strong) UIImageView* mobileConfirmIconImageView;
//@property (nonatomic, strong) UIButton* mobileConfirmCodeButton;        //获取验证码按钮
@property (nonatomic, strong) UITextField* passwordTextField;

@property (nonatomic, strong) UIButton* loginButton;

@property (nonatomic) NSInteger countDown;

@end

@implementation UserMobileLoginViewController

- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[VHCountDownUtil shareInstance] stopCountDown:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"手机号登录";
}



- (void) updateViewConstraints{
    [super updateViewConstraints];
    
    [self.mobileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(74);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(@47);
        make.width.equalTo(self.view).offset(-45.);
    }];
    
    [self.mobileIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(12, 16));
        make.centerY.equalTo(self.mobileView);
        make.left.equalTo(self.mobileView).offset(12.5);
    }];
    
    [self.mobileTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@31);
        make.centerY.equalTo(self.mobileView);
        make.left.equalTo(self.mobileIconImageView.mas_right).offset(23.5);
        make.right.equalTo(self.mobileView).offset(-14);
    }];
    
    [self.confirmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mobileView.mas_bottom).offset(24.5);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(@47);
        make.width.equalTo(self.view).offset(-45.);
    }];
    
    [self.mobileConfirmIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(12, 16));
        make.centerY.equalTo(self.confirmView);
        make.left.equalTo(self.confirmView).offset(12.5);
    }];
    
    
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@31);
        make.centerY.equalTo(self.confirmView);
        make.left.equalTo(self.mobileIconImageView.mas_right).offset(23.5);
        make.right.equalTo(self.mobileTextField);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view).offset(-45);
        make.height.mas_equalTo(@45.);
        make.top.equalTo(self.confirmView.mas_bottom).offset(32.);
    }];
}

#pragma mark - settingAndGetting

- (UIView*) mobileView{
    if (!_mobileView) {
        _mobileView = [self.view addView];
        [_mobileView showBoarder:UIViewBorderLineTypeBottom];
    }
    return _mobileView;
}

- (UIImageView*) mobileIconImageView{
    if (!_mobileIconImageView) {
        _mobileIconImageView = [self.mobileView addImageView:@"ic_login_mobile"];
    }
    return _mobileIconImageView;
}

- (UITextField*) mobileTextField{
    if (!_mobileTextField) {
        _mobileTextField = [self.mobileView addTextField:@"请输入您的手机号" textColor:[UIColor commonTextColor] textSize:15];
        _mobileTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _mobileTextField.keyboardType = UIKeyboardTypePhonePad;
    }
    return _mobileTextField;
}

- (UIView*) confirmView{
    if (!_confirmView) {
           _confirmView = [self.view addView];
           [_confirmView showBoarder:UIViewBorderLineTypeBottom];
       }
       return _confirmView;
}

- (UIImageView*) mobileConfirmIconImageView{
    if (!_mobileConfirmIconImageView) {
        _mobileConfirmIconImageView = [self.confirmView addImageView:@"ic_login_confirm"];
    }
    return _mobileConfirmIconImageView;
}


- (UITextField*) passwordTextField{
    if (!_passwordTextField) {
        _passwordTextField = [self.confirmView addTextField:@"登录密码" textColor:[UIColor commonTextColor] textSize:15];
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTextField.secureTextEntry = YES;
    }
    return _passwordTextField;
}

- (UIButton*) loginButton{
    if (!_loginButton) {
        _loginButton = [self.view addSolidButton:[UIColor mainThemeColor] size:CGSizeMake(kScreenWidth, 45) title:@"手机号登录" titleSize:15];
        [_loginButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

#pragma mark - button events
- (void) mobileConfirmCodeButtonClicked:(id) sender{
    //验证手机号是否合法
    NSString* mobileNumber = self.mobileTextField.text;
    if (!mobileNumber || [mobileNumber isEmpty]) {
        return;
    }
    
    if (![mobileNumber isMobileNumber]) {
        //不是合法的手机号
        NSLog(@"对不起，输入的手机号不合法，无法获取验证码。");
        return;
    }
    
    self.countDown = 60;
    [[VHCountDownUtil shareInstance] startCountDown:self];
    
    [CommonBaseBussiness obtainMobileVerifyCode:mobileNumber result:^(id result) {
        
    } complete:^(NSInteger code, NSString *message) {
        
    }];
}

- (void) loginButtonClicked:(id) sender{
    NSString* mobileNumber = self.mobileTextField.text;
    NSString* password = self.passwordTextField.text;
    if (!mobileNumber || [mobileNumber isEmpty]) {
        return;
    }
    
    if (![mobileNumber isMobileNumber]) {
        //不是合法的手机号
        NSLog(@"对不起，输入的手机号不合法，无法获取验证码。");
        return;
    }
    
    if (!password || [password isEmpty]) {
        return;
    }
    
    [self startMobileLogin:mobileNumber password:password];
}


- (void) startMobileLogin:(NSString*) mobile password:(NSString*) password{
    WS(weakSelf)
    [UserInfoBusiness startMobileLogin:mobile password:password result:^(id result) {
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
