//
//  ProfessorCircleInfoTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/8.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "ProfessorCircleInfoTableViewCell.h"
#import "CircleInfoEntryModel.h"

@interface ProfessorCircleInfoTableViewCell ()

@property (nonatomic, strong) UIView* detview;
@property (nonatomic, strong) UIView* headerview;
@property (nonatomic, strong) UIImageView* portraitImageView;
@property (nonatomic, strong) UILabel* nameLabel;
@property (nonatomic, strong) UILabel* deptLabel;

@property (nonatomic, strong) UIView* videoView;

@property (nonatomic, strong) UIView* footerview;
@property (nonatomic, strong) UILabel* timeLabel;
@property (nonatomic, strong) UIImageView* fellowImageView;
@property (nonatomic, strong) UILabel* fellowNumberLabel;

@end

@implementation ProfessorCircleInfoTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];

    [self.detview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(7, 12.5, 8, 12.5));
   // make.height.mas_equalTo(@205.);
    }];
    
    [self.headerview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.detview);
        make.width.equalTo(self.detview).offset(-25);
        make.top.equalTo(self.detview);
        make.height.mas_equalTo(@72);
    }];
    
    [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerview);
        make.centerY.equalTo(self.headerview);
        make.size.mas_equalTo(CGSizeMake(38, 38));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.portraitImageView.mas_right).offset(13.);
        make.right.lessThanOrEqualTo(self.headerview);
        make.top.equalTo(self.portraitImageView);
    }];
    
    [self.deptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.portraitImageView.mas_right).offset(13.);
        make.right.lessThanOrEqualTo(self.headerview);
        make.bottom.equalTo(self.portraitImageView);
    }];
    
    [self.videoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.detview);
        make.width.equalTo(self.detview).offset(-25);
        make.top.equalTo(self.headerview.mas_bottom);
        make.height.mas_greaterThanOrEqualTo(@113.);
    }];
    
    [self.footerview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.detview);
        make.width.equalTo(self.detview).offset(-25);
        make.top.equalTo(self.videoView.mas_bottom);
        make.bottom.equalTo(self.detview);
        make.height.mas_equalTo(@42.);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.footerview);
        make.left.equalTo(self.footerview);
    }];
    
    [self.fellowNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.footerview);
        make.right.equalTo(self.footerview);
    }];
    
    [self.fellowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.footerview);
        make.right.equalTo(self.fellowNumberLabel.mas_left).offset(-5.);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
}

#pragma mark - settingAndGetting

- (UIView*) detview{
    if (!_detview) {
        _detview = [self.contentView addView];
        _detview.backgroundColor = [UIColor whiteColor];
        [_detview setCornerRadius:8];
    }
    return _detview;
}

- (UIView*) headerview{
    if (!_headerview) {
        _headerview = [self.detview addView];
    }
    return _headerview;
}

- (UIImageView*) portraitImageView{
    if (!_portraitImageView) {
        _portraitImageView = [self.headerview addImageView:@"icon_default_circle"];
        [_portraitImageView setCornerRadius:19];
    }
    return _portraitImageView;
}

- (UILabel*) nameLabel{
    if (!_nameLabel) {
        _nameLabel = [self addLabel:[UIColor commonTextColor] textSize:15 weight:UIFontWeightMedium];
    }
    return _nameLabel;
}

- (UILabel*) deptLabel{
    if (!_deptLabel) {
        _deptLabel = [self addLabel:[UIColor commonDarkGrayTextColor] textSize:12];
    }
    return _deptLabel;
}

- (UIView*) videoView{
    if (!_videoView) {
        _videoView = [self.detview addView];
    }
    return _videoView;
}

- (UIView*) footerview{
    if (!_footerview) {
        _footerview = [self.detview addView];
        [_footerview showBoarder:UIViewBorderLineTypeTop];
    }
    return _footerview;
}

- (UILabel*) timeLabel{
    if (!_timeLabel) {
        _timeLabel = [self.footerview addLabel:[UIColor commonDarkGrayTextColor] textSize:13];
    }
    return _timeLabel;
}

- (UIImageView*) fellowImageView{
    if (!_fellowImageView) {
        _fellowImageView = [self.footerview addImageView:@"ic_fellowed"];
    }
    return _fellowImageView;
}

- (UILabel*) fellowNumberLabel{
    if (!_fellowNumberLabel) {
        _fellowNumberLabel = [self.footerview addLabel:[UIColor commonDarkGrayTextColor] textSize:13];
        _fellowNumberLabel.text = @"0";
    }
    return _fellowNumberLabel;
}

- (void) setEntryModel:(EntryModel *)model{
    if (!model || ![model isKindOfClass:[CircleInfoEntryModel class]]) {
        return;
    }
    
    CircleInfoEntryModel* circle = (CircleInfoEntryModel*) model;
    
    [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:circle.portraitUrl] placeholderImage:[UIImage imageNamed:@"icon_default_circle"]];
    self.nameLabel.text = circle.name;
    self.deptLabel.text = circle.introduction;
    self.fellowNumberLabel.text =  [NSString formatWithInteger:circle.followCount remain:1 unit:@"万"];
}

@end
