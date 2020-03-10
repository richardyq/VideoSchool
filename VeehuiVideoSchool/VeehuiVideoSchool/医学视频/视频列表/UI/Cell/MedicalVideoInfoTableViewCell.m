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

@end

@implementation MedicalVideoInfoTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor commonBackgroundColor];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.groupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 12.5, 5, 12.5));
    }];
    
    [self.pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(93, 93));
        make.left.equalTo(self.groupView).offset(10);
        make.top.equalTo(self.groupView).offset(15);
        make.bottom.equalTo(self.groupView).offset(-21);
    }];
    
    [self.videoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pictureImageView.mas_right).offset(18);
        make.top.equalTo(self.pictureImageView);
        make.right.lessThanOrEqualTo(self.groupView).offset(-7);
    }];
    
    [self.composerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.videoTitleLabel);
        make.top.equalTo(self.pictureImageView).offset(51);
        make.right.lessThanOrEqualTo(self.groupView).offset(-7);
    }];
    
    [self.watchedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.pictureImageView);
        make.height.mas_equalTo(@21);
    }];
    
    [self.watchIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.watchedView);
        make.left.equalTo(self.watchedView).offset(8);
    }];
    
    [self.watchedNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.watchedView);
        make.left.equalTo(self.watchIconImageView.mas_right).offset(5);
    }];
}

#pragma mark - settingAndGetting
- (UIView*) groupView{
    if (!_groupView) {
        _groupView = [self.contentView addView];
        [_groupView setCornerRadius:4];
        _groupView.backgroundColor = [UIColor whiteColor];
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
        _videoTitleLabel = [self.groupView addLabel:[UIColor commonTextColor] textSize:15];
        _videoTitleLabel.numberOfLines = 2;
        _videoTitleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
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

- (void) setVideoGroupInfo:(MedicalVideoGroupInfoEntryModel*) entryModel{
    self.videoTitleLabel.text = entryModel.title;
    self.composerLabel.text = entryModel.medicalVideoComposer;
    
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:entryModel.pictureUrl] placeholderImage:[UIImage imageNamed:@"img_default_video_in_table"]];
    
    [self.pictureImageView removeWatermark];
    if (entryModel.isPrice || entryModel.price > 0) {
        //精品课程
        [self.pictureImageView addWatermark:@"ic_video_course" positon:WatermarPosition_TL];
    }
    NSString* watchedNumberString = [NSString formatWithInteger:entryModel.watchingNumber remain:2 unit:@"万"];
    self.watchedNumberLabel.text = watchedNumberString;
}

- (void) setEntryModel:(EntryModel *)model{
    if ([model isKindOfClass:[MedicalVideoGroupInfoEntryModel class]] || [model.class isSubclassOfClass:[MedicalVideoGroupInfoEntryModel class]]) {
        [self setVideoGroupInfo:(MedicalVideoGroupInfoEntryModel*)model];
    }
}

@end
