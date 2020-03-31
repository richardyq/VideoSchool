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
#import "HomeJoinedCircleTableViewCell.h"
#import "HomeRecommandCourseTableViewCell.h"
#import "HomeUserRecommandTableViewCell.h"
#import "HomeMeetingInfo.h"
#import "CommonDataModel.h"
#import "MedicalVideoListBussiness.h"
#import "MedicalVideoGroupInfoEntryModel.h"
#import "MedicalVideoInfoTableViewCell.h"

typedef NS_ENUM(NSUInteger, EHomeTableSection) {
    Gird_Section,
    Meeting_Section,
    Circle_Section,
    Course_Section,
    User_Section,
    
    Video_Section,
    SectionCount,
};

@interface HomeStartTableViewController ()

@property (nonatomic, strong) UIView* tableHeaderView;
@property (nonatomic, strong) HomeMeetingInfo* homeMeetingInfo;
@property (nonatomic, strong) MedicalVideoGroupInfoListModel* recommandCourseList;
@property (nonatomic, strong) MedicalVideoGroupInfoListModel* recommandVideosList;

@property (nonatomic) NSInteger tick;

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
    [self.tableView registerClass:[HomeJoinedCircleTableViewCell class] forCellReuseIdentifier:[HomeJoinedCircleTableViewCell cellReuseIdentifier]];
    [self.tableView registerClass:[HomeRecommandCourseTableViewCell class] forCellReuseIdentifier:[HomeRecommandCourseTableViewCell cellReuseIdentifier]];
    [self.tableView registerClass:[HomeUserRecommandTableViewCell class] forCellReuseIdentifier:[HomeUserRecommandTableViewCell cellReuseIdentifier]];
    [self.tableView registerClass:[MedicalVideoInfoTableViewCell class] forCellReuseIdentifier:[MedicalVideoInfoTableViewCell cellReuseIdentifier]];
    
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
            break;
        }
        case Circle_Section:{
            if ([CommonDataModel shareInstance].joinedCircleInfo) {
                return 1;
            }
            break;
        }
        case Course_Section:{
            if (self.recommandCourseList) {
                return 1;
            }
            break;
        }
        case User_Section:{
            return 1;
        }
        case Video_Section:{
            if (self.recommandVideosList) {
                return self.recommandVideosList.content.count;
            }
            break;
        }
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[VHTableViewCell cellReuseIdentifier]];
    
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
        case Circle_Section:{
            cell = [[HomeJoinedCircleTableViewCell alloc] initWithJoinedCircle:[CommonDataModel shareInstance].joinedCircleInfo];
            
            break;
        }
        case Course_Section:{
            cell = [[HomeRecommandCourseTableViewCell alloc] initWithCourseList:self.recommandCourseList];
            
            break;
        }
        case User_Section:{
            cell = [tableView dequeueReusableCellWithIdentifier:[HomeUserRecommandTableViewCell cellReuseIdentifier]];
            break;
        }
        case Video_Section:{
            cell = [tableView dequeueReusableCellWithIdentifier:[MedicalVideoInfoTableViewCell cellReuseIdentifier]];
            MedicalVideoGroupInfoListModel* videoGroup = self.recommandVideosList.content[indexPath.row];
            [cell setEntryModel:videoGroup];
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
    self.tick = 0;
    //获取会议轮播
    [self startLoadMeetingInfo];
    //获取推荐课程
    [self startLoadRecommandCourses];
    //获取推荐视频
    [self startLoadRecommandVideos];
}

#pragma mark - 首页会议轮播
- (void) startLoadMeetingInfo{
    WS(weakSelf)
    ++self.tick;
    [MeetingBussiness startLoadHomeMeetings:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if ([result isKindOfClass:[HomeMeetingInfo class]]) {
            weakSelf.homeMeetingInfo = result;
        }
    } complete:^(NSInteger code, NSString *message) {
        SAFE_WEAKSELF(weakSelf)
        [weakSelf tickdown];
        if (code == 0) {
            //[weakSelf.tableView reloadData];
            //获取推荐课程
            
        }
    }];
}

#pragma mark - 获取首页推荐课程
- (void) startLoadRecommandCourses{
    ++self.tick;
    WS(weakSelf)
    [MedicalVideoListBussiness startLoadHomeRecommandCoursesVideos:^(id result) {
        WS(weakSelf)
        if (!result || ![result isKindOfClass:[MedicalVideoGroupInfoListModel class]]) {
            return ;
        }
        weakSelf.recommandCourseList = result;
    } complete:^(NSInteger code, NSString *message) {
        SAFE_WEAKSELF(weakSelf)
        [weakSelf tickdown];
        if (code == 0) {
            
        }
    }];
}

#pragma mark - 获取首页推荐课程
- (void) startLoadRecommandVideos{
    ++self.tick;
    WS(weakSelf)
    [MedicalVideoListBussiness startLoadHomeRecommandVideos:^(id result) {
        WS(weakSelf)
        if (!result || ![result isKindOfClass:[MedicalVideoGroupInfoListModel class]]) {
            return ;
        }
        weakSelf.recommandVideosList = result;
    } complete:^(NSInteger code, NSString *message) {
        SAFE_WEAKSELF(weakSelf)
        [weakSelf tickdown];
        if (code == 0) {
            
        }
    }];
}

- (void) tickdown{
    if (--self.tick <= 0) {
        [self.tableView reloadData];
    }
}
@end
