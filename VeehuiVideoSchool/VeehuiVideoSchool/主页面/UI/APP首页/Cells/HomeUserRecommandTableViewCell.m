//
//  HomeUserRecommandTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/31.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "HomeUserRecommandTableViewCell.h"
#import "UserModuleUtil.h"

@interface HomeUserRecommandTableViewCell ()

@property (nonatomic, strong) UILabel* recommandLabel;

@property (nonatomic, strong) UIView* userView;
@property (nonatomic, strong) UIImageView* portraitImageView;
@property (nonatomic, strong) UILabel* userNameLabel;

@property (nonatomic, strong) UIImageView* leftImageView;
@property (nonatomic, strong) UIImageView* rightImageView;

@end

@implementation HomeUserRecommandTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(28.);
    }];
    
    [self.recommandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.userView.mas_bottom).offset(10.);
        make.bottom.equalTo(self.contentView).offset(-28.);
    }];
    
    [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.userView);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self.userView);
        make.left.equalTo(self.portraitImageView.mas_right).offset(4.);
    }];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.bottom.equalTo(self.recommandLabel).offset(6);
        make.left.equalTo(self.recommandLabel).offset(-21);
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35, 35));
        make.bottom.equalTo(self.recommandLabel).offset(14);
        make.right.equalTo(self.recommandLabel);
    }];
}

#pragma mark - settingAndGetting
- (UILabel*) recommandLabel{
    if (!_recommandLabel) {
        _recommandLabel = [self.contentView addLabel:[UIColor commonDarkGrayTextColor] textSize:12];
        _recommandLabel.text = @"——  根据你感兴趣的学科为你定制  ——";
    }
    return _recommandLabel;
}

- (UIView*) userView{
    if (!_userView) {
        _userView = [self.contentView addView];
    }
    return _userView;
}

- (UIImageView*) portraitImageView{
    if (!_portraitImageView) {
        _portraitImageView = [self.userView addImageView:@"icon_default_user"];
        [_portraitImageView setCornerRadius:12];
        UserInfoModel* user = [UserModuleUtil shareInstance].loginedUserModel;
        [_portraitImageView sd_setImageWithURL:[NSURL URLWithString:user.portraitUrl] placeholderImage:[UIImage imageNamed:@"icon_default_user"]];
    }
    return _portraitImageView;
}

- (UILabel*) userNameLabel{
    if (!_userNameLabel) {
        _userNameLabel = [self.userView addLabel:[UIColor commonTextColor] textSize:14 ];
        _userNameLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        UserInfoModel* user = [UserModuleUtil shareInstance].loginedUserModel;
        _userNameLabel.text = user.name;
    }
    return _userNameLabel;
}

- (UIImageView*) leftImageView{
    if (!_leftImageView) {
        _leftImageView = [self.contentView addImageView:@"index-wldz-bj-dq"];
        _leftImageView.hidden = YES;
    }
    return _leftImageView;
}

- (UIImageView*) rightImageView{
    if (!_rightImageView) {
        _rightImageView = [self.contentView addImageView:@"index-wldz-bj-dq"];
        _rightImageView.hidden = YES;
    }
    return _rightImageView;
}
@end
