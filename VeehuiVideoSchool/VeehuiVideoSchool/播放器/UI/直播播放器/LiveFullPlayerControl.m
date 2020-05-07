//
//  LiveFullPlayerControl.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/7.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "LiveFullPlayerControl.h"

@implementation LiveFullPlayerControl

- (void) layoutElements{
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(Status_Height + 11);
        make.bottom.equalTo(self).offset(-12.5);
    }];
    
    [self.positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.statusLabel.mas_right).offset(5);
        make.centerY.equalTo(self.statusLabel);
    }];
    
    [self.fullScreenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.right.equalTo(self).offset(-25);
        make.bottom.equalTo(self).offset(-7.5);
    }];
}

@end
