//
//  MeetingWatchCountTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/6.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingWatchCountTableViewCell.h"
#import "MeetingDetailModel.h"

@interface MeetingWatchCountTableViewCell ()

@property (nonatomic, strong) UIImageView* iconImageView;
@property (nonatomic, strong) UILabel* numberLabel;

@end

@implementation MeetingWatchCountTableViewCell

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(12.5);
        make.height.equalTo(self.contentView).offset(-17);
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.iconImageView.mas_right).offset(8);
    }];
}

#pragma mark - settingAndGetting
- (UIImageView*) iconImageView{
    if (!_iconImageView) {
        _iconImageView = [self.contentView addImageView:@"ic_meeting_watch_number"];
    }
    return _iconImageView;
}

- (UILabel*) numberLabel{
    if (!_numberLabel) {
        _numberLabel = [self.contentView addLabel:[UIColor commonDarkGrayTextColor] textSize:12];
    }
    return _numberLabel;
}

- (void) setEntryModel:(EntryModel *)model{
    if (!model || ![model isKindOfClass:[MeetingEntryModel class]]) {
        return;
    }
    MeetingEntryModel* meeting = (MeetingEntryModel*) model;
    self.numberLabel.text = meeting.watchingNumberInfo;
}
@end
