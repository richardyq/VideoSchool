//
//  MeetingConferenceTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/30.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingConferenceTableViewCell.h"
#import "MeetingDetailModel.h"

@interface MeetingConferencePlayControl : UIControl

@property (nonatomic, strong) UILabel* playLabel;

- (id) initWithIndex:(NSInteger) index;

@end

@implementation MeetingConferencePlayControl

- (id) initWithIndex:(NSInteger) index{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor commonBackgroundColor];
        [self setCornerRadius:4];
        self.playLabel.text = [NSString stringWithFormat:@"%ld", index];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    [self.playLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

#pragma mark - setttingAndGetting
- (UILabel*) playLabel{
    if (!_playLabel) {
        _playLabel = [self addLabel:[UIColor commonTextColor] textSize:14];
    }
    return _playLabel;
}

@end

@interface MeetingConferenceTableViewCell ()

@property (nonatomic, strong) UILabel* titleLabel;

@property (nonatomic, strong) UIView* conferenceView;
@property (nonatomic, strong) NSMutableArray<MeetingConferencePlayControl*>* playControls;

@end

@implementation MeetingConferenceTableViewCell

- (id) initWithConferense:(MeetingConferenceModel*) conference{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MeetingConferenceTableViewCell cellReuseIdentifier]];
    if (self) {
        self.titleLabel.text = conference.title;
        
        [self buildPlayControls:conference];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(12);
        make.right.lessThanOrEqualTo(self.contentView).offset(-15);
    }];
    
    [self.conferenceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(7);
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-11);
    }];
    
    __block MASViewAttribute* controlLeft = self.conferenceView.mas_left;
    __block MASViewAttribute* controlTop = self.conferenceView.mas_top;
    [self.playControls enumerateObjectsUsingBlock:^(MeetingConferencePlayControl * _Nonnull control, NSUInteger idx, BOOL * _Nonnull stop) {
        [control mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(42, 42));
            make.left.equalTo(controlLeft).offset(8);
            make.top.equalTo(controlTop).offset(8);
            if (control == self.playControls.lastObject) {
                make.bottom.equalTo(self.conferenceView).offset(-5);
            }
        }];
        controlLeft = control.mas_right;
        if ((idx % 6) == 5) {
            controlLeft = self.conferenceView.mas_left;
            controlTop = control.mas_bottom;
        }
    }];
}

#pragma mark - settingAndGetting
- (UILabel*) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [self.contentView addLabel:[UIColor commonTextColor] textSize:17 weight:UIFontWeightMedium];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UIView*) conferenceView{
    if (!_conferenceView) {
        _conferenceView = [self.contentView addView];
    }
    return _conferenceView;
}

- (NSMutableArray<MeetingConferencePlayControl*>*) playControls{
    if (!_playControls) {
        _playControls = [NSMutableArray<MeetingConferencePlayControl*> array];
    }
    return _playControls;
}

- (void) buildPlayControls:(MeetingConferenceModel*) conference{
    
    [conference.videoList enumerateObjectsUsingBlock:^(MeetingConferenceVideoModel * _Nonnull video, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.playControls addObject:[[MeetingConferencePlayControl alloc] initWithIndex:idx + 1]];
    }];
    
    [self.playControls enumerateObjectsUsingBlock:^(MeetingConferencePlayControl * _Nonnull control, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.conferenceView addSubview:control];
    }];
}
@end
