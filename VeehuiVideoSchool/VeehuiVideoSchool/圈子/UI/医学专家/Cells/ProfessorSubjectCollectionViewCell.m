//
//  ProfessorSubjectCollectionViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/3.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "ProfessorSubjectCollectionViewCell.h"
#import "MedicalVideoClassifyEntryModel.h"

@interface ProfessorSubjectCollectionViewCell ()

@property (nonatomic, strong) UIImageView* iconImageView;
@property (nonatomic, strong) UILabel* titleLabel;

@end

@implementation ProfessorSubjectCollectionViewCell

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(49, 49));
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(9);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.iconImageView.mas_bottom);
        make.width.lessThanOrEqualTo(self.contentView);
    }];
}

#pragma mark - settingAndGetting
- (UIImageView*) iconImageView{
    if (!_iconImageView) {
        _iconImageView = [self.contentView addImageView:@"ic_default_subject"];
    }
    return _iconImageView;
}

- (UILabel*) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [self.contentView addLabel:[UIColor colorWithHexString:@"#454B67"] textSize:13];
    }
    return _titleLabel;
}

- (void) setEntryModel:(EntryModel *)model{
    self.titleLabel.text = @"";
    self.iconImageView.image = nil;
    if (!model || ![model isKindOfClass:[MedicalVideoClassifyEntryModel class]]) {
        return;
    }
    
    MedicalVideoClassifyEntryModel* subject = (MedicalVideoClassifyEntryModel*) model;
    if (!subject.code || [subject.code isEmpty]) {
        return;
    }
    self.iconImageView.image = [UIImage imageNamed:@"ic_default_subject"];
    self.titleLabel.text = subject.name;
}
@end
