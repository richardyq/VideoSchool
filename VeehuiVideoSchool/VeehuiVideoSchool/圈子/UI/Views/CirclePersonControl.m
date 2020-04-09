//
//  CirclePersonControl.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/8.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "CirclePersonControl.h"

@interface CirclePersonControl ()

@property (nonatomic, strong) UIImageView* portraitImageView;
@property (nonatomic, strong) UILabel* nameLabel;
@property (nonatomic, strong) UILabel* summaryLabel;
@property (nonatomic, strong) UIView* rightLineView;

@end

@implementation CirclePersonControl

- (id) initWithCircleEntryModel:(CircleInfoEntryModel*) circle{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setNeedsUpdateConstraints];
        [self setupCircleInfo:circle];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(14);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.portraitImageView.mas_bottom).offset(15);
        make.width.lessThanOrEqualTo(self).offset(-3);
    }];
    
    [self.summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(7);
        make.width.lessThanOrEqualTo(self).offset(-3);
    }];
    
    [self.rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.width.mas_equalTo(@0.5);
        make.centerY.equalTo(self);
        make.height.equalTo(self).offset(-37);
    }];
}

- (void) setupCircleInfo:(CircleInfoEntryModel*) circle{
    [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:circle.portraitUrl] placeholderImage:[UIImage imageNamed:@"icon_default_circle"]];
    self.nameLabel.text = circle.name;
    self.summaryLabel.text = circle.introduction;
}

#pragma mark - settingAndGetting

- (UIImageView*) portraitImageView{
    if (!_portraitImageView) {
        _portraitImageView = [self addImageView:@"icon_default_circle"];
        [_portraitImageView setCornerRadius:5.];
    }
    return _portraitImageView;
}

- (UILabel*) nameLabel{
    if (!_nameLabel) {
        _nameLabel = [self addLabel:[UIColor commonTextColor] textSize:12 weight:UIFontWeightMedium];
    }
    return _nameLabel;
}

- (UILabel*) summaryLabel{
    if (!_summaryLabel) {
        _summaryLabel = [self addLabel:[UIColor commonDarkGrayTextColor] textSize:11];
        _summaryLabel.numberOfLines = 2;
    }
    return _summaryLabel;
}

- (UIView*) rightLineView{
    if (!_rightLineView) {
        _rightLineView = [self addView];
        _rightLineView.backgroundColor = [UIColor commonBoarderColor];
    }
    return _rightLineView;
}

@end
