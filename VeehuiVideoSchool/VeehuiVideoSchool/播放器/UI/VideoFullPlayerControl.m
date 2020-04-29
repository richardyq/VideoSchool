//
//  VideoFullPlayerControl.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/29.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VideoFullPlayerControl.h"

@implementation VideoFullPlayerControl

- (void) layoutElements{
    [self.playAndPauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.left.equalTo(self).offset(25);
        make.bottom.equalTo(self).offset(-12.5);
    }];

    [self.fullScreenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.right.equalTo(self).offset(-25);
        make.bottom.equalTo(self).offset(-12.5);
    }];
    
    [self.progressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.playAndPauseButton);
        make.left.equalTo(self.playAndPauseButton.mas_right).offset(15);
        make.right.equalTo(self.fullScreenButton.mas_left).offset(-15);
    }];
    
    [self.positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.progressSlider);
        make.bottom.equalTo(self.progressSlider.mas_top);
    }];
    
    [self.durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.progressSlider);
        make.bottom.equalTo(self.progressSlider.mas_top);
    }];
}

@end
