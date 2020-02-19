//
//  VHGridItemControl.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/19.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHGridItemControl.h"

@interface VHGridItemControl ()

@property (nonatomic, strong) UIImageView* iconImageView;
@property (nonatomic, strong) UILabel* nameLabel;

@property (nonatomic, readonly) CGSize iconImageSize;
@property (nonatomic, readonly) CGFloat iconTopOffset;
@property (nonatomic, readonly) CGFloat nameTopOffset;
@property (nonatomic, readonly) CGFloat nameBottomOffset;

@end

@implementation VHGridItemControl

- (id) initWithImage:(UIImage*) iconImage
                name:(NSString*) name{
    self = [super init];
    if (self) {
        self.iconImageView.image = iconImage;
        self.nameLabel.text = name;
    }
    return self;
}

- (id) initWithImageName:(NSString*) iconImageName
                    name:(NSString*) name{
    return  [self initWithImage:[UIImage imageNamed:iconImageName] name:name];
    
}

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.iconImageSize);
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(self.iconTopOffset);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.lessThanOrEqualTo(self).offset(-3);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(self.nameTopOffset);
        make.bottom.equalTo(self).offset(-self.nameBottomOffset);
    }];
}

#pragma mark - settingAndGetting
- (UIImageView*) iconImageView{
    if (!_iconImageView) {
        _iconImageView = [self addImageView];
    }
    return _iconImageView;
}

- (UILabel*) nameLabel{
    if (!_nameLabel) {
        _nameLabel = [self buildNameLabel];
    }
    return _nameLabel;
}

- (UILabel*) buildNameLabel{
    return [self addLabel:[UIColor commonTextColor] textSize:13];
}

- (CGSize) iconImageSize{
    return CGSizeMake(24, 24);
}

- (CGFloat) iconTopOffset{
    return 7.5;
}

- (CGFloat) nameTopOffset{
    return 6;
}

- (CGFloat) nameBottomOffset{
    return 7.5;
}

@end
