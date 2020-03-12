//
//  MedicalVideoDetailTitleTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/11.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalVideoDetailTitleTableViewCell.h"

@interface MedicalVideoDetailTitleTableViewCell ()

@property (nonatomic, strong) UILabel* titleLabel;

@end

@implementation MedicalVideoDetailTitleTableViewCell

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
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(17, 15, 17, 15));
    }];
}

- (void) setTitle:(NSString*) title{
    [self.titleLabel setText:title lineSpacing:5.5];
}

#pragma mark - settingAndGetting
- (UILabel*) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [self.contentView addLabel:[UIColor commonTextColor] textSize:18];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

@end
