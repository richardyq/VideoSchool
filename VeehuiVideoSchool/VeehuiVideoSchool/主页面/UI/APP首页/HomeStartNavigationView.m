//
//  HomeStartNavigationView.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/19.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "HomeStartNavigationView.h"

@interface HomeStartNavigationView ()


@property (nonatomic, strong) UIControl* searchControl;
@property (nonatomic, strong) UIImageView* searchIconIamgeView;
@property (nonatomic, strong) UILabel* searchLabel;

@end

@implementation HomeStartNavigationView

- (void) updateConstraints{
    [super updateConstraints];
    
    
    
    [self.searchControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(@36.);
        make.right.equalTo(self).offset(-12);
    }];
    
    [self.searchIconIamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.searchControl);
        make.size.mas_equalTo(CGSizeMake(17, 17));
        make.left.equalTo(self.searchControl).offset(9.);
    }];
    
    [self.searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.searchControl);
        make.left.equalTo(self.searchIconIamgeView.mas_right).offset(6.);
        make.right.equalTo(self.searchControl).offset(-6);
    }];
}

#pragma mark - settingAndGetting


- (UIControl*) searchControl{
    if (!_searchControl) {
        _searchControl = (UIControl*)[self addView:[UIControl class]];
        [_searchControl setCornerRadius:5];
        _searchControl.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
    }
    return _searchControl;
}

- (UIImageView*) searchIconIamgeView{
    if (!_searchIconIamgeView) {
        _searchIconIamgeView = [self.searchControl addImageView:@"ic_navi_search"];
    }
    return _searchIconIamgeView;
}

- (UILabel*) searchLabel{
    if (!_searchLabel) {
        _searchLabel = [self.searchControl addLabel:[UIColor commonGrayTextColor] textSize:13];
        _searchLabel.text = @"搜索学科或主讲人";
    }
    return _searchLabel;
}
@end
