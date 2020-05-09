//
//  MeetingApplyStayTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/8.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingApplyStayTableViewCell.h"

@interface MeetingApplyStayTableViewCell ()

@property (nonatomic, strong) UISwitch* switchControl;
@end

@implementation MeetingApplyStayTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.valueLabel.hidden = YES;
    }
    return self;
}

-  (void) updateConstraints{
    [super updateConstraints];
    
    [self.switchControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel);
        make.right.equalTo(self.contentView).offset(-12.5);
    }];
}

#pragma mark - settingAndGetting
- (UISwitch*) switchControl{
    if (!_switchControl) {
        _switchControl = (UISwitch*)[self.contentView addView:[UISwitch class]];
    }
    return _switchControl;
}

@end
