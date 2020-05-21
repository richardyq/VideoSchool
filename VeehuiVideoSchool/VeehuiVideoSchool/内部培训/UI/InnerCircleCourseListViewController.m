//
//  InnerCircleCourseListViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/21.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "InnerCircleCourseListViewController.h"
#import "InnerCircleCourseFilterView.h"

@interface InnerCircleCourseListViewController ()

@property (nonatomic) InnerCircleCourseType courseType;
@property (nonatomic, strong) InnerCircleCourseFilterView* filterview;
@end

@implementation InnerCircleCourseListViewController

- (id) initWithCourseType:(InnerCircleCourseType) courseType{
    self = [super init];
    if (self) {
        _courseType = courseType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = [self navigationTitle];
    
    self.tableview.mj_header = nil;
}

- (void) updateViewConstraints{
    [super updateViewConstraints];
    
    [self.filterview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(@53);
    }];
    
    [self.tableview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.filterview.mas_bottom);
    }];
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return NO;
}

#pragma mark 导航标题
- (NSString*) navigationTitle{
    NSString* naviTitle = @"课程";
    switch (self.courseType) {
        case CourseTypeNecessarily:{
            naviTitle = @"必学课程";
            break;
        }
        case CourseTypeUnnecessarily:{
            naviTitle = @"选学课程";
            break;
        }
        default:
            break;
    }
    return naviTitle;
}

#pragma mark - settingAndGetting
- (InnerCircleCourseFilterView*) filterview{
    if (!_filterview) {
        _filterview = (InnerCircleCourseFilterView*)[self.view addView:[InnerCircleCourseFilterView class]];
    }
    return _filterview;
}

@end
