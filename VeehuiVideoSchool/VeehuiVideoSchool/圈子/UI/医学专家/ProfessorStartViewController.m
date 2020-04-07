//
//  ProfessorStartViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/3.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "ProfessorStartViewController.h"

#import "ProfessorSubjectCollectionViewController.h"

@interface ProfessorStartViewController ()

@property (nonatomic, strong) UIView* subjectHeaderView;
@property (nonatomic, strong) ProfessorSubjectCollectionViewController* subjectViewController;

@end

@implementation ProfessorStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"医学专家";
    self.tableview.backgroundColor = [UIColor commonBackgroundColor];
    self.tableview.mj_header = nil;
    [self.tableview setTableHeaderView:self.subjectHeaderView];
    [self getData];
}

- (void) updateViewConstraints{
    [super updateViewConstraints];
    
    [self.subjectViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.subjectHeaderView).insets(UIEdgeInsetsMake(10, 12.5, 8, 12.5));
    }];
}

#pragma mark - 获取网络数据
- (void) getData{
    
}

#pragma mark - settingAndGetting
- (UIView*) subjectHeaderView{
    if (!_subjectHeaderView) {
        CGFloat tableWidth = kScreenWidth;
        if ([UIDevice currentDevice].isPad) {
            tableWidth = kScreenWidth * 0.7;
        }
        _subjectHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableWidth, 200)];
    }
    return _subjectHeaderView;
}

- (ProfessorSubjectCollectionViewController*) subjectViewController{
    if (!_subjectViewController) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat tableWidth = kScreenWidth;
        if ([UIDevice currentDevice].isPad) {
            tableWidth = kScreenWidth * 0.7;
        }
        CGFloat cellWidth = (tableWidth - 25) / 4.;
        layout.itemSize = CGSizeMake(cellWidth , 89);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;     //水平滑动
        // 设置最小行间距
        layout.minimumLineSpacing = 0;
        // 设置垂直间距
        layout.minimumInteritemSpacing = 0;
        _subjectViewController = [[ProfessorSubjectCollectionViewController alloc] initWithCollectionViewLayout:layout];
        [self addChildViewController:_subjectViewController];
        [self.subjectHeaderView addSubview:_subjectViewController.view];
       
        [_subjectViewController.view setCornerRadius:9.];
    }
    return _subjectViewController;
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return NO;
}

@end
