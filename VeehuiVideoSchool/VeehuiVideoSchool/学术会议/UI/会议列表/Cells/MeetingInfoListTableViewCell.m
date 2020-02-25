//
//  MeetingInfoListTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/24.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingInfoListTableViewCell.h"
#import "MeetingEntryModel.h"

@interface MeetingInfoListTableViewCell ()

@property (nonatomic, strong) UIView* mainInfoView;
@property (nonatomic, strong) UIImageView* pictureImageView;
//@property (nonatomic, strong) UIImageView* statusIamgeView;
@property (nonatomic, strong) UIView* mainCoverView;
@property (nonatomic, strong) UIImageView* playIconImageView;
@property (nonatomic, strong) UILabel* leftNumberLabel;
@property (nonatomic, strong) UILabel* rightNumberLabel;

@property (nonatomic, strong) UILabel* organizerLabel;      //主办单位
@property (nonatomic, strong) UILabel* undertakeLabel;      //承办单位
@property (nonatomic, strong) UILabel* detInfoLabel;

@end

@implementation MeetingInfoListTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.mainInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(7.5);
        make.width.equalTo(self.contentView).offset(-30.);
        make.height.mas_offset(@(123. * ScreenSizeRate));
    }];
    
    [self.pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mainInfoView);
    }];
    
    [self.mainCoverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.pictureImageView);
        make.height.mas_equalTo(@32);
    }];
    
    [self.playIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mainCoverView);
        make.left.equalTo(self.mainCoverView).offset(10);
    }];
    
    [self.leftNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.playIconImageView.mas_right).offset(7.);
        make.centerY.equalTo(self.mainCoverView);
    }];
    
    [self.rightNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mainCoverView).offset(-13.);
        make.centerY.equalTo(self.mainCoverView);
    }];
    
    [self.organizerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainInfoView);
        make.right.lessThanOrEqualTo(self.mainInfoView);
        make.top.equalTo(self.mainInfoView.mas_bottom).offset(15.5);
    }];
    
    [self.undertakeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainInfoView);
        make.right.lessThanOrEqualTo(self.mainInfoView);
        make.top.equalTo(self.organizerLabel.mas_bottom).offset(9);
    }];
    
    [self.detInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainInfoView);
        make.right.lessThanOrEqualTo(self.mainInfoView);
        make.top.equalTo(self.undertakeLabel.mas_bottom).offset(12);
        make.bottom.equalTo(self.contentView).offset(-7.5);
    }];
}

#pragma mark - settingAndGetting
- (UIView*) mainInfoView{
    if (!_mainInfoView) {
        _mainInfoView = [self.contentView addView];
        [_mainInfoView setCornerRadius:4.];
    }
    return _mainInfoView;
}

- (UIImageView*) pictureImageView{
    if (!_pictureImageView) {
        _pictureImageView = [self.mainInfoView addImageView:@"img_meeting_list_default"];
    }
    return _pictureImageView;
}

- (UIView*) mainCoverView{
    if (!_mainCoverView) {
        _mainCoverView = [self.pictureImageView addView];
        _mainCoverView.backgroundColor = [UIColor colorWithHexString:@"00000040"];
    }
    return _mainCoverView;
}

- (UIImageView*) playIconImageView{
    if (!_playIconImageView) {
        _playIconImageView = [self.mainCoverView addImageView:@"ic_video_watched"];
    }
    return _playIconImageView;
}

- (UILabel*) leftNumberLabel{
    if (!_leftNumberLabel) {
        _leftNumberLabel = [self.mainCoverView addLabel:[UIColor whiteColor] textSize:13];
    }
    return _leftNumberLabel;
}

- (UILabel*) rightNumberLabel{
    if (!_rightNumberLabel) {
        _rightNumberLabel = [self.mainCoverView addLabel:[UIColor whiteColor] textSize:13];
    }
    return _rightNumberLabel;
}

- (UILabel*) organizerLabel{
    if (!_organizerLabel) {
        _organizerLabel = [self.contentView addLabel:[UIColor commonTextColor] textSize:15];
    }
    return _organizerLabel;
}

- (UILabel*) undertakeLabel{
    if (!_undertakeLabel) {
        _undertakeLabel = [self.contentView addLabel:[UIColor commonTextColor] textSize:15];
    }
    return _undertakeLabel;
}

- (UILabel*) detInfoLabel{
    if (!_detInfoLabel) {
        _detInfoLabel = [self.contentView addLabel:[UIColor commonDarkGrayTextColor] textSize:13];
    }
    return _detInfoLabel;
}

- (void) setEntryModel:(EntryModel *)model{
    if (!model || ![model isKindOfClass:[MeetingEntryModel class]]) {
        return;
    }
    
    MeetingEntryModel* meetingModel = (MeetingEntryModel*) model;
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:meetingModel.pictureUrl]placeholderImage:[UIImage imageNamed:@"img_meeting_list_default"]];
    
    self.organizerLabel.text = [NSString stringWithFormat:@"主办单位: %@", meetingModel.organizer];
    self.undertakeLabel.text = [NSString stringWithFormat:@"承办单位: %@", meetingModel.undertake];
    
    if ([meetingModel.statusCode isEqualToString:@"01"]) {
        //预告
        self.rightNumberLabel.text = [NSString stringWithFormat:@"%ld人已预约", meetingModel.appointmentNumberInfo];
        self.leftNumberLabel.text = @"倒计时:";
        self.detInfoLabel.text = [NSString stringWithFormat:@"会议时间：%@", meetingModel.startTime];
        [self.pictureImageView addWatermark:@"ic_meeting_status_preview" positon:WatermarPosition_TR offset:10];
    }
    
    else if ([meetingModel.statusCode isEqualToString:@"02"] ||
             [meetingModel.statusCode isEqualToString:@"03"]) {
        //直播，休息
        self.leftNumberLabel.text = [NSString stringWithFormat:@"%@", meetingModel.watchingNumberInfo];
        self.rightNumberLabel.text = [NSString stringWithFormat:@"%ld个分会场", meetingModel.liveCount];
        self.detInfoLabel.text = [NSString stringWithFormat:@"会议时间：%@", meetingModel.startTime];
        [self.pictureImageView addWatermark:@"ic_meeting_status_live" positon:WatermarPosition_TR offset:10];
    }
    if ([meetingModel.statusCode isEqualToString:@"04"]) {
        //结束
        self.leftNumberLabel.text = [NSString stringWithFormat:@"%ld", meetingModel.watchingNumber];
        self.rightNumberLabel.text = @"";
        self.detInfoLabel.text = [NSString stringWithFormat:@"主讲专家：%@", meetingModel.speaker];
        [self.pictureImageView addWatermark:@"ic_meeting_status_replay" positon:WatermarPosition_TR offset:10];
    }
}
@end
