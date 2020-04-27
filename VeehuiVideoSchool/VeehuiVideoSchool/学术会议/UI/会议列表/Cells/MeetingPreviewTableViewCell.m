//
//  MeetingPreviewTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/27.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingPreviewTableViewCell.h"
#import "MeetingEntryModel.h"

@interface MeetingPreviewInfoCell : UIControl

@property (nonatomic, strong) UILabel* dateLabel;
@property (nonatomic, strong) UILabel* titleLabel;

@end

@interface MeetingPreviewTableViewCell ()

@property (nonatomic, strong) UIView* infoView;
@property (nonatomic, strong) UIView* previewView;
@property (nonatomic, strong) NSMutableArray<MeetingPreviewInfoCell*>* infoCells;
@property (nonatomic, strong) UIControl* moreView;
@property (nonatomic, strong) UILabel* moreLabel;
@property (nonatomic) BOOL showMoreView;
@end

@implementation MeetingPreviewInfoCell

- (id) initWithMeetingModel:(MeetingEntryModel*) meeting{
    self = [super init];
    if (self) {
        self.dateLabel.text = meeting.startTime;
        self.titleLabel.text = meeting.title;
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.width.mas_equalTo(@([self.dateLabel.text widthForFont:self.dateLabel.font]));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.greaterThanOrEqualTo(self.dateLabel.mas_right).offset(10);
        make.right.lessThanOrEqualTo(self).offset(-10);
    }];
}

- (UILabel*) dateLabel{
    if (!_dateLabel) {
        _dateLabel = [self addLabel:[UIColor commonGrayTextColor] textSize:13];
    }
    return _dateLabel;
}

- (UILabel*) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [self addLabel:[UIColor commonTextColor] textSize:14];
    }
    return _titleLabel;
}

@end

@implementation MeetingPreviewTableViewCell


- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor commonBackgroundColor];
    }
    return self;
}

- (id) initWithMeetingList:(MeetingListModel*) meetingList{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MeetingPreviewTableViewCell"];
    if (self) {
        self.contentView.backgroundColor = [UIColor commonBackgroundColor];
        [self setEntryModel:meetingList];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 12, 10, 12));
    }];
    
    [self.previewView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.infoView);
        make.top.equalTo(self.infoView).offset(7.5);
        if (!self.showMoreView) {
            make.bottom.equalTo(self.infoView).offset(-5);
        }
    }];
    
    __block MASViewAttribute* cellTop = self.infoView.mas_top;
    [self.infoCells enumerateObjectsUsingBlock:^(MeetingPreviewInfoCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.previewView);
            make.top.equalTo(cellTop);
            make.height.mas_equalTo(@(41.));
            if (cell == self.infoCells.lastObject) {
                make.bottom.equalTo(self.previewView);
            }
        }];
        
        cellTop = cell.mas_bottom;
    }];
    
    if (self.showMoreView) {
        [self.moreView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.infoView);
            make.height.mas_equalTo(@(41));
        }];
        
        [self.moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.moreView);
        }];
    }
}

#pragma mark - settingAndGetting
- (UIView*) infoView{
    if (!_infoView) {
        _infoView = [self.contentView addView];
        _infoView.backgroundColor = [UIColor whiteColor];
        [_infoView setCornerRadius:9];
    }
    return _infoView;
}

- (UIView*) previewView{
    if (!_previewView) {
        _previewView = [self.infoView addView];
    }
    return _previewView;
}

- (NSMutableArray<MeetingPreviewInfoCell*>*) infoCells{
    if (!_infoCells) {
        _infoCells = [NSMutableArray<MeetingPreviewInfoCell*> array];
    }
    return _infoCells;
}

- (UIControl*) moreView{
    if (!_moreView) {
        _moreView = (UIControl*)[self addView:[UIControl class]];
    }
    return _moreView;
}

- (UILabel*) moreLabel{
    if (!_moreLabel) {
        _moreLabel = [self.moreView addLabel:[UIColor mainThemeColor] textSize:13];
    }
    return _moreLabel;
}

- (void) setEntryModel:(EntryModel*) model{
    if (!model || ![model isKindOfClass:[MeetingListModel class]]) {
        return;
    }
    
    MeetingListModel* meetingList = (MeetingListModel*) model;
    [meetingList.content enumerateObjectsUsingBlock:^(EntryModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        MeetingEntryModel* meeting = (MeetingEntryModel*) model;
        MeetingPreviewInfoCell* cell = [[MeetingPreviewInfoCell alloc] initWithMeetingModel:meeting];
        [self.infoCells addObject:cell];
        [self.previewView addSubview:cell];
        if (idx >= 2) {
            *stop = YES;
            self.showMoreView = YES;
            return ;
        }
    }];
    
    if (self.showMoreView) {
        self.moreLabel.text = [NSString stringWithFormat:@"共%ld场会议直播预告  点击查看全部>>", meetingList.totalElements];
    }
}

@end
