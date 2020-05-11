//
//  HomeSubjectMeetingTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/1.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "HomeSubjectMeetingTableViewCell.h"
#import "MeetingEntryModel.h"

@interface HomeSubjectMeetingTableViewCell ()

@property (nonatomic, strong) UIView* detview;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* videoLabel;
@property (nonatomic, strong) UIView* watchedView;
@property (nonatomic, strong) UILabel* watchedNumber;

@property (nonatomic, strong) UIView* circleview;
@property (nonatomic, strong) UIImageView* circlePortraitImageView;
@property (nonatomic, strong) UILabel* circleNameLabel;

@end

@implementation HomeSubjectMeetingTableViewCell

- (id) initWithMeetingEntry:(MeetingEntryModel*) meeting{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeSubjectMeetingTableViewCell"];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        [self setEntryModel:meeting];
    }
    return self;
}

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
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(7, 8, 8, 8));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detview).offset(16.);
        make.left.equalTo(self.detview).offset(14.);
        make.right.lessThanOrEqualTo(self.detview).offset(-10.);
    }];
    
    [self.videoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(82, 18));
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8.);
    }];
    
    [self.watchedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.videoLabel.mas_right).offset(8.);
        make.centerY.equalTo(self.videoLabel);
        make.height.mas_equalTo(@18.);
    }];
    
    [self.watchedNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.watchedView);
        make.width.equalTo(self.watchedView).offset(-16);
    }];
    
    
    [self.circleview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(27.);
        make.top.equalTo(self.videoLabel.mas_bottom).offset(14.);
        make.bottom.equalTo(self.detview).offset(-17);
        make.left.equalTo(self.videoLabel);
    }];
    
    [self.circlePortraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(22, 22));
        make.left.equalTo(self.circleview);
        make.centerY.equalTo(self.circleview);
    }];
    
    [self.circleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.circleview);
        make.left.equalTo(self.circlePortraitImageView.mas_right).offset(7);
        make.right.equalTo(self.circleview).offset(-5);
    }];
}

#pragma mark - settingAndGetting
- (UIView*) detview{
    if (!_detview) {
        _detview = [self.contentView addView];
        _detview.backgroundColor = [UIColor whiteColor];
        [_detview.layer setCornerRadius:8];
        
        // 阴影颜色
        _detview.layer.shadowColor = [UIColor commonBoarderColor].CGColor;
        _detview.layer.shadowOffset = CGSizeMake(0,0);
        // 阴影透明度
        _detview.layer.shadowOpacity = 0.5;
        // 阴影半径
        _detview.layer.shadowRadius = 1;
    }
    return _detview;
}

- (UILabel*) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [self.detview addLabel:[UIColor commonTextColor] textSize:16 weight:UIFontWeightMedium];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel*) videoLabel{
    if (!_videoLabel) {
        _videoLabel = [self.detview addLabel:[UIColor colorWithHexString:@"#4A6DFF"] textSize:11];
        _videoLabel.textAlignment = NSTextAlignmentCenter;
        [_videoLabel setBackgroundColor:[UIColor colorWithHexString:@"#DEEDFF"]];
        [_videoLabel setCornerRadius:9];
        _videoLabel.text = @"学术会议视频";
    }
    return _videoLabel;
}

- (UIView*) watchedView{
    if (!_watchedView) {
        _watchedView = [self.detview addView];
        _watchedView.backgroundColor = [UIColor commonBackgroundColor];
        [_watchedView setCornerRadius:9];
    }
    return _watchedView;
}

- (UILabel*) watchedNumber{
    if (!_watchedNumber) {
        _watchedNumber = [self.watchedView addLabel:[UIColor commonLightGrayTextColor] textSize:11];
    }
    return _watchedNumber;
}

- (UIView*) circleview{
    if (!_circleview) {
        _circleview = [self.detview addView];
        [_circleview setCornerRadius:11];
        _circleview.backgroundColor = [UIColor commonBackgroundColor];
    }
    return _circleview;
}

- (UIImageView*) circlePortraitImageView{
    if (!_circlePortraitImageView) {
        _circlePortraitImageView = [self.circleview addImageView:@"icon_default_circle"];
    }
    return _circlePortraitImageView;
}

- (UILabel*) circleNameLabel{
    if (!_circleNameLabel) {
        _circleNameLabel = [self.circleview addLabel:[UIColor commonDarkGrayTextColor] textSize:12];
    }
    return _circleNameLabel;
}

- (void) setEntryModel:(EntryModel *)model{
    if (!model || ![model isKindOfClass:[MeetingEntryModel class]]) {
        return;
    }
    MeetingEntryModel* meetingModel = (MeetingEntryModel*) model;
    [self.titleLabel setText:meetingModel.title lineSpacing:3] ;
    self.watchedNumber.text = [NSString stringWithFormat:@"%@人已观看", [NSString formatWithInteger:meetingModel.watchingNumber remain:2 unit:@"万"]];
    
    [self.contentView setNeedsUpdateConstraints];
    [self.circlePortraitImageView sd_setImageWithURL:[NSURL URLWithString:meetingModel.circlePortraitUrl] placeholderImage:[UIImage imageNamed:@"icon_default_circle"]];
    self.circleNameLabel.text = meetingModel.circleName;
}
@end
