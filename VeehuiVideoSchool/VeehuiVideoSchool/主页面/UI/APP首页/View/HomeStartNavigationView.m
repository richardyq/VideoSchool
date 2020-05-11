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
@property (nonatomic, strong) UIImageView* microPhoneImageView;

@end

@implementation HomeStartNavigationView

- (id) init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    [self.searchControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(5, 16, 7, 16));
        make.height.mas_equalTo(@32.);
    }];
    
    [self.searchIconIamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.searchControl);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.left.equalTo(self.searchControl).offset(16.);
    }];
    
    [self.microPhoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.searchControl);
        make.size.mas_equalTo(CGSizeMake(13, 18));
        make.right.equalTo(self.searchControl).offset(-16);
    }];
    
    [self.searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.searchControl);
        make.left.equalTo(self.searchIconIamgeView.mas_right).offset(8.);
        make.right.lessThanOrEqualTo(self.microPhoneImageView.mas_left).offset(-6);
    }];
}

#pragma mark - settingAndGetting


- (UIControl*) searchControl{
    if (!_searchControl) {
        _searchControl = (UIControl*)[self addView:[UIControl class]];
        [_searchControl setCornerRadius:16];
        _searchControl.backgroundColor = [UIColor colorWithHexString:@"#F3F3F3"];
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
        _searchLabel = [self.searchControl addLabel:[UIColor commonGrayTextColor] textSize:14];
        _searchLabel.text = @"搜索学科或主讲人";
    }
    return _searchLabel;
}

- (UIImageView*) microPhoneImageView{
    if (!_microPhoneImageView) {
        _microPhoneImageView = [self.searchControl addImageView:@"ic_home_microphone"];
    }
    return _microPhoneImageView;
}
@end
