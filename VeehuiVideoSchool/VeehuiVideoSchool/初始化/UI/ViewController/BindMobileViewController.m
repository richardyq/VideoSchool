//
//  BindMobileViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/23.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "BindMobileViewController.h"
#import "CommonBaseBussiness.h"

@interface BindMobileViewController ()

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UITextField* mobileTextField;
@property (nonatomic, strong) UITextField* verifyCodeTextField;
@property (nonatomic, strong) UIButton* verifyCodeButton;
@property (nonatomic, strong) UIButton* bindMobileButton;
@property (nonatomic) NSInteger countdown;

@end

@implementation BindMobileViewController

- (void) dealloc{
    [[VHCountDownUtil shareInstance] stopCountDown:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setFd_prefersNavigationBarHidden:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownAction:) name:kCountDownNotifitionName object:nil];
}

- (void) updateViewConstraints{
    [super updateViewConstraints];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).offset(-75.);
        make.top.equalTo(self.view).offset(Navi_height);
    }];
    
    [self.mobileTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(@41);
        make.width.mas_equalTo(@275);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(25.);
    }];
    
    [self.verifyCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mobileTextField);
        make.top.equalTo(self.mobileTextField.mas_bottom).offset(27.);
        make.size.mas_equalTo(CGSizeMake(85, 35));
    }];
    
    [self.verifyCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mobileTextField);
        make.bottom.equalTo(self.verifyCodeButton).offset(3);
        make.height.mas_equalTo(@41);
        make.right.equalTo(self.verifyCodeButton.mas_left).offset(-2);
    }];
    
    [self.bindMobileButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(215, 45));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.verifyCodeTextField.mas_bottom).offset(30.);
    }];
}


#pragma mark - settingAndGetting
- (UILabel*) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [self.view addLabel:[UIColor commonTextColor] textSize:26];
        _titleLabel.text = @"绑定手机号";
        _titleLabel.font = [UIFont boldSystemFontOfSize:26];
    }
    return _titleLabel;
}

- (UITextField*) mobileTextField{
    if (!_mobileTextField) {
        _mobileTextField = [self.view addTextField:@"请输入手机号" textColor:[UIColor commonTextColor] textSize:16];
        [_mobileTextField showBoarder:UIViewBorderLineTypeBottom];
        _mobileTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _mobileTextField;
}

- (UITextField*) verifyCodeTextField{
    if (!_verifyCodeTextField) {
        _verifyCodeTextField = [self.view addTextField:@"请输入验证码" textColor:[UIColor commonTextColor] textSize:16];
        [_verifyCodeTextField showBoarder:UIViewBorderLineTypeBottom];
        _verifyCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _verifyCodeTextField;
}

- (UIButton*) verifyCodeButton{
    if (!_verifyCodeButton) {
        _verifyCodeButton = [self.view addSolidButton:[UIColor mainThemeColor] size:CGSizeMake(85, 35) title:@"获取验证码" titleSize:12];
        [_verifyCodeButton addTarget:self action:@selector(verifyCodeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _verifyCodeButton;
}

- (UIButton*) bindMobileButton{
    if (!_bindMobileButton) {
        _bindMobileButton = [self.view addSolidButton:[UIColor mainThemeColor] size:CGSizeMake(215, 45) title:@"绑定手机号" titleSize:14];
        [_bindMobileButton addTarget:self action:@selector(bindMobileButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bindMobileButton;
}

#pragma mark - button event
- (void) verifyCodeButtonClicked:(id) sender{
    //获取验证码
    NSString* mobile = self.mobileTextField.text;
    if (!mobile || [mobile isEmpty]) {
        [MessageHubUtil showMessage:@"请输入手机号"];
        return;
    }
    if (![mobile isMobileNumber]) {
        [MessageHubUtil showMessage:@"请输入正确的手机号"];
        return;
    }
    
    [MessageHubUtil showWait];
    WS(weakSelf)
    [CommonBaseBussiness obtainMobileVerifyCode:mobile result:^(id result) {
    
    } complete:^(NSInteger code, NSString *message) {
        SAFE_WEAKSELF(weakSelf)
        [MessageHubUtil hideMessage];
        if (code != 0) {
            [MessageHubUtil showMessage:message];
            return;
        }
        else{
            self.countdown = 60;
            [[VHCountDownUtil shareInstance] startCountDown:self];
        }
    }];
}

- (void) bindMobileButtonClicked:(id) sender{
    NSString* mobile = self.mobileTextField.text;
    NSString* verifyCode = self.verifyCodeTextField.text;
    if (!mobile || [mobile isEmpty]) {
        [MessageHubUtil showMessage:@"请输入手机号"];
        return;
    }
    if (![mobile isMobileNumber]) {
        [MessageHubUtil showMessage:@"请输入正确的手机号"];
        return;
    }
    if (!verifyCode || [verifyCode isEmpty]) {
        [MessageHubUtil showMessage:@"请输入手机验证码"];
        return;
    }
    
    //验证验证码是否合法
    [MessageHubUtil showWait];
    WS(weakSelf)
    [CommonBaseBussiness checkMobileVerifyCode:mobile verifyCode:verifyCode result:^(id result) {
        
    } complete:^(NSInteger code, NSString *message) {
        
        SAFE_WEAKSELF(weakSelf)
        if (code != 0) {
            [MessageHubUtil showMessage:message];
            [MessageHubUtil hideMessage];
            return;
        }
        //手机验证码验证成功，继续绑定手机号
        [self bindMobile];
    }];
}

#pragma mark - 倒计时广播事件
- (void) countDownAction:(NSNotification*) notifition{
    
    if (--self.countdown > 0) {
        
        [self.verifyCodeButton setTitle:[NSString stringWithFormat:@"%lds后重发", self.countdown] forState:UIControlStateDisabled];
    }
    else{
        [[VHCountDownUtil shareInstance] stopCountDown:self];
        
    }
    self.verifyCodeButton.enabled = (self.countdown <= 0);
}

#pragma mark -
- (void) bindMobile{
    WS(weakSelf)
    [CommonBaseBussiness startbindMobile:self.mobileTextField.text result:^(id result) {
        
    } complete:^(NSInteger code, NSString *message) {
        [MessageHubUtil hideMessage];
        SAFE_WEAKSELF(weakSelf)
        if (code != 0) {
            [MessageHubUtil showMessage:message];
            return;
        }
        [weakSelf mobileBindDone];
    }];
}

- (void) mobileBindDone{
    [self dismissController:[NSNumber numberWithBool:YES]];
}
 
@end
