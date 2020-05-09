//
//  CommonEditTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/8.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "CommonEditTableViewCell.h"

@interface CommonEditTableViewCell ()

@property (nonatomic, strong) UIImageView* arrowIamgeView;

@end

@implementation CommonEditTableViewCell

- (void) updateConstraints{
    [super updateConstraints];
    [self.arrowIamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel);
        make.right.equalTo(self.contentView).offset(-8);
    }];
    
    [self.valueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(self.nameLabel.mas_right).offset(7.5);
        make.right.equalTo(self.arrowIamgeView.mas_left).offset(-5.5);
        make.top.equalTo(self.contentView).offset(15);
        make.bottom.lessThanOrEqualTo(self.contentView).offset(-15);
    }];
}
#pragma mark - settingAndGetting
- (UIImageView*) arrowIamgeView{
    if (!_arrowIamgeView) {
        _arrowIamgeView = [self.contentView addImageView:@"ic_right_arrow"];
    }
    return _arrowIamgeView;
}

- (void) setEntryModel:(EntryModel *)model{
    self.nameLabel.text = @" ";
    self.nameLabel.text = nil;
    if (!model || ![model isKindOfClass:[CommonInfoModel class]]) {
        return;
    }
    
    CommonInfoModel* infoModel = (CommonInfoModel*) model;
    self.nameLabel.text = infoModel.name;
    self.valueLabel.text = infoModel.value;
    self.valueLabel.textColor = [UIColor commonGrayTextColor];
    
    if (!infoModel.value || [infoModel.value isEmpty]) {
        self.valueLabel.text = infoModel.placeholder;
        self.valueLabel.textColor = [UIColor commonLightGrayTextColor];
    }
}


@end
