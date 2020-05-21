//
//  InnerCourseFilterCateView.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/21.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "InnerCourseFilterCateView.h"

@interface InnerCourseFilterCateTableViewCell : VHTableViewCell

@property (nonatomic, strong) UILabel* cateNameLabel;

@end

@implementation InnerCourseFilterCateTableViewCell



@end

@interface InnerCourseFilterCateView ()
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableview;

@end

@implementation InnerCourseFilterCateView

#pragma mark - settingAndGetting
- (UITableView*) tableview{
    if (!_tableview) {
        _tableview = (UITableView*)[self addView:[UITableView class]];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.estimatedRowHeight = 45.;
        _tableview.backgroundColor = [UIColor clearColor];
        [_tableview registerClass:[InnerCourseFilterCateTableViewCell class] forCellReuseIdentifier:[InnerCourseFilterCateTableViewCell cellReuseIdentifier]];
    }
    return _tableview;
}


@end
