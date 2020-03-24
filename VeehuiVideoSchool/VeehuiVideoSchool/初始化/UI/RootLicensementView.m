//
//  RootLicensementView.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/24.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "RootLicensementView.h"

@interface RootLicensementView ()

@property (nonatomic, strong) UIView* licensementView;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* licensementLabel;
@property (nonatomic, strong) UIView* bottonView;
@property (nonatomic, strong) UIButton* refuseButton;
@property (nonatomic, strong) UIButton* agreementButton;

@end

@implementation RootLicensementView

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.licensementView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(@285);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@45);
        make.centerX.equalTo(self.licensementView);
        make.top.equalTo(self.licensementView);
    }];
    
    [self.licensementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(12);
        make.centerX.equalTo(self.licensementView);
        make.width.equalTo(self.licensementView).offset(-25);
    }];
    
    [self.bottonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.licensementView);
        make.top.equalTo(self.licensementLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(@45.);
    }];
    
    [self.refuseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.bottonView);
    }];
    
    [self.agreementButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.bottonView);
        make.left.equalTo(self.refuseButton.mas_right);
        make.width.equalTo(self.refuseButton);
    }];
}

#pragma mark settingAndGetting
- (UIView*) licensementView{
    if (!_licensementView) {
        _licensementView = [self addView];
        _licensementView.backgroundColor = [UIColor whiteColor];
        [_licensementView setCornerRadius:8];
    }
    return _licensementView;
}

- (UILabel*) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [self.licensementView addLabel:[UIColor commonTextColor] textSize:18];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.text = @"温馨提示";
    }
    return _titleLabel;
}

- (UILabel*) licensementLabel{
    if (!_licensementLabel) {
        _licensementLabel = [self.licensementView addLabel:[UIColor commonTextColor] textSize:15];
        _licensementLabel.numberOfLines = 0;
        [_licensementLabel setText:@"欢迎使用微医汇学习APP！在你使用时，需要连接数据网络欧洲WLAN网络，产生的流量费用请咨询当地运营商。我们公司非常重视你的隐私保护和个人信息保护。在你使用微医汇学习APP服务前，请认真阅读《用户服务协议》及《微医汇隐私政策》全部条款，你统一并接受全部条款后再开始使用我们的服务。" lineSpacing:5.];
        
    }
    return _licensementLabel;
}

- (UIView*) bottonView{
    if (!_bottonView) {
        _bottonView = [self.licensementView addView];
        
    }
    return _bottonView;
}

- (UIButton*) refuseButton{
    if (!_refuseButton) {
        _refuseButton = [self.bottonView addButton:UIButtonTypeCustom];
        [_refuseButton setTitle:@"不同意" forState:UIControlStateNormal];
        [_refuseButton setTitleColor:[UIColor commonTextColor] forState:UIControlStateNormal];
        _refuseButton.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
        [_refuseButton showBoarder:UIViewBorderLineTypeRight];
        [_refuseButton showBoarder:UIViewBorderLineTypeTop];
        [_refuseButton addTarget:self action:@selector(refuseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _refuseButton;
}

- (UIButton*) agreementButton{
    if (!_agreementButton) {
        _agreementButton = [self.bottonView addButton:UIButtonTypeCustom];
        [_agreementButton setTitle:@"同意并继续" forState:UIControlStateNormal];
        [_agreementButton setTitleColor:[UIColor mainThemeColor] forState:UIControlStateNormal];
        _agreementButton.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
        [_agreementButton showBoarder:UIViewBorderLineTypeTop];
        [_agreementButton addTarget:self action:@selector(agreeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _agreementButton;
}

#pragma mark - button events
- (void) refuseButtonClicked:(id) sender{
    [self close:[NSNumber numberWithBool:NO]];
}

- (void) agreeButtonClicked:(id) sender{
    [self close:[NSNumber numberWithBool:YES]];
}
@end
