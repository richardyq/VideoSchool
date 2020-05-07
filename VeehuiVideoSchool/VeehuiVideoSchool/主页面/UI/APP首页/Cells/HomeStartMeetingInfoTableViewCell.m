//
//  HomeStartMeetingInfoTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/27.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "HomeStartMeetingInfoTableViewCell.h"
#import "HomeMeetingInfoModel.h"
#import "MeetingPageRouter.h"

@interface HomeStartMeetingInfoTableViewCell ()

@property (nonatomic, strong) UIView* detView;

@property (nonatomic, strong) UIView* titleView;
@property (nonatomic, strong) UIImageView* iconImageView;
@property (nonatomic, strong) UILabel* startDateLabel;

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* organizationLabel;
@property (nonatomic, strong) UILabel* watchedNumberLabel;

@property (nonatomic, strong) UIControl* moreView;
@property (nonatomic, strong) UILabel* moreLabel;
 
@end

@implementation HomeStartMeetingInfoTableViewCell

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
    
    [self.detView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(7, 12.5, 8, 12.5));
    }];
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.detView);
        make.height.mas_equalTo(@57.);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(38, 38));
        make.centerY.equalTo(self.titleView);
        make.left.equalTo(self.titleView).offset(10);
    }];
    
    [self.startDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(14);
        make.centerY.equalTo(self.titleView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.detView).offset(10);
        make.right.lessThanOrEqualTo(self.detView);
        make.top.equalTo(self.titleView.mas_bottom).offset(16);
    }];
    
    [self.organizationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.detView).offset(10);
        make.right.lessThanOrEqualTo(self.detView);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(16);
    }];
    
    [self.watchedNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.detView).offset(10);
        make.right.lessThanOrEqualTo(self.detView);
        make.top.equalTo(self.organizationLabel.mas_bottom).offset(9);
        make.bottom.lessThanOrEqualTo(self.detView).offset(-16);
    }];
    
    [self.moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.moreView);
    }];
    
    if (!self.moreView.hidden) {
        [self.moreView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.detView);
            make.height.mas_equalTo(@49.);
            make.top.equalTo(self.watchedNumberLabel.mas_bottom).offset(16);
        }];
    }
}

#pragma mark - settingAndGetting
- (UIView*) detView{
    if (!_detView) {
        _detView = [self.contentView addView];
        _detView.backgroundColor = [UIColor whiteColor];
        [_detView setCornerRadius:8];
    }
    return _detView;
}

- (UIView*) titleView{
    if (!_titleView) {
        _titleView = [self.detView addView];
        [_titleView showBoarder:UIViewBorderLineTypeBottom];
    }
    return _titleView;
}

- (UIImageView*) iconImageView{
    if (!_iconImageView) {
        _iconImageView = [self.titleView addImageView:@"icon_home_meeting"];
    }
    return _iconImageView;
}

- (UILabel*) startDateLabel{
    if (!_startDateLabel) {
        _startDateLabel = [self.titleView addLabel:[UIColor commonTextColor] textSize:16];
        _startDateLabel.font = [UIFont boldSystemFontOfSize:16];
    }
    return _startDateLabel;
}

- (UILabel*) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [self.titleView addLabel:[UIColor commonTextColor] textSize:15];
        _titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel*) organizationLabel{
    if (!_organizationLabel) {
        _organizationLabel = [self.detView addLabel:[UIColor commonTextColor] textSize:14];
        
    }
    return _organizationLabel;
}

- (UILabel*) watchedNumberLabel{
    if (!_watchedNumberLabel) {
        _watchedNumberLabel = [self.detView addLabel:[UIColor commonTextColor] textSize:12];
        
    }
    return _watchedNumberLabel;
}

- (UIControl*) moreView{
    if (!_moreView) {
        _moreView = (UIControl*)[self.detView addView:[UIControl class]];
        [_moreView showBoarder:UIViewBorderLineTypeTop];
        
        [_moreView addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            //跳转到学术会议首页
            [MeetingPageRouter entryMeetingStartPage];
        }];
    }
    return _moreView;
}

- (UILabel*) moreLabel{
    if (!_moreLabel) {
        _moreLabel = [self.moreView addLabel:[UIColor mainThemeColor] textSize:12];
        _moreLabel.text = @"进入我的机构参加内部培训 >";
    }
    return _moreLabel;
}

- (void) setEntryModel:(EntryModel *)model{
    if (!model || ![model isKindOfClass:[HomeMeetingInfoModel class]]) {
        return;
    }
    
    HomeMeetingInfoModel* shownMeeting = (HomeMeetingInfoModel*) model;
    
    self.titleLabel.text = shownMeeting.title;
    
    self.startDateLabel.text = [NSString stringWithFormat:@"会议直播·%@", shownMeeting.nextStartTimeInfo];
    
    self.organizationLabel.text = [NSString stringWithFormat:@"主办单位：%@", shownMeeting.organizer];
    self.organizationLabel.hidden = (!shownMeeting.organizer || shownMeeting.organizer.isEmpty);
    NSString* watchingNumberInfo = [NSString formatWithInteger:shownMeeting.watchingNumber remain:1 unit:@"万"];
    self.watchedNumberLabel.text = [NSString stringWithFormat:@"%@人正在观看直播", watchingNumberInfo];
    self.watchedNumberLabel.hidden = (shownMeeting.watchingNumber == 0);
    if (![shownMeeting.statusCode isEqualToString:@"02"]) {
        self.watchedNumberLabel.text = [NSString stringWithFormat:@"%@人已预约观看直播", watchingNumberInfo];
    }
    
    self.moreView.hidden = (shownMeeting.ortherCount == 0);
    self.moreLabel.text = [NSString stringWithFormat:@"查看其他%ld场会议直播信息 >", shownMeeting.ortherCount];
    [self.contentView setNeedsUpdateConstraints];
}
@end
