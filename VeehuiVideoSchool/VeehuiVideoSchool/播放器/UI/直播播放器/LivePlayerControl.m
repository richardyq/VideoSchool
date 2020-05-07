//
//  LivePlayerControl.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/7.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "LivePlayerControl.h"

@interface LivePlayerControl ()



@end

@implementation LivePlayerControl

- (id) init{
    self = [super init];
    if (self) {
        self.playAndPauseButton.hidden = YES;
        self.durationLabel.hidden = YES;
        self.progressSlider.hidden = YES;
    }
    return self;
}

- (void) layoutElements{
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(11);
        make.bottom.equalTo(self).offset(-12.5);
    }];
    
    [self.positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.statusLabel.mas_right).offset(5);
        make.centerY.equalTo(self.statusLabel);
    }];
    
    [self.fullScreenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.right.equalTo(self).offset(-11);
        make.bottom.equalTo(self).offset(-7.5);
    }];
}

#pragma mark - settingAndGetting
- (UILabel*) statusLabel{
    if (!_statusLabel) {
        _statusLabel = [self addLabel:[UIColor whiteColor] textSize:13];
        _statusLabel.text = @"直播";
    }
    return _statusLabel;
}

@end
