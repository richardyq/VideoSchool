//
//  MeetingSummaryTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/30.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingSummaryTableViewCell.h"
#import "MeetingEntryModel.h"
@interface MeetingSummaryTableViewCell ()

@property (nonatomic, strong) UILabel* organizerLabel;
@property (nonatomic, strong) VHLabelControl* summaryControl;

@end

@implementation MeetingSummaryTableViewCell

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.organizerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(15);
    }];
    
    [self.summaryControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.equalTo(self.contentView).offset(-25);
    }];
}

#pragma mark - settingAndGetting
- (UILabel*) organizerLabel{
    if (!_organizerLabel) {
        _organizerLabel = [self.contentView addLabel:[UIColor commonGrayTextColor] textSize:13];
    }
    return _organizerLabel;
}

- (VHLabelControl*) summaryControl{
    if (!_summaryControl) {
        _summaryControl = [[VHLabelControl alloc] initWithText:@"简介" font:[UIFont systemFontOfSize:14] textColor:[UIColor mainThemeColor]];
        [self.contentView addSubview: _summaryControl];
    }
    return _summaryControl;
}


- (void) setEntryModel:(EntryModel *)model{
    if (!model || ![model isKindOfClass:[MeetingEntryModel class]]) {
        return;
    }
    MeetingEntryModel* meeting = (MeetingEntryModel*) model;
    if (meeting.circleName && ![meeting.circleName isEmpty]) {
        [self.organizerLabel setText:[NSString stringWithFormat:@"来源：%@", meeting.circleName]];
    }
    
}
@end
