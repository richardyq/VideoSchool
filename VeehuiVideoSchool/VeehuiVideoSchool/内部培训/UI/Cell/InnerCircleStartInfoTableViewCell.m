//
//  InnerCircleStartInfoTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "InnerCircleStartInfoTableViewCell.h"
#import "JoinedCircleEntryModel.h"

@interface InnerCircleStartInfoTableViewCell ()

@property (nonatomic, strong) UIImageView* portraitImageView;
@property (nonatomic, strong) UILabel* circleNameLabel;

@end

@implementation InnerCircleStartInfoTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(54, 54));
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(27.);
        
        make.height.equalTo(self.contentView).offset(-18.);
    }];
    
    [self.circleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.portraitImageView.mas_right).offset(8);
        make.right.lessThanOrEqualTo(self.contentView).offset(-12);
    }];
}

#pragma mark - settingAndGetting
- (UIImageView*) portraitImageView{
    if (!_portraitImageView) {
        _portraitImageView = [self.contentView addImageView:@"icon_default_circle"];
        [_portraitImageView setCornerRadius:27];
    }
    return _portraitImageView;
}

- (UILabel*) circleNameLabel{
    if (!_circleNameLabel) {
        _circleNameLabel = [self.contentView addLabel:[UIColor whiteColor] textSize:17];
    }
    return _circleNameLabel;
}

- (void) setEntryModel:(EntryModel *)entityModel{
    if (!entityModel || ![entityModel isKindOfClass:[JoinedCircleEntryModel class]]) {
        return;
    }
    JoinedCircleEntryModel* circle = (JoinedCircleEntryModel*) entityModel;
    [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:circle.portraitUrl] placeholderImage:[UIImage imageNamed:@"icon_default_circle"]];
    self.circleNameLabel.text = circle.name;
    
    
}
@end
