//
//  HomeJoinedCircleTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/30.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "HomeJoinedCircleTableViewCell.h"
#import "HomeCircleUnTreadedView.h"
#import "HomeCircleAnnouncementView.h"

@interface HomeJoinedCircleVideoCell : UIControl

@property (nonatomic, strong) UIImageView* iconImageView;
@property (nonatomic, strong) UILabel* nameLabel;
@property (nonatomic, strong) UILabel* dateLabel;

- (id) initWithVideoGroup:(JoinedCircleVideoGroupModel*) video;
@end

@implementation HomeJoinedCircleVideoCell

- (id) initWithVideoGroup:(JoinedCircleVideoGroupModel*) video{
    self = [super init];
    if (self) {
        self.nameLabel.text = video.title;
        NSDate* startDate = [NSDate dateWithString:video.createTime format:@"yyyy-MM-dd HH:mm:ss"];
        
        self.dateLabel.text = [startDate stringWithFormat:@"yyyy.MM.dd"];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(16, 16));
        make.left.equalTo(self).offset(13);
        make.centerY.equalTo(self);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.iconImageView.mas_right).offset(5);
        make.right.lessThanOrEqualTo(self.dateLabel.mas_left).offset(-5);
    }];
}


#pragma mark - settingAndGetting
- (UIImageView*) iconImageView{
    if (!_iconImageView) {
        _iconImageView = [self addImageView:@"ic_home_circle_video"];
    }
    return _iconImageView;
}

- (UILabel*) nameLabel{
    if (!_nameLabel) {
        _nameLabel = [self addLabel:[UIColor commonTextColor] textSize:14];
        _nameLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    }
    return _nameLabel;
}

- (UILabel*) dateLabel{
    if (!_dateLabel) {
        _dateLabel = [self addLabel:[UIColor commonDarkGrayTextColor] textSize:12];
    }
    return _dateLabel;
}

@end

@interface HomeJoinedCircleTableViewCell ()

@property (nonatomic, strong) UIView* detView;

@property (nonatomic, strong) UIView* titleview;
@property (nonatomic, strong) UIImageView* portraitImageView;
@property (nonatomic, strong) UILabel* nameLabel;

@property (nonatomic, strong) HomeCircleAnnouncementView* announcementView;

@property (nonatomic, strong) HomeCircleUnTreadedView* untreadedView;
@property (nonatomic, strong) NSMutableArray<HomeJoinedCircleVideoCell*>* videoControls;

@property (nonatomic, strong) UIView* moreView;
@property (nonatomic, strong) UILabel* moreLabel;

@property (nonatomic) NSInteger shownCircleId;
@end

@implementation HomeJoinedCircleTableViewCell

- (id) initWithJoinedCircle:(JoinedCircleEntryModel*) circle{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeJoinedCircleTableViewCell"];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        [self setEntryModel:circle];
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
    
    [self.detView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(7, 8, 8, 8));
    }];
    
    [self.titleview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detView);
        make.centerX.equalTo(self.detView);
        make.width.equalTo(self.detView);
        make.height.mas_equalTo(@49.);
    }];
    
    [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(22, 22));
        make.centerY.equalTo(self.titleview);
        make.left.equalTo(self.titleview).offset(14.);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.portraitImageView.mas_right).offset(10.);
        make.right.lessThanOrEqualTo(self.titleview).offset(-3);
        make.centerY.equalTo(self.titleview);
    }];
    
    __block MASViewAttribute* lastBottom = self.titleview.mas_bottom;
    
    if (!self.announcementView.hidden) {
        [self.announcementView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.detView);
            make.top.equalTo(lastBottom).offset(8);
        }];
        lastBottom = self.announcementView.mas_bottom;
    }
    
    if (!self.untreadedView.hidden) {
        [self.untreadedView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.titleview);
            make.top.equalTo(lastBottom).offset(8);
            make.height.mas_equalTo(@45.);
        }];
        lastBottom = self.untreadedView.mas_bottom;
    }
    
    if (self.videoControls.count > 0) {
        
        [self.videoControls enumerateObjectsUsingBlock:^(HomeJoinedCircleVideoCell * _Nonnull control, NSUInteger idx, BOOL * _Nonnull stop) {
            [control mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.titleview);
                make.top.equalTo(lastBottom);
                make.height.mas_equalTo(@40.);
            }];
           lastBottom = control.mas_bottom;
        }];
         
    }
    
    [self.moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.moreView).insets(UIEdgeInsetsMake(16, 16, 16, 16)) ;
        make.height.mas_equalTo(@45.);
    }];
    
    [self.moreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.detView);
        make.top.equalTo(lastBottom);
    }];
}

#pragma mark - settingAndGetting
- (UIView*) detView{
    if (!_detView) {
        _detView = [self.contentView addView];
        _detView.backgroundColor = [UIColor whiteColor];
        [_detView.layer setCornerRadius:8];
        
        // 阴影颜色
        _detView.layer.shadowColor = [UIColor commonBoarderColor].CGColor;
        _detView.layer.shadowOffset = CGSizeMake(0,0);
        // 阴影透明度
        _detView.layer.shadowOpacity = 0.5;
        // 阴影半径
        _detView.layer.shadowRadius = 1;
    }
    return _detView;
}

- (UIView*) titleview{
    if (!_titleview) {
        _titleview = [self.detView addView];
        [_titleview showBoarder:UIViewBorderLineTypeBottom];
        [_titleview showBoarder:UIViewBorderLineTypeBottom];
    }
    return _titleview;
}

- (UIImageView*) portraitImageView{
    if (!_portraitImageView) {
        _portraitImageView = [self.titleview addImageView:@"icon_default_circle"];
        [_portraitImageView setCornerRadius:20];
    }
    return _portraitImageView;
}

- (UILabel*) nameLabel{
    if (!_nameLabel) {
        _nameLabel = [self.titleview addLabel:[UIColor commonTextColor] textSize:17 weight:UIFontWeightMedium];
    }
    return _nameLabel;
}

- (HomeCircleAnnouncementView*) announcementView{
    if (!_announcementView) {
        _announcementView = (HomeCircleAnnouncementView*)[self.detView addView:[HomeCircleAnnouncementView class]];
        _announcementView.hidden = YES;
    }
    return _announcementView;
}

- (HomeCircleUnTreadedView*) untreadedView{
    if (!_untreadedView) {
        _untreadedView = (HomeCircleUnTreadedView*)[self.detView addView:[HomeCircleUnTreadedView class]];
    }
    return _untreadedView;
}

- (NSMutableArray<HomeJoinedCircleVideoCell*>*) videoControls{
    if (!_videoControls) {
        _videoControls = [NSMutableArray<HomeJoinedCircleVideoCell*> array];
    }
    return _videoControls;
}

- (UIView*) moreView{
    if (!_moreView) {
        _moreView = [self.detView addView];
    }
    return _moreView;
}

- (UILabel*) moreLabel{
    if (!_moreLabel) {
        _moreLabel = [self.moreView addLabel:[UIColor mainThemeColor] textSize:15];
        _moreLabel.text = @"进入我的机构参加内部培训 >";
        _moreLabel.backgroundColor = [UIColor commonBackgroundColor];
        [_moreLabel setCornerRadius:4];
        _moreLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _moreLabel;
}

- (void) setEntryModel:(EntryModel *)model{
    if (!model || ![model isKindOfClass:[JoinedCircleEntryModel class]]) {
        return;
    }
    
    JoinedCircleEntryModel* circleModel = (JoinedCircleEntryModel*) model;
    if (circleModel.circleId == self.shownCircleId) {
        return;
    }
    
    self.shownCircleId = circleModel.circleId;
    
    self.nameLabel.text = circleModel.circleName;
    [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:circleModel.portraitUrl] placeholderImage:[UIImage imageNamed:@"icon_default_circle"]];
    
    if (circleModel.circleAnnouncements &&
        circleModel.circleAnnouncements.count > 0) {
        self.announcementView.hidden = NO;
        [self.announcementView setupAnnouncements:circleModel];
    }
    
    self.untreadedView.hidden = !circleModel.haveWaitingProcess;
    if (circleModel.haveWaitingProcess) {
        [self.untreadedView setupUntreadedCells:circleModel];
    }
    
    [self.videoControls enumerateObjectsUsingBlock:^(HomeJoinedCircleVideoCell * _Nonnull control, NSUInteger idx, BOOL * _Nonnull stop) {
        [control removeFromSuperview];
    }];
    [self.videoControls removeAllObjects];
    
    if (circleModel.circleMvgInfos && circleModel.circleMvgInfos.count > 0) {
        [circleModel.circleMvgInfos enumerateObjectsUsingBlock:^(JoinedCircleVideoGroupModel * _Nonnull video, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx >= 3) {
                *stop = YES;
                return ;
            }
            
            HomeJoinedCircleVideoCell* cell = [[HomeJoinedCircleVideoCell alloc] initWithVideoGroup:video];
            [self.detView addSubview:cell];
            [self.videoControls addObject:cell];
        }];
    }
    
    [self.contentView setNeedsUpdateConstraints];
}
@end
