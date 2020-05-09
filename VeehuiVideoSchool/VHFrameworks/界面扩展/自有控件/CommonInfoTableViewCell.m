//
//  CommonInfoTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/8.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "CommonInfoTableViewCell.h"

@implementation CommonInfoModel

@end

@interface CommonInfoTableViewCell ()



@end

@implementation CommonInfoTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView showBoarder:UIViewBorderLineTypeBottom];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12.5);
        make.top.equalTo(self.contentView).offset(15);
        make.bottom.lessThanOrEqualTo(self.contentView).offset(-15);
        
        CGFloat width = [self.nameLabel.text widthForFont:self.nameLabel.font];
        make.width.mas_greaterThanOrEqualTo(@(width));
    }];
    
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(self.nameLabel.mas_right).offset(7.5);
        make.right.equalTo(self.contentView).offset(-12.5);
        make.top.equalTo(self.contentView).offset(15);
        make.bottom.lessThanOrEqualTo(self.contentView).offset(-15);
    }];
}

#pragma mark - settingAndGetting
- (UILabel*) nameLabel{
    if (!_nameLabel) {
        _nameLabel = [self.contentView addLabel:[UIColor commonTextColor] textSize:15];
    }
    return _nameLabel;
}

- (UILabel*) valueLabel{
    if (!_valueLabel) {
        _valueLabel = [self.contentView addLabel:[UIColor commonGrayTextColor] textSize:15];
        _valueLabel.numberOfLines = 0;
    }
    return _valueLabel;
}

- (void) setEntryModel:(EntryModel *)model{
    self.nameLabel.text = @" ";
    self.valueLabel.text = @" ";
    if (!model || ![model isKindOfClass:[CommonInfoModel class]]) {
        return;
    }
    
    CommonInfoModel* infoModel = (CommonInfoModel*) model;
    self.nameLabel.text = infoModel.name;
    //self.nameLabel.width = [infoModel.name widthForFont:self.nameLabel.font];
    self.valueLabel.text = infoModel.value;
    //[self setNeedsUpdateConstraints];
}

@end
