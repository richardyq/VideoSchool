//
//  MedicalVideoGroupOtherVideoTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/12.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalVideoGroupOtherVideoTableViewCell.h"
#import "MedicalVideoGroupInfoEntryModel.h"

@interface MedicalVideoGroupOtherVideoTableViewCell ()

@property (nonatomic, strong) UIImageView* videoImageView;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UIView* circleView;
@property (nonatomic, strong) UIImageView* circleImageView;
@property (nonatomic, strong) UILabel* circleNameLabel;
@property (nonatomic, strong) UIView* bottomLineView;
@end

@implementation MedicalVideoGroupOtherVideoTableViewCell

- (void) updateConstraints{
    [super updateConstraints];
    [self.videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(129, 73.));
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(15);
        make.bottom.equalTo(self.contentView).offset(-15.);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.videoImageView);
        make.left.equalTo(self.videoImageView.mas_right).offset(13.);
        make.right.lessThanOrEqualTo(self.contentView).offset(-11.);
    }];
    
    [self.circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@24);
        make.left.equalTo(self.titleLabel);
        make.bottom.equalTo(self.videoImageView);
        make.right.lessThanOrEqualTo(self.contentView).offset(-11);
    }];
    
    [self.circleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(16, 16));
        make.centerY.equalTo(self.circleView);
        make.left.equalTo(self.circleView).offset(8);
    }];
    
    [self.circleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.circleImageView.mas_right).offset(5);
        make.centerY.equalTo(self.circleView);
        make.right.equalTo(self.circleView).offset(-9);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15.);
        make.right.equalTo(self.contentView).offset(-15.);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(@0.5);
    }];
}

#pragma mark - settingAndGetting
- (UIImageView*) videoImageView{
    if (!_videoImageView) {
        _videoImageView = [self.contentView addImageView:@"img_default_main"];
        [_videoImageView setCornerRadius:3.];
    }
    return _videoImageView;
}

- (UILabel*) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [self.contentView addLabel:[UIColor commonTextColor] textSize:15];
        _titleLabel.font = [UIFont systemFontOfSize:15. weight:UIFontWeightMedium];
    }
    return _titleLabel;
}

- (UIView*) circleView{
    if (!_circleView) {
        _circleView = [self.contentView addView];
        _circleView.backgroundColor = [UIColor commonBackgroundColor];
        [_circleView setCornerRadius:12.];
    }
    return _circleView;
}

- (UIImageView*) circleImageView{
    if (!_circleImageView) {
        _circleImageView = [self.circleView addImageView:@"icon_default_circle"];
        [_circleImageView setCornerRadius:8];
    }
    return _circleImageView;
}

- (UILabel*) circleNameLabel{
    if (!_circleNameLabel) {
        _circleNameLabel = [self.circleView addLabel:[UIColor commonDarkGrayTextColor] textSize:12];
    }
    return _circleNameLabel;
}

- (UIView*) bottomLineView{
    if (!_bottomLineView) {
        _bottomLineView = [self.contentView addView];
        _bottomLineView.backgroundColor = [UIColor commonBoarderColor];
    }
    return _bottomLineView;
}

- (void) setEntryModel:(EntryModel *)model{
    if (!model || ![model isKindOfClass:[MedicalVideoGroupInfoEntryModel class]]) {
        return;
    }

    MedicalVideoGroupInfoEntryModel* groupModel = (MedicalVideoGroupInfoEntryModel*) model;
    self.titleLabel.text = groupModel.title;
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:groupModel.pictureUrl] placeholderImage:[UIImage imageNamed:@"img_default_main"]];
    [self.circleImageView sd_setImageWithURL:[NSURL URLWithString:groupModel.circleInfo.portraitUrl] placeholderImage:[UIImage imageNamed:@"icon_default_circle"]];
    self.circleNameLabel.text = groupModel.circleName;
}
@end
