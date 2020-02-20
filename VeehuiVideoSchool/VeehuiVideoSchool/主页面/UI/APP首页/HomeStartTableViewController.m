//
//  HomeStartTableViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/19.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "HomeStartTableViewController.h"
#import "HomeStartGirdTableViewCell.h"
#import "MedicalVideoPageRouter.h"

typedef NS_ENUM(NSUInteger, EHomeTableSection) {
    Gird_Section,
    Meeting_Section,
    SectionCount,
};

@interface HomeStartTableViewController ()

@property (nonatomic, strong) UIView* tableHeaderView;

@end

@implementation HomeStartTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setFd_interactivePopDisabled:YES];
    self.tableView.estimatedRowHeight = 44.;

    self.tableView.tableHeaderView = self.tableHeaderView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[VHTableViewCell class] forCellReuseIdentifier:[VHTableViewCell cellReuseIdentifier]];
    [self.tableView registerClass:[HomeStartGirdTableViewCell class] forCellReuseIdentifier:[HomeStartGirdTableViewCell cellReuseIdentifier]];
}

#pragma mark - settingAndGetting

- (UIView*) tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 18. + 148. * ScreenSizeRate)];
        UIImageView* bannerImageView = [_tableHeaderView addImageView:@"img_home_start_banner"];
        [bannerImageView setCornerRadius:8];
        [bannerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_tableHeaderView).insets(UIEdgeInsetsMake(9, 13, 9, 13));
        }];
    }
    return _tableHeaderView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return SectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    switch (section) {
        case Gird_Section:{
            return 1;
            break;
        }
        default:
            break;
    }
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[VHTableViewCell cellReuseIdentifier]];
    
    // Configure the cell...
    switch (indexPath.section) {
        case Gird_Section:{
            cell = [tableView dequeueReusableCellWithIdentifier:[HomeStartGirdTableViewCell cellReuseIdentifier]];
            HomeStartGirdTableViewCell* gridCell = (HomeStartGirdTableViewCell*) cell;
            WS(weakSelf)
            [gridCell onGridAction:^(NSInteger index) {
                SAFE_WEAKSELF(weakSelf)
                [weakSelf startGridItemAction:index];
            }];
            break;
        }
        default:
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark - table view delegate
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return [self tableHeaderViewHeight:section];
}

- (CGFloat) tableHeaderViewHeight:(NSInteger) section{
    CGFloat headerHeight = 0.01;
    switch (section) {
        case Gird_Section:
            headerHeight = 5.;
            break;
            
        default:
            break;
    }
    return headerHeight;
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, [self tableHeaderViewHeight:section])];
    
    return headerView;
}

#pragma mark - start grid event
- (void) startGridItemAction:(NSInteger) index{
    switch (index) {
        case StartGird_Meeting:{
                
            break;
        }
        case StartGird_MedicalVideo:{
            //医学视频
            [MedicalVideoPageRouter entryMedicalVideoStartListPage];
            break;
        }
        default:
            break;
    }
}
@end
