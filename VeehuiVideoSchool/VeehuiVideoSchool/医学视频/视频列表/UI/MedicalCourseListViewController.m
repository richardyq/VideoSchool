//
//  MedicalCourseListViewController.m
//  VeehuiVideoSchool
//  精品课程列表
//  Created by 殷全 on 2020/3/10.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalCourseListViewController.h"
#import "MedicalVideoInfoTableViewCell.h"
#import "MedicalVideoListBussiness.h"

@interface MedicalCourseListViewController ()

@end

@implementation MedicalCourseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"精品课程";
    self.tableview.backgroundColor = [UIColor commonBackgroundColor];
    [self.tableview registerClass:[MedicalVideoInfoTableViewCell class] forCellReuseIdentifier:[MedicalVideoInfoTableViewCell cellReuseIdentifier]];
    [self beginRefreshData];
}


- (Class) tableViewCellClass{
    return [MedicalVideoInfoTableViewCell class];
}


#pragma mark - 加载网络数据
- (void) refreshDataCommand{
    [self startLoadMedicalCourseList];
}

- (void) loadMoreDataCommand{
    [self startLoadMedicalCourseList:self.pageNo + 1];
}

- (void) startLoadMedicalCourseList{
    [self startLoadMedicalCourseList:1];
}

- (void) startLoadMedicalCourseList:(NSInteger) pageNo{
    if (pageNo <= 1) {
        [self.models removeAllObjects];
        self.pageNo = 1;
    }
    
    WS(weakSelf)
    [MedicalVideoListBussiness startLoadMedicalCourseList:pageNo pageSize:self.pageSize result:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if ([result isKindOfClass:[ListModel class]]) {
            [weakSelf medicalCourseListLoaded:result];
        }
        
    } complete:^(NSInteger code, NSString *message) {
        [MessageHubUtil hideMessage];
        SAFE_WEAKSELF(weakSelf)
        [weakSelf refreshCommandEnd:self.pageNo totalPage:self.totalPages];
        if (code != 0) {
            [MessageHubUtil showErrorMessage:message];
            return ;
        }
    }];
}

- (void) medicalCourseListLoaded:(ListModel*) listModel{
    self.pageNo = listModel.pageNo;
    self.totalPages = listModel.totalPages;
    
    [self.models addObjectsFromArray:listModel.content];
    [self.tableview reloadData];
}

@end
