//
//  HomeCircleAnnouncementView.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/11.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "HomeCircleAnnouncementView.h"
#import "JoinedCircleEntryModel.h"

@interface HomeCircleAnnouncementCell : UIControl

@property (nonatomic, strong) UILabel* titleLabel;

@end

@implementation HomeCircleAnnouncementCell

- (id) initWithAnnouncement:(CircleAnnouncementEntryModel*) announcement{
    self = [super init];
    if (self) {
        self.titleLabel.text = announcement.content;
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark - settingAndGetting
- (UILabel*) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [self addLabel:[UIColor commonDarkGrayTextColor] textSize:13];
    }
    return _titleLabel;
}

@end

@interface HomeCircleAnnouncementView ()

@property (nonatomic, strong) UIView* detView;
@property (nonatomic, strong) UIImageView* iconImageView;
@property (nonatomic, strong) UIView* lineView;
@property (nonatomic, strong) UIImageView* arrowImageView;

@property (nonatomic, strong) HomeCircleAnnouncementCell* announcementCell;

@property (nonatomic) NSInteger currentAnnounceIndex;

@end

@implementation HomeCircleAnnouncementView

- (id) init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    [self.detView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 9, 0, 9));
        make.height.mas_equalTo(@34);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.detView);
        make.left.equalTo(self.detView).offset(9.);
        make.size.mas_equalTo(CGSizeMake(30, 14));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1, 13));
        make.centerY.equalTo(self);
        make.left.equalTo(self.iconImageView.mas_right).offset(4);
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.detView);
        make.size.mas_equalTo(CGSizeMake(8, 10));
        make.right.equalTo(self.detView).offset(-12);
    }];
    
    /*
    if (self.announcementCell) {
        [self.announcementCell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self.lineView.mas_right).offset(5);
            make.right.equalTo(self.arrowImageView.mas_left).offset(-4);
        }];
    }
     */
}

#pragma mark - settingAndGetting
- (UIView*) detView{
    if (!_detView) {
        _detView = [self addView];
        _detView.backgroundColor = [UIColor colorWithHexString:@"#FFF3EB"];
        [_detView setCornerRadius:17.];
        _detView.layer.masksToBounds = YES;
    }
    return _detView;
}

- (UIImageView*) iconImageView{
    if (!_iconImageView) {
        _iconImageView = [self.detView addImageView:@"ic_home_announce"];
    }
    return _iconImageView;
}

- (UIView*) lineView{
    if (!_lineView) {
        _lineView = [self addView];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#FAD5BC"];
    }
    return _lineView;
}

- (UIImageView*) arrowImageView{
    if (!_arrowImageView) {
        _arrowImageView = [self.detView addImageView:@"ic_det_right_arrow"];
    }
    return _arrowImageView;
}

- (void) setupAnnouncements:(JoinedCircleEntryModel*) circleModel{
    if (!_announcementCell) {
        _announcementCell = [[HomeCircleAnnouncementCell alloc] initWithAnnouncement:circleModel.circleAnnouncements.firstObject];
        [self.detView addSubview:_announcementCell];
        [_announcementCell setFrame:CGRectMake(49, 0, kScreenWidth - 37 - 59 - 14 , 34)];
        [_announcementCell setNeedsUpdateConstraints];
    }
    
    [self setNeedsUpdateConstraints];
    
    if (circleModel.circleAnnouncements.count > 1) {
        _currentAnnounceIndex = 0;
        [self performSelector:@selector(changeAnnouncementCell:) withObject:circleModel afterDelay:3];
    }
}

- (void) changeAnnouncementCell:(JoinedCircleEntryModel*) circle{
    NSInteger index = self.currentAnnounceIndex + 1;
    CGRect frame = CGRectMake(self.announcementCell.left, self.announcementCell.bottom, self.announcementCell.width, self.announcementCell.height);
    
    if (index >= circle.circleAnnouncements.count) {
        index = 0;
    }
    self.currentAnnounceIndex = index;
    
    HomeCircleAnnouncementCell* announcementCell = [[HomeCircleAnnouncementCell alloc] initWithAnnouncement:circle.circleAnnouncements[index]];
    announcementCell.frame = frame;
    [self.detView addSubview:announcementCell];
    
    [UIView animateWithDuration:1.2 animations:^{
        self.announcementCell.frame = CGRectMake(self.announcementCell.left, -announcementCell.height, announcementCell.width, announcementCell.height);
        announcementCell.frame = CGRectMake(self.announcementCell.left, 0, announcementCell.width, announcementCell.height);
        [announcementCell setNeedsUpdateConstraints];
    } completion:^(BOOL finished) {
        self.announcementCell = announcementCell;
    }];
    
    [self performSelector:@selector(changeAnnouncementCell:) withObject:circle afterDelay:3];
}
@end
