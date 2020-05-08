//
//  MeetingPreviewDetailCountdownTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/8.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingPreviewDetailCountdownTableViewCell.h"
#import "MeetingDetailModel.h"

@interface MeetingPreviewDetailCountdownTableViewCell ()

@property (nonatomic, strong) UILabel* countdownLabel;
@property (nonatomic, strong) UILabel* appointmentNumberLabel;
@property (nonatomic) NSInteger countdown;

@end

@implementation MeetingPreviewDetailCountdownTableViewCell

- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[VHCountDownUtil shareInstance] stopCountDown:self];
}

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [[VHCountDownUtil shareInstance] startCountDown:self];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.countdownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12.5);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.appointmentNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-12.5);
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(self.contentView).offset(-27);
    }];
}


#pragma mark - settingAndGetting
- (UILabel*) countdownLabel{
    if (!_countdownLabel) {
        _countdownLabel = [self.contentView addLabel:[UIColor commonTextColor] textSize:14 weight:UIFontWeightMedium];
    }
    return _countdownLabel;
}

- (UILabel*) appointmentNumberLabel{
    if (!_appointmentNumberLabel) {
        _appointmentNumberLabel = [self.contentView addLabel:[UIColor commonTextColor] textSize:13];
    }
    return _appointmentNumberLabel;
}

- (void) setEntryModel:(EntryModel *)model{
    if (!model || ![model isKindOfClass:[MeetingEntryModel class]]) {
        return;
    }
    MeetingEntryModel* meeting = (MeetingEntryModel*) model;
    self.appointmentNumberLabel.text = [NSString stringWithFormat:@"%@人已预约", meeting.appointmentNumberInfo];
    
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
    NSMutableAttributedString* attributeString = [[NSMutableAttributedString alloc] initWithString:@"倒计时:" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14],NSForegroundColorAttributeName: [UIColor commonTextColor]}];
    
    NSString* countdownString = [NSString stringWithDuration:self.countdown];
    [attributeString appendAttributedString:[[NSAttributedString alloc] initWithString:countdownString attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18 weight:UIFontWeightMedium],NSForegroundColorAttributeName: [UIColor mainThemeColor]}]];
    self.countdownLabel.attributedText = attributeString;
}
@end
