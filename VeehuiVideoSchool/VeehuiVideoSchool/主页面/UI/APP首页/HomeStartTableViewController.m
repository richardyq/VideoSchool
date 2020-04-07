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
#import "HomeSubjectHeaderTableViewCell.h"
#import "HomeSubjectMeetingTableViewCell.h"
#import "HomeFooterTableViewCell.h"
#import "HomeSubjectEntry.h"
#import "CirclePageRouter.h"
#import "AdvertiseEntryModel.h"
#import "CommonBaseBussiness.h"

typedef NS_ENUM(NSUInteger, EHomeTableSection) {
    Gird_Section,
    Meeting_Section,
    Circle_Section,
    Course_Section,
    User_Section,
    
    Video_Section,
    //Subject_Section,
    SectionCount,
};

@interface HomeStartTableViewController ()
<SDCycleScrollViewDelegate>

@property (nonatomic, strong) UIView* tableHeaderView;
@property (nonatomic, strong) SDCycleScrollView* advertiseView;

@property (nonatomic, strong) HomeMeetingInfo* homeMeetingInfo;
@property (nonatomic, strong) MedicalVideoGroupInfoListModel* recommandCourseList;
@property (nonatomic, strong) MedicalVideoGroupInfoListModel* recommandVideosList;
@property (nonatomic, strong) HomeSubjectListModel* homeSubjects;

@property (nonatomic, strong) NSArray<AdvertiseEntryModel*>* advertiseModels;

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
    [self.tableView registerClass:[HomeFooterTableViewCell class] forCellReuseIdentifier:[HomeFooterTableViewCell cellReuseIdentifier]];
    
    [self startLoadHomeAdvertiseList];
    [self getData];
}

#pragma mark - settingAndGetting

- (UIView*) tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 18. + 148. * ScreenSizeRate)];
        UIImageView* bannerImageView = [_tableHeaderView addImageView:@"img_default_main"];
        [bannerImageView setCornerRadius:8];
        [bannerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_tableHeaderView).insets(UIEdgeInsetsMake(9, 13, 9, 13));
        }];
    }
    return _tableHeaderView;
}

- (SDCycleScrollView*) advertiseView{
    if (!_advertiseView) {
        CGFloat width = kScreenWidth;
        if ([UIDevice currentDevice].isPad) {
            width = kScreenWidth * 0.7;
        }
        CGFloat rate = width/128.;
        width -= 26.;
        CGFloat height = 128. * rate;
        _advertiseView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, width, height) delegate:self placeholderImage:[UIImage imageNamed:@"img_default_main"]];
        [_tableHeaderView addSubview:_advertiseView];
        [_advertiseView setCornerRadius:8];
        [_advertiseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_tableHeaderView).insets(UIEdgeInsetsMake(9, 13, 9, 13));
        }];
        _advertiseView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _advertiseView.currentPageDotColor = [UIColor grayColor];
        _advertiseView.autoScrollTimeInterval = 5;
        _advertiseView.currentPageDotColor = [UIColor whiteColor];
    }
    return _advertiseView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    NSInteger sectionCount = SectionCount + 1;
    if (self.homeSubjects) {
        sectionCount += self.homeSubjects.content.count;
    }
    return sectionCount;
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
    
    if (section > Video_Section) {
        if (self.homeSubjects && section < (SectionCount + self.homeSubjects.content.count)) {
            HomeSubjectEntry* subjectEntry = (HomeSubjectEntry*)self.homeSubjects.content[section - Video_Section - 1];
            return 1 + subjectEntry.meetingInfos.count + subjectEntry.lengthwaysMedicalVideos.count;
        }
        else{
            return 1;
        }
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
            break;
        }
    }
    NSInteger section = indexPath.section;
    if (section > Video_Section  ) {
        if (self.homeSubjects && section <= (Video_Section + self.homeSubjects.content.count)) {
            HomeSubjectEntry* subject =  self.homeSubjects.content[section - Video_Section - 1];
            NSInteger row = indexPath.row;
            if (row == 0) {
                cell = [[HomeSubjectHeaderTableViewCell alloc] initWithSubjectEntry:subject];
            }
            else if (row <= subject.meetingInfos.count){
                MeetingEntryModel* meeting = subject.meetingInfos[row - 1];
                cell = [[HomeSubjectMeetingTableViewCell alloc] initWithMeetingEntry:meeting];
            }
            else{
                cell = [tableView dequeueReusableCellWithIdentifier:[MedicalVideoInfoTableViewCell cellReuseIdentifier]];
                MedicalVideoGroupInfoListModel* videoGroup = subject.lengthwaysMedicalVideos[row - subject.meetingInfos.count - 1];
                [cell setEntryModel:videoGroup];
            }
        }
        else{
            cell = [tableView dequeueReusableCellWithIdentifier:[HomeFooterTableViewCell cellReuseIdentifier]];
        }
        
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
        case StartGird_Professor:{
            //医学专家
            [CirclePageRouter entryProfessorStartPage];
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
    //获取推荐课程
    [self startLoadRecommandCourses];
    //获取推荐视频
    [self startLoadRecommandVideos];
    
    [self startLoadSubjectContents];
}

//获取广告列表数据
- (void) startLoadHomeAdvertiseList{
    WS(weakSelf)
    [CommonBaseBussiness loadHomeAdvertises:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if ([result isKindOfClass:[NSArray class]]) {
            [weakSelf homeAdvertiseListLoaded:result];
        }
    } complete:^(NSInteger code, NSString *message) {
        
    }];
}

- (void) homeAdvertiseListLoaded:(NSArray<AdvertiseEntryModel*>*) advertises{
    self.advertiseModels = advertises;
    NSArray<NSString*>* imageUrls = [advertises valueForKey:@"pictureUrl"];
    [self.advertiseView setImageURLStringsGroup:imageUrls];
}

#pragma mark - 首页会议轮播
- (void) startLoadMeetingInfo{
    WS(weakSelf)
    [MeetingBussiness startLoadHomeMeetings:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if ([result isKindOfClass:[HomeMeetingInfo class]]) {
            weakSelf.homeMeetingInfo = result;
        }
        [weakSelf reloadTable];
    } complete:^(NSInteger code, NSString *message) {
        SAFE_WEAKSELF(weakSelf)
        
        if (code == 0) {
            //[weakSelf.tableView reloadData];
            //获取推荐课程
            
        }
    }];
}

#pragma mark - 获取首页推荐课程
- (void) startLoadRecommandCourses{
    WS(weakSelf)
    [MedicalVideoListBussiness startLoadHomeRecommandCoursesVideos:^(id result) {
        WS(weakSelf)
        if (!result || ![result isKindOfClass:[MedicalVideoGroupInfoListModel class]]) {
            return ;
        }
        weakSelf.recommandCourseList = result;
        [weakSelf reloadTable];
    } complete:^(NSInteger code, NSString *message) {
        SAFE_WEAKSELF(weakSelf)
        
        if (code == 0) {
            
        }
    }];
}

#pragma mark - 获取首页推荐课程
- (void) startLoadRecommandVideos{
    WS(weakSelf)
    [MedicalVideoListBussiness startLoadHomeRecommandVideos:^(id result) {
        WS(weakSelf)
        if (!result || ![result isKindOfClass:[MedicalVideoGroupInfoListModel class]]) {
            return ;
        }
        weakSelf.recommandVideosList = result;
        [weakSelf reloadTable];
    } complete:^(NSInteger code, NSString *message) {
        SAFE_WEAKSELF(weakSelf)
        
        if (code == 0) {
            
        }
    }];
}

#pragma mark - 分类展示内容。
- (void) startLoadSubjectContents{
    WS(weakSelf)
    [MedicalVideoListBussiness startLoadHomeSubjectContent:^(id result) {
        WS(weakSelf)
       if (!result || ![result isKindOfClass:[HomeSubjectListModel class]]) {
            return ;
        }
        weakSelf.homeSubjects = result;
        [weakSelf reloadTable];
    } complete:^(NSInteger code, NSString *message) {
        SAFE_WEAKSELF(weakSelf)
        
        if (code == 0) {
            
        }
    }];
}

- (void) reloadTable{
    [self.tableView reloadData];
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    AdvertiseEntryModel* advertise = self.advertiseModels[index];
    NSString* typeCode = advertise.typeCode;
    if (!typeCode || [typeCode isEmpty]) {
        return;
    }
}
@end
