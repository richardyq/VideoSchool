//
//  HomeSubjectMeetingTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/1.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "HomeSubjectMeetingTableViewCell.h"
#import "MeetingEntryModel.h"

@interface HomeSubjectMeetingTableViewCell ()

@property (nonatomic, strong) UIView* detview;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* videoLabel;
@property (nonatomic, strong) UILabel* watchedNumber;

@property (nonatomic, strong) UIView* circleview;
@property (nonatomic, strong) UIImageView* circlePortraitImageView;
@property (nonatomic, strong) UILabel* circleNameLabel;

@end

@implementation HomeSubjectMeetingTableViewCell

- (id) initWithMeetingEntry:(MeetingEntryModel*) meeting{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeSubjectMeetingTableViewCell"];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        [self setEntryModel:meeting];
    }
    return self;
}

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
    
    [self.detview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(7, 12.5, 8, 12.5));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detview).offset(21.);
        make.left.equalTo(self.detview).offset(10.);
        make.right.lessThanOrEqualTo(self.detview).offset(-10.);
    }];
    
    [self.videoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(73, 17));
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10.);
    }];
    
    [self.watchedNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.videoLabel.mas_right).offset(8.);
        make.centerY.equalTo(self.videoLabel);
        make.right.lessThanOrEqualTo(self.detview).offset(-10.);
    }];
    
    
    [self.circleview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(27.);
        make.top.equalTo(self.videoLabel.mas_bottom).offset(14.);
        make.bottom.equalTo(self.detview).offset(-17);
        make.left.equalTo(self.videoLabel);
    }];
    
    [self.circlePortraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(27, 27));
        make.left.top.bottom.equalTo(self.circleview);
    }];
    
    [self.circleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.circleview);
        make.left.equalTo(self.circlePortraitImageView.mas_right).offset(7);
        make.right.equalTo(self.circleview).offset(-5);
    }];
}

#pragma mark - settingAndGetting
- (UIView*) detview{
    if (!_detview) {
        _detview = [self.contentView addView];
        _detview.backgroundColor = [UIColor whiteColor];
        [_detview setCornerRadius:8];
    }
    return _detview;
}

- (UILabel*) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [self.detview addLabel:[UIColor commonTextColor] textSize:15];
        _titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel*) videoLabel{
    if (!_videoLabel) {
        _videoLabel = [self.detview addLabel:[UIColor colorWithHexString:@"#60B07D"] textSize:10];
        _videoLabel.textAlignment = NSTextAlignmentCenter;
        [_videoLabel setCornerRadius:8.5 color:[UIColor colorWithHexString:@"#60B07D"] boarderwidth:1];
        _videoLabel.text = @"学术会议视频";
    }
    return _videoLabel;
}

- (UILabel*) watchedNumber{
    if (!_watchedNumber) {
        _watchedNumber = [self.detview addLabel:[UIColor commonGrayTextColor] textSize:11];
    }
    return _watchedNumber;
}

- (UIView*) circleview{
    if (!_circleview) {
        _circleview = [self.detview addView];
        [_circleview setCornerRadius:13.5];
        _circleview.backgroundColor = [UIColor commonBackgroundColor];
    }
    return _circleview;
}

- (UIImageView*) circlePortraitImageView{
    if (!_circlePortraitImageView) {
        _circlePortraitImageView = [self.circleview addImageView:@"icon_default_circle"];
    }
    return _circlePortraitImageView;
}

- (UILabel*) circleNameLabel{
    if (!_circleNameLabel) {
        _circleNameLabel = [self.circleview addLabel:[UIColor commonGrayTextColor] textSize:11];
    }
    return _circleNameLabel;
}

- (void) setEntryModel:(EntryModel *)model{
    if (!model || ![model isKindOfClass:[MeetingEntryModel class]]) {
        return;
    }
    MeetingEntryModel* meetingModel = (MeetingEntryModel*) model;
    self.titleLabel.text = meetingModel.title;
    self.watchedNumber.text = [NSString stringWithFormat:@"%@人已观看", [NSString formatWithInteger:meetingModel.watchingNumber remain:2 unit:@"万"]];
    
    [self.contentView setNeedsUpdateConstraints];
    [self.circlePortraitImageView sd_setImageWithURL:[NSURL URLWithString:meetingModel.circlePortraitUrl] placeholderImage:[UIImage imageNamed:@"icon_default_circle"]];
    self.circleNameLabel.text = meetingModel.circleName;
}
@end
