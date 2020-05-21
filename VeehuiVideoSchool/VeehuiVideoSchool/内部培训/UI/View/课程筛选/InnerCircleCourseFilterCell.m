//
//  InnerCircleCourseFilterCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/21.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "InnerCircleCourseFilterCell.h"

@interface InnerCircleCourseFilterCell ()

@property (nonatomic, strong) UIView* detview;
@property (nonatomic, strong) UIImageView* iconImageView;
@property (nonatomic, strong) UILabel* nameLabel;

@property (nonatomic, strong) UIImage* normalIcon;
@property (nonatomic, strong) UIImage* highlightIcon;

@end

@implementation InnerCircleCourseFilterCell

- (id) initWithName:(NSString*) name iconName:(NSString*) iconName highlightIcon:(NSString*) highIconName{
    self = [super init];
    if (self) {
        self.nameLabel.text = name;
        self.normalIcon = [UIImage imageNamed:iconName];
        self.highlightIcon = [UIImage imageNamed:highIconName];
        self.iconImageView.image = [UIImage imageNamed:iconName];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.detview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.equalTo(self).offset(-3);
        make.width.lessThanOrEqualTo(self).offset(-9);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(12, 12));
        make.centerY.equalTo(self.detview);
        make.right.equalTo(self.detview);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.detview);
        make.left.equalTo(self.detview);
        make.right.equalTo(self.iconImageView.mas_left).offset(-2);
    }];
}

#pragma mark - settingAndGetting
- (UIView*) detview{
    if (!_detview) {
        _detview = [self addView];
        _detview.userInteractionEnabled = NO;
    }
    return _detview;
}

- (UIImageView*) iconImageView{
    if (!_iconImageView) {
        _iconImageView = [self.detview addImageView];
    }
    return _iconImageView;
}

- (UILabel*) nameLabel{
    if (!_nameLabel) {
        _nameLabel = [self.detview addLabel:[UIColor commonGrayTextColor] textSize:13];
    }
    return _nameLabel;
}

- (void) setExplanded:(BOOL) expland{
    
    if (expland) {
        self.iconImageView.image = self.highlightIcon;
    }
    else{
        self.iconImageView.image = self.normalIcon;
    }
}

- (void) changeName:(NSString*) name{
    self.nameLabel.text = name;
    [self setNeedsUpdateConstraints];
}
@end
