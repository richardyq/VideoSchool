//
//  HomeFooterTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/1.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "HomeFooterTableViewCell.h"

@interface HomeFooterTableViewCell ()

@property (nonatomic, strong) UIView* headerView;
@property (nonatomic, strong) UIImageView* iconImageView;
@property (nonatomic, strong) UILabel* headerLabel;

@property (nonatomic, strong) UILabel* footerLabel;

@end

@implementation HomeFooterTableViewCell

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
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(17.);
        make.centerX.equalTo(self.contentView);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(17, 17));
        make.left.equalTo(self.headerView);
        make.centerY.equalTo(self.headerView);
    }];
    
    [self.headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headerView);
        make.right.equalTo(self.headerView);
        make.left.equalTo(self.iconImageView.mas_right).offset(4.);
    }];
    
    [self.footerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-17.);
        make.top.equalTo(self.headerView.mas_bottom).offset(10.);
    }];
}

#pragma mark - settingAndGetting
- (UIView*) headerView{
    if (!_headerView) {
        _headerView = [self.contentView addView];
    }
    return _headerView;
}

- (UIImageView*) iconImageView{
    if (!_iconImageView) {
        _iconImageView = [self.headerView addImageView:@""];
    }
    return _iconImageView;
}

- (UILabel*) headerLabel{
    if (!_headerLabel) {
        _headerLabel = [self.headerView addLabel:[UIColor commonGrayTextColor] textSize:14];
        _headerLabel.font = [UIFont boldSystemFontOfSize:14];
        _headerLabel.text = @"微医汇";
    }
    return _headerLabel;
}

- (UILabel*) footerLabel{
    if (!_footerLabel) {
        _footerLabel = [self.contentView addLabel:[UIColor commonGrayTextColor] textSize:10];
        _footerLabel.text = @"专业的互联网医疗教育平台";
    }
    return _footerLabel;
}
@end
