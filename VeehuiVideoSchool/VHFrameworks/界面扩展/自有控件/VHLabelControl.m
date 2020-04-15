//
//  VHLabelControl.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/15.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHLabelControl.h"

@interface VHLabelControl ()

@end

@implementation VHLabelControl
@synthesize textLabel = _textLabel;

- (id) initWithText:(NSString*) text font:(UIFont*) font textColor:(UIColor*) textColor{
    self = [super init];
    if (self) {
        self.textLabel.text = text;
        self.textLabel.font = font;
        self.textLabel.textColor = textColor;
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.equalTo(self).offset(-3);
    }];
}

#pragma mark - settingAndGetting
- (UILabel*) textLabel{
    if (!_textLabel) {
        _textLabel = [self addLabel];
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}

@end
