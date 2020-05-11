//
//  MedicalVideoGirdControl.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/31.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalVideoGridControl.h"

@interface MedicalVideoGridControl ()

@property (nonatomic, strong) UIImageView* pictureImageView;
@property (nonatomic, strong) UIView* watchCoverView;
@property (nonatomic, strong) UIImageView* playIconImageView;
@property (nonatomic, strong) UILabel* watchedNumberLabel;

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UIImageView* circlePortraitImageView;
@property (nonatomic, strong) UILabel* circleNameLabel;
@end

@implementation MedicalVideoGridControl

- (id) initWithVideoGroup:(MedicalVideoGroupInfoEntryModel*) videoGroup{
    self = [super init];
    if (self) {
        [self setupVideoGroup:videoGroup];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    
    /*
    CGFloat imgWidth = (kScreenWidth - 25)/3 - 20;
    if ([UIDevice currentDevice].isPad) {
        imgWidth = ((kScreenWidth * 0.7) - 25)/3 -20;
    }
     */
    [self.pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self).offset(-17);
        make.height.equalTo(self.mas_width).offset(-17);
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(12.);
        make.bottom.equalTo(self).offset(-65.);
    }];
    
    [self.watchCoverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.pictureImageView);
        make.height.mas_equalTo(@16.);
    }];
    
    [self.playIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.watchCoverView);
        make.size.mas_equalTo(CGSizeMake(8, 10));
        make.left.equalTo(self.watchCoverView).offset(7);
    }];
    
    [self.watchedNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.watchCoverView);
        make.left.equalTo(self.playIconImageView.mas_right).offset(4);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pictureImageView.mas_bottom).offset(11.);
        make.left.equalTo(self.playIconImageView);
        make.right.lessThanOrEqualTo(self.pictureImageView);
    }];
    
    [self.circlePortraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pictureImageView.mas_bottom).offset(51.);
        make.left.equalTo(self.playIconImageView);
        make.size.mas_equalTo(CGSizeMake(14, 14));
        make.bottom.equalTo(self);
    }];
    
    [self.circleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.circlePortraitImageView);
        make.left.equalTo(self.circlePortraitImageView.mas_right).offset(5);
    }];
}

#pragma mark - settingAndGetting
- (UIImageView*) pictureImageView{
    if (!_pictureImageView) {
        _pictureImageView = [self addImageView:@"img_default_video_in_table"];
        [_pictureImageView setCornerRadius:5];
    }
    return _pictureImageView;
}

- (UIView*) watchCoverView{
    if (!_watchCoverView) {
        _watchCoverView = [self.pictureImageView addView];
        _watchCoverView.backgroundColor = [UIColor colorWithHexString:@"00000054"];
    }
    return _watchCoverView;
}

- (UIImageView*) playIconImageView{
    if (!_playIconImageView) {
        _playIconImageView = [self.watchCoverView addImageView:@"ic_video_watched"];
    }
    return _playIconImageView;
}

- (UILabel*) watchedNumberLabel{
    if (!_watchedNumberLabel) {
        _watchedNumberLabel = [self.watchCoverView addLabel:[UIColor whiteColor] textSize:10];
    }
    return _watchedNumberLabel;
}

- (UILabel*) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [self addLabel:[UIColor commonTextColor] textSize:13 weight:UIFontWeightMedium];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UIImageView*) circlePortraitImageView{
    if (!_circlePortraitImageView) {
        _circlePortraitImageView = [self addImageView:@"icon_default_circle"];
        [_circlePortraitImageView setCornerRadius:7];
    }
    return _circlePortraitImageView;
}

- (UILabel*) circleNameLabel{
    if (!_circleNameLabel) {
        _circleNameLabel = [self addLabel:[UIColor commonGrayTextColor] textSize:11];
    }
    return _circleNameLabel;
}

- (void) setupVideoGroup:(MedicalVideoGroupInfoEntryModel*) videoGroup{
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:videoGroup.pictureUrl] placeholderImage:[UIImage imageNamed:@"img_default_video_in_table"]];
    if (videoGroup.isPrice || videoGroup.price > 0) {
        //精品课程
        [self.pictureImageView addWatermark:@"ic_video_course" positon:WatermarPosition_TL];
    }
    self.watchedNumberLabel.text = [NSString formatWithInteger:videoGroup.watchingNumber remain:1 unit:@"W"];
    //self.titleLabel.text = videoGroup.title;
    [self.titleLabel setText:videoGroup.title lineSpacing:3];
    [self.circlePortraitImageView sd_setImageWithURL:[NSURL URLWithString:videoGroup.circleInfo.portraitUrl] placeholderImage:[UIImage imageNamed:@"icon_default_circle"]];
    self.circleNameLabel.text = videoGroup.circleName;
}

@end
