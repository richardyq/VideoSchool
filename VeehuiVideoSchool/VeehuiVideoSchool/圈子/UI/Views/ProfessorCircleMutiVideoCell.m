//
//  ProfessorCircleMutiVideoCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/15.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "ProfessorCircleMutiVideoCell.h"
#import "MedicalVideoGroupInfoEntryModel.h"

@interface ProfessorCircleMutiVideoCell ()

@property (nonatomic, strong) UIImageView* videoImageView;
@property (nonatomic, strong) UIView* watchCoverView;
@property (nonatomic, strong) UIImageView* playIconImageView;
@property (nonatomic, strong) UILabel* watchedNumberLabel;

@property (nonatomic, strong) UILabel* titleLabel;
@end
@implementation ProfessorCircleMutiVideoCell

- (id) initWithVideoGroup:(MedicalVideoGroupInfoEntryModel*) videoGroup{
    self = [super init];
    if (self) {
        [self setupVideoGroup:videoGroup];
    }
    return self;
}


- (void) updateConstraints{
    [super updateConstraints];
    
    [self.videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self).offset(-20);
        make.height.equalTo(self.mas_width).offset(-20);
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-68.);
        make.top.equalTo(self).offset(15.);
    }];
    
    [self.watchCoverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.videoImageView);
        make.height.mas_equalTo(@20.);
    }];
    
    [self.playIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.watchCoverView);
        make.left.equalTo(self.watchCoverView).offset(8);
    }];
    
    [self.watchedNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.watchCoverView);
        make.left.equalTo(self.playIconImageView.mas_right).offset(2.5);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.videoImageView.mas_bottom).offset(11.);
        make.left.equalTo(self.playIconImageView);
        make.right.lessThanOrEqualTo(self.videoImageView);
        //make.bottom.equalTo(self).offset(-5.);
    }];
}

#pragma mark - settingAndGetting
- (UIImageView*) videoImageView{
    if (!_videoImageView) {
        _videoImageView = [self addImageView:@"ic_weiyihui_lording"];
        [_videoImageView setCornerRadius:5];
    }
    return _videoImageView;
}

- (UIView*) watchCoverView{
    if (!_watchCoverView) {
        _watchCoverView = [self.videoImageView addView];
        _watchCoverView.backgroundColor = [UIColor colorWithHexString:@"00000054"];
    }
    return _watchCoverView;
}

- (UIImageView*) playIconImageView{
    if (!_playIconImageView) {
        _playIconImageView = [self.watchCoverView addImageView:@"icon_nrfllb_bfrc"];
    }
    return _playIconImageView;
}

- (UILabel*) watchedNumberLabel{
    if (!_watchedNumberLabel) {
        _watchedNumberLabel = [self.watchCoverView addLabel:[UIColor whiteColor] textSize:11];
    }
    return _watchedNumberLabel;
}

- (UILabel*) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [self addLabel:[UIColor commonTextColor] textSize:13];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (void) setupVideoGroup:(MedicalVideoGroupInfoEntryModel*) videoGroup{
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:videoGroup.pictureUrl] placeholderImage:[UIImage imageNamed:@"img_default_video_in_table"]];
    
    self.watchedNumberLabel.text = [NSString formatWithInteger:videoGroup.watchingNumber remain:1 unit:@"万"];
    self.titleLabel.text = videoGroup.title;
    
}
@end
