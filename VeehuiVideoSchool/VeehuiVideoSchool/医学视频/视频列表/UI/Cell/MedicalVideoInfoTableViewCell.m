//
//  MedicalVideoInfoTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalVideoInfoTableViewCell.h"

@interface MedicalVideoInfoTableViewCell ()

@property (nonatomic, strong) UIView* groupView;

@property (nonatomic, strong) UIImageView* pictureImageView;
@property (nonatomic, strong) UILabel* videoTitleLabel;
@property (nonatomic, strong) UILabel* composerLabel;

@property (nonatomic, strong) UIView* watchedView;
@property (nonatomic, strong) UIImageView* watchIconImageView;
@property (nonatomic, strong) UILabel* watchedNumberLabel;

@property (nonatomic, strong) UIView* categoryView;
@property (nonatomic, strong) NSMutableArray<VHLabelControl*>* categoryCells;

@end

@implementation MedicalVideoInfoTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.groupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 8, 5, 8));
    }];
    
    [self.pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.left.equalTo(self.groupView).offset(10);
        make.top.equalTo(self.groupView).offset(13);
        make.bottom.equalTo(self.groupView).offset(-16);
    }];
    
    [self.videoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pictureImageView.mas_right).offset(14);
        make.top.equalTo(self.pictureImageView);
        make.right.lessThanOrEqualTo(self.groupView).offset(-7);
    }];
    
    [self.composerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.videoTitleLabel);
        make.top.equalTo(self.videoTitleLabel.mas_bottom).offset(4);
        make.right.lessThanOrEqualTo(self.groupView).offset(-7);
    }];
    
    [self.watchedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.pictureImageView);
        make.height.mas_equalTo(@16);
    }];
    
    [self.watchIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.watchedView);
        make.left.equalTo(self.watchedView).offset(8);
    }];
    
    [self.watchedNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.watchedView);
        make.left.equalTo(self.watchIconImageView.mas_right).offset(3);
    }];
    
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.videoTitleLabel).offset(-5);
        //make.top.equalTo(self.videoImageView.mas_bottom).offset(-15);
        make.right.lessThanOrEqualTo(self).offset(-13);
        make.bottom.equalTo(self.pictureImageView);
        make.height.mas_greaterThanOrEqualTo(@20);
    }];
}

#pragma mark - settingAndGetting
- (UIView*) groupView{
    if (!_groupView) {
        _groupView = [self.contentView addView];
        [_groupView.layer setCornerRadius:8];
        _groupView.backgroundColor = [UIColor whiteColor];
        
        // 阴影颜色
        _groupView.layer.shadowColor = [UIColor commonBoarderColor].CGColor;
        _groupView.layer.shadowOffset = CGSizeMake(0,0);
        // 阴影透明度
        _groupView.layer.shadowOpacity = 0.5;
        // 阴影半径
        _groupView.layer.shadowRadius = 1;
    }
    return _groupView;
}

- (UIImageView*) pictureImageView{
    if (!_pictureImageView) {
        _pictureImageView = [self.groupView addImageView:@"img_default_video_in_table"];
        [_pictureImageView setCornerRadius:4];
    }
    return _pictureImageView;
}

- (UILabel*) videoTitleLabel{
    if (!_videoTitleLabel) {
        _videoTitleLabel = [self.groupView addLabel:[UIColor commonTextColor] textSize:16 weight:UIFontWeightMedium];
        _videoTitleLabel.numberOfLines = 2;
    }
    return _videoTitleLabel;
}

- (UILabel*) composerLabel{
    if (!_composerLabel) {
        _composerLabel = [self.groupView addLabel:[UIColor commonGrayTextColor] textSize:11];
    }
    return _composerLabel;
}

- (UIView*) watchedView{
    if (!_watchedView) {
        _watchedView = [self.pictureImageView addView];
        _watchedView.backgroundColor = [UIColor colorWithHexString:@"00000042"];
    }
    return _watchedView;
}

- (UIImageView*) watchIconImageView{
    if (!_watchIconImageView) {
        _watchIconImageView = [self.watchedView addImageView:@"ic_video_watched"];
    }
    return _watchIconImageView;
}

- (UILabel*)watchedNumberLabel{
    if (!_watchedNumberLabel) {
        _watchedNumberLabel = [self.watchedView addLabel:[UIColor whiteColor] textSize:11];
    }
    return _watchedNumberLabel;
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

- (void) setVideoGroupInfo:(MedicalVideoGroupInfoEntryModel*) entryModel{
    //self.videoTitleLabel.text = entryModel.title;
    [self.videoTitleLabel setText:entryModel.title lineSpacing:3];
    self.composerLabel.text = entryModel.medicalVideoComposer;
    
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:entryModel.pictureUrl] placeholderImage:[UIImage imageNamed:@"img_default_video_in_table"]];
    
    [self.pictureImageView removeWatermark];
    if (entryModel.isPrice || entryModel.price > 0) {
        //精品课程
        [self.pictureImageView addWatermark:@"ic_video_course" positon:WatermarPosition_TL];
    }
    NSString* watchedNumberString = [NSString formatWithInteger:entryModel.watchingNumber remain:2 unit:@"W"];
    self.watchedNumberLabel.text = watchedNumberString;
    
    if ([self showProductTypes]) {
        [self.categoryView removeAllSubviews];
        [self.categoryCells removeAllObjects];
        
        [entryModel.productTypeInfo enumerateObjectsUsingBlock:^(NSString * _Nonnull cate, NSUInteger idx, BOOL * _Nonnull stop) {
            VHLabelControl* control = [[VHLabelControl alloc] initWithText:cate font:[UIFont systemFontOfSize:11] textColor:[UIColor mainThemeColor]];
            [control setCornerRadius:2 color:[UIColor mainThemeColor] boarderwidth:0.5];
            [self.categoryView addSubview:control];
            [self.categoryCells addObject:control];
        }];
        
        [self layoutCategoryControls];
    }
}

- (BOOL) showProductTypes{
    return YES;
}

- (void) setEntryModel:(EntryModel *)model{
    if ([model isKindOfClass:[MedicalVideoGroupInfoEntryModel class]] || [model.class isSubclassOfClass:[MedicalVideoGroupInfoEntryModel class]]) {
        [self setVideoGroupInfo:(MedicalVideoGroupInfoEntryModel*)model];
    }
}

- (void) layoutCategoryControls{
    __block CGFloat maxWidth = kScreenWidth - 124 - 25 - 15;
    __block CGFloat lastWidth = 0;
    __block MASViewAttribute* cellLeft = self.categoryView.mas_left;
    __block MASViewAttribute* cellTop = self.categoryView.mas_top;
    
    [self.categoryCells enumerateObjectsUsingBlock:^(VHLabelControl * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat cellWidth = [cell.textLabel.text widthForFont:cell.textLabel.font] + 3;
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
            make.size.mas_equalTo(CGSizeMake(cellWidth + 5, 16));
            if (cell == self.categoryCells.lastObject) {
                make.bottom.equalTo(self.categoryView);
            }
        }];
        
        cellLeft = cell.mas_right;
        lastWidth += (cellWidth + 5);
    }];
}

@end
