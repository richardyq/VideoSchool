//
//  MedicalVideoDetailCircleTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/12.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalVideoDetailCircleTableViewCell.h"
#import "CircleInfoEntryModel.h"

@interface MedicalVideoDetailCircleTableViewCell ()

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UIImageView* portraitImageView;
@property (nonatomic, strong) UILabel* nameLabel;
@property (nonatomic, strong) UILabel* organizationLabel;

@end

@implementation MedicalVideoDetailCircleTableViewCell

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(22.);
        
    }];
    
    [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(52, 52));
        make.left.equalTo(self.contentView).offset(18);
        make.bottom.equalTo(self.contentView).offset(-20.);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(22.);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.portraitImageView.mas_right).offset(17.);
        make.top.equalTo(self.portraitImageView);
        make.right.lessThanOrEqualTo(self.contentView).offset(-15.);
    }];
    
    [self.organizationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.portraitImageView.mas_right).offset(17.);
        make.bottom.equalTo(self.portraitImageView);
        make.right.lessThanOrEqualTo(self.contentView).offset(-15.);
    }];
}

#pragma mark - settingAndGetting
- (UILabel*) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [self.contentView addLabel:[UIColor commonTextColor] textSize:16];
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _titleLabel.text = @"圈子信息";
    }
    return _titleLabel;
}

- (UIImageView*) portraitImageView{
    if (!_portraitImageView) {
        _portraitImageView = [self.contentView addImageView:@"icon_default_circle"];
        [_portraitImageView setCornerRadius:26];
    }
    return _portraitImageView;
}

- (UILabel*) nameLabel{
    if (!_nameLabel) {
        _nameLabel = [self.contentView addLabel:[UIColor commonTextColor] textSize:15];
        _nameLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    return _nameLabel;
}

- (UILabel*) organizationLabel{
    if (!_organizationLabel) {
        _organizationLabel = [self.contentView addLabel:[UIColor commonDarkGrayTextColor] textSize:13];
    }
    return _organizationLabel;
}

- (void) setEntryModel:(EntryModel *)model{
    if (!model || ![model isKindOfClass:[CircleInfoEntryModel class]]) {
        return;
    }
    
    CircleInfoEntryModel* circleModel = (CircleInfoEntryModel*) model;
    self.nameLabel.text = circleModel.name;
    self.organizationLabel.text = circleModel.organization;
    //icon_default_circle
    [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:circleModel.portraitUrl] placeholderImage:[UIImage imageNamed:@"icon_default_circle"]];
}

@end
