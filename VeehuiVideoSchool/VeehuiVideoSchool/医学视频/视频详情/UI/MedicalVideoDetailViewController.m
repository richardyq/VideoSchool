//
//  MedicalVideoDetailViewController.m
//  VeehuiVideoSchool
//  医学视频详情
//  Created by 殷全 on 2020/3/11.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalVideoDetailViewController.h"
#import "MedicalVideoListBussiness.h"
#import "MedicalVideoGroupDetailEntryModel.h"
#import "MedicalVideoDetailTitleTableViewCell.h"
#import "MedicalVideoDetailDirectoryTableViewCell.h"
#import "VHRefeshStatusHeader.h"

typedef NS_ENUM(NSUInteger, EMedicalVideoDetialSection) {
    GroupTitleSection,
    GroupDirectorySection,
    SectionCount,
};

@interface MedicalVideoDetailViewController ()
<UITableViewDelegate>
@property (nonatomic, readonly) NSInteger groupId;
@property (nonatomic, strong) VHNavigationBarView* navigationBarView;

@property (nonatomic, strong) MedicalVideoGroupDetailEntryModel* groupDetail;

@property (nonatomic, strong) UIView* tableHeaderView;
@end



@implementation MedicalVideoDetailViewController

- (id) initWithVideoGroupId:(NSInteger) groupId{
    self = [super init];
    if (self) {
        _groupId = groupId;
    }
    return self;
}

- (void) makeParamDictionary{
    //TODO:构建特定参数
    [self.paramDictionary setValue:@(self.groupId) forKey:@"groupId"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setFd_prefersNavigationBarHidden:YES];
    [self setFd_interactivePopDisabled:YES];
    
    self.tableview.mj_header = nil;
    [self startLoadVideoGroupDetal];
    
    self.tableview.tableHeaderView = self.tableHeaderView;
    [self.tableview registerClass:[MedicalVideoDetailTitleTableViewCell class] forCellReuseIdentifier:[MedicalVideoDetailTitleTableViewCell cellReuseIdentifier]];
    [self.tableview registerClass:[MedicalVideoDetailDirectoryTableViewCell class] forCellReuseIdentifier:[MedicalVideoDetailDirectoryTableViewCell cellReuseIdentifier]];
}

- (void) updateViewConstraints{
    [super updateViewConstraints];
    
    [self.navigationBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(@(Navi_height));
    }];
    
}

#pragma mark - settingAndGetting
- (VHNavigationBarView*) navigationBarView{
    if (!_navigationBarView) {
        _navigationBarView = [[VHNavigationBarView alloc] initWithNavigationType:Navigation_Trans];
        [self.view addSubview:_navigationBarView];
    }
    return _navigationBarView;
}

- (UIView*) tableHeaderView{
    if (!_tableHeaderView) {
        CGFloat headerHeight = kScreenWidth * (275. / 375.);
        if ([[UIDevice currentDevice] isPad]) {
            headerHeight = kScreenWidth * 0.7 * (275. / 375.);
        }
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, headerHeight)];
        _tableHeaderView.backgroundColor = [UIColor whiteColor];
    }
    return _tableHeaderView;
}

#pragma mark - 获取网络数据
- (void) startLoadVideoGroupDetal{
    [MessageHubUtil showWait];
    WS(weakSelf)
    [MedicalVideoListBussiness startLoadMedicalVideoGroupDetail:self.groupId result:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if ([result isKindOfClass:[MedicalVideoGroupDetailEntryModel class]]) {
            weakSelf.groupDetail = result;
            [weakSelf.tableview reloadData];
        }
    } complete:^(NSInteger code, NSString *message) {
        [MessageHubUtil hideMessage];
        SAFE_WEAKSELF(weakSelf)
        if (code != 0) {
            [MessageHubUtil showErrorMessage:message];
        }
    }];
}

#pragma mark table view data source
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return SectionCount;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case GroupTitleSection:{
            if (self.groupDetail) {
                return 1;
            }
            break;
        }
        case GroupDirectorySection:{
            if (self.groupDetail && self.groupDetail.medicalVideoItems.count > 1) {
                return 1;
            }
            break;
        }
        default:
            break;
    }
    return 0;
}

- (Class) tableViewCellClass:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case GroupTitleSection:{
            return [MedicalVideoDetailTitleTableViewCell class];
            break;
        }
        case GroupDirectorySection:{
            return [MedicalVideoDetailDirectoryTableViewCell class];
            break;
        }
        default:
            break;
    }
    return [VHTableViewCell class];
}

- (VHTableViewCell*) tableViewCell:(Class) class indexPath:(NSIndexPath*) indexPath{
    VHTableViewCell* cell = [super tableViewCell:class indexPath:indexPath];
    switch (indexPath.section) {
        case GroupTitleSection:{
            MedicalVideoDetailTitleTableViewCell* titleCell = (MedicalVideoDetailTitleTableViewCell*) cell;
            [titleCell setTitle:self.groupDetail.title];
            break;
        }
        case GroupDirectorySection:{
            MedicalVideoDetailDirectoryTableViewCell* directoryeCell = (MedicalVideoDetailDirectoryTableViewCell*) cell;
            [directoryeCell setEntryModel:self.groupDetail];
            break;
        }
        default:
            break;
    }
    
    return cell;
}

#pragma mark - table view delegate
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        
        default:
            break;
    }
    return 0;
}

#pragma mark table view footer view
- (CGFloat) footerViewHeight:(NSInteger) section{
    switch (section) {
        case GroupDirectorySection:
            if (self.groupDetail && self.groupDetail.medicalVideoItems.count > 1) {
                return 5.;
            }
            break;
            
        default:
            break;
    }
    return 0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return [self footerViewHeight:section];
}

- (UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    CGFloat tableWidth = kScreenWidth;
    if ([UIDevice currentDevice].isPad) {
        tableWidth = kScreenWidth * 0.7;
    }
    CGFloat footerHeight = [self footerViewHeight:section];
    if (footerHeight == 0) {
        return nil;
    }
    UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableWidth, [self footerViewHeight:section])];
    footerView.backgroundColor = [UIColor commonBackgroundColor];
    return footerView;
}

@end
