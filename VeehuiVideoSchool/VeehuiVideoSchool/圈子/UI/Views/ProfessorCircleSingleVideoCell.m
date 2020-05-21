//
//  ProfessorCircleSingleVideoCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/15.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "ProfessorCircleSingleVideoCell.h"
#import "MedicalVideoGroupInfoEntryModel.h"
#import "VideoInfoProductTypeControl.h"

@interface ProfessorCircleSingleVideoCell ()

@property (nonatomic, strong) UIImageView* videoImageView;
@property (nonatomic, strong) UIView* watchCoverView;
@property (nonatomic, strong) UIImageView* playIconImageView;
@property (nonatomic, strong) UILabel* watchedNumberLabel;

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UIView* categoryView;
@property (nonatomic, strong) NSMutableArray<VHLabelControl*>* categoryCells;
@end

@implementation ProfessorCircleSingleVideoCell

- (id) initWithVideoGroup:(MedicalVideoGroupInfoEntryModel*) videoGroup{
    self = [super init];
    if (self) {
        [self setupVideoGroup:videoGroup];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(93, 93));
        make.bottom.equalTo(self).offset(-26.);
        make.top.equalTo(self);
        make.left.equalTo(self);
    }];
    
    [self.watchCoverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.videoImageView);
        make.height.mas_equalTo(@20.);
    }];
    
    [self.playIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.watchCoverView);
        make.left.equalTo(self.watchCoverView).offset(8);
    }];
    
    [self.watchedNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.watchCoverView);
        make.left.equalTo(self.playIconImageView.mas_right).offset(2.5);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.videoImageView);
        make.left.equalTo(self.videoImageView.mas_right).offset(12);
        make.right.lessThanOrEqualTo(self).offset(-5);
        //make.bottom.equalTo(self).offset(-5.);
    }];
    
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel).offset(-5);
        //make.top.equalTo(self.videoImageView.mas_bottom).offset(-15);
        make.right.lessThanOrEqualTo(self).offset(-13);
        make.bottom.equalTo(self.videoImageView);
        make.height.mas_greaterThanOrEqualTo(@20);
    }];
}

#pragma mark - settingAndGetting
- (UIImageView*) videoImageView{
    if (!_videoImageView) {
        _videoImageView = [self addImageView:@"ic_weiyihui_lording"];
        [_videoImageView setCornerRadius:5];
    }
    return _videoImageView;
}

- (UIView*) watchCoverView{
    if (!_watchCoverView) {
        _watchCoverView = [self.videoImageView addView];
        _watchCoverView.backgroundColor = [UIColor colorWithHexString:@"00000054"];
    }
    return _watchCoverView;
}

- (UIImageView*) playIconImageView{
    if (!_playIconImageView) {
        _playIconImageView = [self.watchCoverView addImageView:@"icon_nrfllb_bfrc"];
    }
    return _playIconImageView;
}

- (UILabel*) watchedNumberLabel{
    if (!_watchedNumberLabel) {
        _watchedNumberLabel = [self.watchCoverView addLabel:[UIColor whiteColor] textSize:11];
    }
    return _watchedNumberLabel;
}

- (UILabel*) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [self addLabel:[UIColor commonTextColor] textSize:15 weight:UIFontWeightMedium];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UIView*) categoryView{
    if (!_categoryView) {
        _categoryView = [self addView];
    }
    return _categoryView;
}

- (NSMutableArray<VHLabelControl*>*) categoryCells{
    if (!_categoryCells) {
        _categoryCells = [NSMutableArray<VHLabelControl*> array];
    }
    return _categoryCells;
}

- (void) setupVideoGroup:(MedicalVideoGroupInfoEntryModel*) videoGroup{
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:videoGroup.pictureUrl] placeholderImage:[UIImage imageNamed:@"img_default_video_in_table"]];
    
    self.watchedNumberLabel.text = [NSString formatWithInteger:videoGroup.watchingNumber remain:1 unit:@"W"];
    self.titleLabel.text = videoGroup.title;
    
    [self.categoryView removeAllSubviews];
    [self.categoryCells removeAllObjects];
    
    [videoGroup.productTypeCodeNames enumerateObjectsUsingBlock:^(NSString * _Nonnull cate, NSUInteger idx, BOOL * _Nonnull stop) {
        VHLabelControl* control = [[VideoInfoProductTypeControl alloc] initWithText:cate font:[UIFont systemFontOfSize:11] textColor:[UIColor mainThemeColor]];
        //[control setCornerRadius:2 color:[UIColor mainThemeColor] boarderwidth:0.5];
        [control setCornerRadius:9];
        control.backgroundColor = [UIColor colorWithHexString:@"#FFE9D9"];
        [self.categoryView addSubview:control];
        [self.categoryCells addObject:control];
    }];
    
    [self layoutCategoryControls];
}

- (void) layoutCategoryControls{
    __block CGFloat maxWidth = kScreenWidth - 124 - 25 - 15;
    __block CGFloat lastWidth = 0;
    __block MASViewAttribute* cellLeft = self.categoryView.mas_left;
    __block MASViewAttribute* cellTop = self.categoryView.mas_top;
    
    [self.categoryCells enumerateObjectsUsingBlock:^(VHLabelControl * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat cellWidth = [cell.textLabel.text widthForFont:cell.textLabel.font] + 16;
        if (cellWidth > maxWidth - 15) {
            cellWidth = maxWidth - 15;
        }
        if (lastWidth + cellWidth + 5 >= maxWidth) {
            if (idx > 0) {
                VHLabelControl* precell = self.categoryCells[idx - 1];
                cellTop = precell.mas_bottom;
            }
            cellLeft = self.categoryView.mas_left;
            lastWidth = 0;
        }
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cellLeft).offset(5);
            make.top.equalTo(cellTop).offset(4);
            //make.size.mas_equalTo(CGSizeMake(cellWidth + 5, 16));
            make.height.equalTo(@18.);
            if (cell == self.categoryCells.lastObject) {
                make.bottom.equalTo(self.categoryView);
            }
        }];
        
        cellLeft = cell.mas_right;
        lastWidth += (cellWidth + 5);
    }];
}

@end
