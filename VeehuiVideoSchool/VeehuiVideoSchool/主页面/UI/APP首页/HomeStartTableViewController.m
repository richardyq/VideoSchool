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
#import "MeetingPageRouter.h"
#import "MeetingBussiness.h"
#import "HomeStartMeetingInfoTableViewCell.h"
#import "HomeMeetingInfo.h"

typedef NS_ENUM(NSUInteger, EHomeTableSection) {
    Gird_Section,
    Meeting_Section,
    SectionCount,
};

@interface HomeStartTableViewController ()

@property (nonatomic, strong) UIView* tableHeaderView;
@property (nonatomic, strong) HomeMeetingInfo* homeMeetingInfo;

@end

@implementation HomeStartTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setFd_interactivePopDisabled:YES];
    self.tableView.estimatedRowHeight = 44.;

    self.tableView.backgroundColor = [UIColor commonBackgroundColor];
    self.tableView.tableHeaderView = self.tableHeaderView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[VHTableViewCell class] forCellReuseIdentifier:[VHTableViewCell cellReuseIdentifier]];
    [self.tableView registerClass:[HomeStartGirdTableViewCell class] forCellReuseIdentifier:[HomeStartGirdTableViewCell cellReuseIdentifier]];
    [self.tableView registerClass:[HomeStartMeetingInfoTableViewCell class] forCellReuseIdentifier:[HomeStartMeetingInfoTableViewCell cellReuseIdentifier]];
    
    [self getData];
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
        case Meeting_Section:{
            if (self.homeMeetingInfo && self.homeMeetingInfo.meetingInfos.count > 0) {
                return 1;
            }
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
        case Meeting_Section:{
            cell = [tableView dequeueReusableCellWithIdentifier:[HomeStartMeetingInfoTableViewCell cellReuseIdentifier]];
            HomeStartMeetingInfoTableViewCell* meetingCell = (HomeStartMeetingInfoTableViewCell*) cell;
            [meetingCell setEntryModel:self.homeMeetingInfo];
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
            [MeetingPageRouter entryMeetingStartPage];
            break;
        }
        case StartGird_MedicalVideo:{
            //医学视频
            [MedicalVideoPageRouter entryMedicalVideoStartListPage];
            break;
        }
        case StartGird_Course:{
            //精品课程
            [MedicalVideoPageRouter entryMedicalCourseListPage];
            break;
        }
        default:
            break;
    }
}

#pragma mark - 获取网络数据
- (void) getData{
    //获取会议轮播
    [self startLoadMeetingInfo];
}

#pragma mark - 首页会议轮播
- (void) startLoadMeetingInfo{
    WS(weakSelf)
    [MeetingBussiness startLoadHomeMeetings:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if ([result isKindOfClass:[HomeMeetingInfo class]]) {
            weakSelf.homeMeetingInfo = result;
        }
    } complete:^(NSInteger code, NSString *message) {
        SAFE_WEAKSELF(weakSelf)
        if (code == 0) {
            [weakSelf.tableView reloadData];
        }
    }];
}
@end
