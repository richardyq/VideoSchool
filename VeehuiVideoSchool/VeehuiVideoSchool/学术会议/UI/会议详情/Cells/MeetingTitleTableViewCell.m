//
//  MeetingTitleTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/30.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingTitleTableViewCell.h"
#import "MeetingEntryModel.h"

@interface MeetingTitleTableViewCell ()

@property (nonatomic, strong) UILabel* titleLabel;

@end

@implementation MeetingTitleTableViewCell

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(17, 15, 17, 15));
    }];
}

- (void) setTitle:(NSString*) title{
    [self.titleLabel setText:title lineSpacing:5.5];
}

#pragma mark - settingAndGetting
- (UILabel*) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [self.contentView addLabel:[UIColor commonTextColor] textSize:18];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (void) setEntryModel:(EntryModel *)model{
    if (!model || ![model isKindOfClass:[MeetingEntryModel class]]) {
        return;
    }
    MeetingEntryModel* meeting = (MeetingEntryModel*) model;
    [self setTitle:meeting.title];
}

@end
