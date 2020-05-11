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

@property (nonatomic, strong) UIView* bottomview;
 
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
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(7, 8, 8, 8));
    }];
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.detView);
        make.height.mas_equalTo(@49.);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(24, 18));
        make.centerY.equalTo(self.titleView);
        make.left.equalTo(self.titleView).offset(13);
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
    
    UIView* lastBottomView = self.titleLabel;
    if (!self.organizationLabel.hidden) {
        [self.organizationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.detView).offset(10);
            make.right.lessThanOrEqualTo(self.detView);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(16);
        }];
        lastBottomView = self.organizationLabel;
    }
    
    if (!self.watchedNumberLabel.hidden) {
         [self.watchedNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
               make.left.equalTo(self.detView).offset(10);
               make.right.lessThanOrEqualTo(self.detView);
               make.top.equalTo(lastBottomView.mas_bottom).offset(4);
        }];
        lastBottomView = self.watchedNumberLabel;
    }
    
    [self.moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@45);
        make.edges.equalTo(self.moreView).insets(UIEdgeInsetsMake(16, 14, 0, 14));
    }];
    
    if (!self.moreView.hidden) {
        [self.moreView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.detView);
            //make.height.mas_equalTo(@49.);
            make.top.equalTo(lastBottomView.mas_bottom);
        }];
        lastBottomView = self.moreView;
    }
    
    [self.bottomview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.detView);
        make.top.equalTo(lastBottomView.mas_bottom);
        make.height.mas_equalTo(@16);
    }];
}

#pragma mark - settingAndGetting
- (UIView*) detView{
    if (!_detView) {
        _detView = [self.contentView addView];
        _detView.backgroundColor = [UIColor whiteColor];
        [_detView.layer setCornerRadius:8];
        
        // 阴影颜色
        _detView.layer.shadowColor = [UIColor commonBoarderColor].CGColor;
        _detView.layer.shadowOffset = CGSizeMake(0,0);
        // 阴影透明度
        _detView.layer.shadowOpacity = 0.5;
        // 阴影半径
        _detView.layer.shadowRadius = 1;
    }
    return _detView;
}

- (UIView*) bottomview{
    if (!_bottomview) {
        _bottomview = [self.detView addView];
    }
    return _bottomview;
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
        _startDateLabel = [self.titleView addLabel:[UIColor colorWithHexString:@"#080808"] textSize:17 weight:UIFontWeightMedium];
    }
    return _startDateLabel;
}

- (UILabel*) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [self.titleView addLabel:[UIColor commonTextColor] textSize:16];
        _titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel*) organizationLabel{
    if (!_organizationLabel) {
        _organizationLabel = [self.detView addLabel:[UIColor commonDarkGrayTextColor] textSize:13];
        
    }
    return _organizationLabel;
}

- (UILabel*) watchedNumberLabel{
    if (!_watchedNumberLabel) {
        _watchedNumberLabel = [self.detView addLabel:[UIColor commonLightGrayTextColor] textSize:11];
        
    }
    return _watchedNumberLabel;
}

- (UIControl*) moreView{
    if (!_moreView) {
        _moreView = (UIControl*)[self.detView addView:[UIControl class]];
        
        [_moreView addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            //跳转到学术会议首页
            [MeetingPageRouter entryMeetingStartPage];
        }];
    }
    return _moreView;
}

- (UILabel*) moreLabel{
    if (!_moreLabel) {
        _moreLabel = [self.moreView addLabel:[UIColor mainThemeColor] textSize:15];
        _moreLabel.text = @"进入我的机构参加内部培训 >";
        _moreLabel.backgroundColor = [UIColor commonBackgroundColor];
        [_moreLabel setCornerRadius:4];
        _moreLabel.textAlignment = NSTextAlignmentCenter;
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
        self.watchedNumberLabel.text = [NSString stringWithFormat:@"%@人已预约", watchingNumberInfo];
    }
    
    self.moreView.hidden = (shownMeeting.ortherCount == 0);
    self.moreLabel.text = [NSString stringWithFormat:@"其他%ld场会议直播 >", shownMeeting.ortherCount];
    [self.contentView setNeedsUpdateConstraints];
}
@end
