//
//  MeetingLivingConferenceTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/6.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingLivingConferenceTableViewCell.h"
#import "MeetingDetailModel.h"

@interface MeetingLivingConferenceTableViewCell ()

@property (nonatomic, strong) UIView* detView;

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* speakerLabel;        //主讲专家
@property (nonatomic, strong) UILabel* timeLabel;           //会议时间
@property (nonatomic, strong) UILabel* nextCountDownLabel;  //下一场倒计时

@end

@implementation MeetingLivingConferenceTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor commonBackgroundColor];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    [self.detView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(5, 12.5, 3, 12.5));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.detView).offset(10);
        make.top.equalTo(self.detView).offset(10);
        make.right.lessThanOrEqualTo(self.detView).offset(-31);
    }];
    
    [self.speakerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.detView).offset(10);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.right.lessThanOrEqualTo(self.detView).offset(-31);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.detView).offset(10);
        make.top.equalTo(self.speakerLabel.mas_bottom).offset(10);
        make.right.lessThanOrEqualTo(self.detView).offset(-31);
    }];
    
    [self.nextCountDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.detView).offset(10);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(10);
        make.right.lessThanOrEqualTo(self.detView).offset(-31);
        make.bottom.equalTo(self.detView).offset(-10);
    }];
}

#pragma mark - settingAndGetting
- (UIView*) detView{
    if (!_detView) {
        _detView = [self.contentView addView];
        _detView.backgroundColor = [UIColor whiteColor];
        [_detView setCornerRadius:7];
    }
    return _detView;
}

- (UILabel*) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [self.detView addLabel:[UIColor commonTextColor] textSize:16 weight:UIFontWeightMedium];
    }
    return _titleLabel;
}

- (UILabel*) speakerLabel{
    if (!_speakerLabel) {
        _speakerLabel = [self.detView addLabel:[UIColor commonGrayTextColor] textSize:13];
    }
    return _speakerLabel;
}

- (UILabel*) timeLabel{
    if (!_timeLabel) {
        _timeLabel = [self.detView addLabel:[UIColor commonGrayTextColor] textSize:13];
    }
    return _timeLabel;
}

- (UILabel*) nextCountDownLabel{
    if (!_nextCountDownLabel) {
        _nextCountDownLabel = [self.detView addLabel:[UIColor commonGrayTextColor] textSize:13];
    }
    return _nextCountDownLabel;
}

- (void) setEntryModel:(EntryModel *)model{
    if (!model || ![model isKindOfClass:[MeetingConferenceModel class]]) {
        return;
    }
    
    MeetingConferenceModel* conference = (MeetingConferenceModel*) model;
    self.titleLabel                                                                                                                                                           .text = conference.title;
    self.speakerLabel.text = [NSString stringWithFormat:@"主讲专家：%@", conference.speaker];
    self.timeLabel.text = [NSString stringWithFormat:@"%@ ~ %@", conference.startTime, conference.endTime];
    
    self.nextCountDownLabel.text = @"";
    if ([conference.statusCode isEqualToString:@"03"]) {
        self.nextCountDownLabel.text = @"下一次直播倒计时：";
    }
}

- (void) setIsPlaying:(BOOL) isPlaying{
    if (isPlaying) {
        [self.detView setCornerRadius:7 color:[UIColor redColor] boarderwidth:1];
    }
    else{
        [self.detView setCornerRadius:7 color:[UIColor whiteColor] boarderwidth:1];
    }
}



@end
