
//
//  MeetingPreviewDetailImageTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/8.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingPreviewDetailImageTableViewCell.h"
#import "MeetingDetailModel.h"

@interface MeetingPreviewDetailImageTableViewCell ()

@property (nonatomic, strong) UIImageView* pictureImageView;

@end

@implementation MeetingPreviewDetailImageTableViewCell

- (void) updateConstraints{
    [super updateConstraints];
    [self.pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
        CGFloat width = kScreenWidth;
        if ([UIDevice currentDevice].isPad) {
            width = kScreenWidth * 0.7;
        }
       
        CGFloat height = width * (135./354);
        make.height.mas_equalTo(@(height));
    }];
}


#pragma mark - settingAndGetting
- (UIImageView*) pictureImageView{
    if (!_pictureImageView) {
        _pictureImageView = [self.contentView addImageView:@"img_meeting_list_default"];
    }
    return _pictureImageView;
}

- (void) setEntryModel:(EntryModel *)model{
    if (!model || ![model isKindOfClass:[MeetingEntryModel class]]) {
        return;
    }
    MeetingEntryModel* meeting = (MeetingEntryModel*) model;
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:meeting.pictureUrl] placeholderImage:[UIImage imageNamed:@"img_meeting_list_default"]];
}
@end
