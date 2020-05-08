//
//  MeetingPreviewInDayTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/7.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingPreviewInDayTableViewCell.h"
#import "MeetingPreviewDayModel.h"
#import "MeetingPageRouter.h"

@interface MeetingPreviewInDayCell : UIControl

@property (nonatomic, strong) UIImageView* pictureImageView;
@property (nonatomic, strong) UIView* coverView;
@property (nonatomic, strong) UILabel* appointmentLabel;
@property (nonatomic, strong) UILabel* countdownLabel;

@property (nonatomic, strong) UILabel* organizerLabel;      //主办单位
@property (nonatomic, strong) UILabel* undertakeLabel;      //承办单位
@property (nonatomic, strong) UILabel* timeLabel;           //会议时间

@property (nonatomic) NSInteger countdown;

- (id) initWithMeeting:(MeetingEntryModel*) meeting;
@end

@implementation MeetingPreviewInDayCell

- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[VHCountDownUtil shareInstance] stopCountDown:self];
}

- (id) initWithMeeting:(MeetingEntryModel*) meeting{
    self = [super init];
    if (self) {
        [self setupMeeting:meeting];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    [self.pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        CGFloat width = kScreenWidth;
        if ([UIDevice currentDevice].isPad) {
            width = kScreenWidth * 0.7;
        }
        width -= 37;
        CGFloat height = width * (135./354);
        make.height.mas_equalTo(@(height));
    }];
    
    [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.pictureImageView);
        make.height.mas_equalTo(@20);
    }];
    
    [self.appointmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverView).offset(5);
        make.centerY.equalTo(self.coverView);
    }];
    
    [self.countdownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.coverView).offset(-5);
        make.centerY.equalTo(self.coverView);
    }];
    
    [self.organizerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.lessThanOrEqualTo(self);
        make.top.equalTo(self.pictureImageView.mas_bottom).offset(8.5);
    }];
    
    [self.undertakeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.lessThanOrEqualTo(self);
        make.top.equalTo(self.organizerLabel.mas_bottom).offset(8.5);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.lessThanOrEqualTo(self);
        make.top.equalTo(self.undertakeLabel.mas_bottom).offset(8.5);
        make.bottom.equalTo(self).offset(-10);
    }];
}

#pragma mark - settingAndGetting
- (UIImageView*) pictureImageView{
    if (!_pictureImageView) {
        _pictureImageView = [self addImageView:@"img_meeting_list_default"];
        [_pictureImageView setCornerRadius:7];
    }
    return _pictureImageView;
}

- (UIView*) coverView{
    if (!_coverView) {
        _coverView = [self.pictureImageView addView];
        _coverView.backgroundColor = [UIColor commonTransColor];
    }
    return _coverView;
}

- (UILabel*) appointmentLabel{
    if (!_appointmentLabel) {
        _appointmentLabel = [self.coverView addLabel:[UIColor whiteColor] textSize:11];
    }
    return _appointmentLabel;
}

- (UILabel*) countdownLabel{
    if (!_countdownLabel) {
        _countdownLabel = [self.coverView addLabel:[UIColor whiteColor] textSize:11];
    }
    return _countdownLabel;
}

- (UILabel*) organizerLabel{
    if (!_organizerLabel) {
        _organizerLabel = [self addLabel:[UIColor commonDarkGrayTextColor] textSize:13];
    }
    return _organizerLabel;
}

- (UILabel*) undertakeLabel{
    if (!_undertakeLabel) {
        _undertakeLabel = [self addLabel:[UIColor commonDarkGrayTextColor] textSize:13];
    }
    return _undertakeLabel;
}

- (UILabel*) timeLabel{
    if (!_timeLabel) {
        _timeLabel = [self addLabel:[UIColor commonDarkGrayTextColor] textSize:13];
    }
    return _timeLabel;
}

- (void) setupMeeting:(MeetingEntryModel*) meeting{
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:meeting.pictureUrl] placeholderImage:[UIImage imageNamed:@"img_meeting_list_default"]];
    self.appointmentLabel.text = [NSString stringWithFormat:@"%@人已预约观看直播", meeting.appointmentNumberInfo];
    self.countdownLabel.text = @"倒计时:";
    self.organizerLabel.text = [NSString stringWithFormat:@"主办单位: %@", meeting.organizer];
    self.undertakeLabel.text = [NSString stringWithFormat:@"承办单位: %@", meeting.undertake];
    self.timeLabel.text = [NSString stringWithFormat:@"会议时间: %@ ~ %@", meeting.startTime, meeting.endTime];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countdownAction:) name:kCountDownNotifitionName object:nil];
    [[VHCountDownUtil shareInstance] startCountDown:self];
    
    
    NSDate* startData = [NSDate dateWithTimeIntervalSince1970:meeting.startTimeTimeStamp/1000];
    NSLog(@"meeting start date is %@", [startData stringWithFormat:@"yyyy-MM-dd HH:mm:ss"]);
    NSTimeInterval currentTime = [VHCountDownUtil getCurrentTime] ;
    self.countdown = (meeting.startTimeTimeStamp/1000) - currentTime;
}

- (void) countdownAction:(NSNotification*) notification{
    if (--self.countdown <= 0) {
        [[VHCountDownUtil shareInstance] stopCountDown:self];
        return;
    }
    
    NSString* countdownString = [NSString stringWithDuration:self.countdown];
    self.countdownLabel.text = [NSString stringWithFormat:@"倒计时: %@", countdownString];
}
 
@end

@interface MeetingPreviewInDayTableViewCell ()

@property (nonatomic, strong) UIView* lineView;
@property (nonatomic, strong) UIView* dateView;
@property (nonatomic, strong) UILabel* dateLabel;
@property (nonatomic, strong) NSMutableArray<MeetingPreviewInDayCell*>* meetingCells;

@end

@implementation MeetingPreviewInDayTableViewCell

- (id) initWithMeetingDayModel:(MeetingPreviewDayModel*) model{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MeetingPreviewInDayTableViewCell"];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupElements:model];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(17.5);
        make.top.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(@1);
    }];
    
    [self.dateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.lineView);
        make.size.mas_equalTo(CGSizeMake(5, 5));
        make.top.equalTo(self.contentView).offset(15);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateView.mas_right).offset(7.5);
        make.centerY.equalTo(self.dateView);
        make.height.mas_equalTo(@31.);
    }];
    
    __block MASViewAttribute* cellTop = self.dateLabel.mas_bottom;
    [self.meetingCells enumerateObjectsUsingBlock:^(MeetingPreviewInDayCell * _Nonnull meetingCell, NSUInteger idx, BOOL * _Nonnull stop) {
        [meetingCell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.dateLabel);
            make.right.equalTo(self.contentView).offset(-12);
            make.top.equalTo(cellTop).offset(5);
            if (meetingCell == self.meetingCells.lastObject) {
                make.bottom.equalTo(self.contentView);
            }
        }];
        
        cellTop = meetingCell.mas_bottom;
    }];
}

#pragma mark - settingAndGetting
- (UIView*) lineView{
    if (!_lineView) {
        _lineView = [self.contentView addView];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"AFAFAF"];
    }
    return _lineView;
}

- (UIView*) dateView{
    if (!_dateView) {
        _dateView = [self.contentView addView];
        _dateView.backgroundColor = [UIColor mainThemeColor];
        [_dateView setCornerRadius:2.5];
    }
    return _dateView;
}

- (UILabel*) dateLabel{
    if (!_dateLabel) {
        _dateLabel = [self.contentView addLabel:[UIColor mainThemeColor] textSize:13];
    }
    return _dateLabel;
}

- (NSMutableArray<MeetingPreviewInDayCell*>*) meetingCells{
    if (!_meetingCells) {
        _meetingCells = [NSMutableArray<MeetingPreviewInDayCell*> array];
    }
    return _meetingCells;
}

- (void) setupElements:(MeetingPreviewDayModel*) model{
    if (!model || ![model isKindOfClass:[MeetingPreviewDayModel class]]) {
        return;
    }
    self.dateLabel.text = model.date;
    
    [model.meetings enumerateObjectsUsingBlock:^(MeetingEntryModel * _Nonnull meeting, NSUInteger idx, BOOL * _Nonnull stop) {
        MeetingPreviewInDayCell* meetingCell = [[MeetingPreviewInDayCell alloc] initWithMeeting:meeting];
        [self.meetingCells addObject:meetingCell];
        [self.contentView addSubview:meetingCell];
        
        [meetingCell addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [MeetingPageRouter entryMeetingDatailPage:meeting.id];
        }];
    }];
}

@end
