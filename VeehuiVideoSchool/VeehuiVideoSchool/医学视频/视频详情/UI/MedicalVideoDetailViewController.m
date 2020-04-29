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
#import "MedicalVideoDetailCircleTableViewCell.h"
#import "MedicalVideoGroupOtherVideoTableViewCell.h"
#import "VHRefeshStatusHeader.h"

typedef NS_ENUM(NSUInteger, EMedicalVideoDetialSection) {
    GroupTitleSection,
    GroupDirectorySection,
    GroupCircleSection,
    GroupOthersSection,         //看了本视频的人也在学
    SectionCount,
};

@interface MedicalVideoDetailViewController ()
<UITableViewDelegate, MedicalVideoDirectoryDelegate>
@property (nonatomic, readonly) NSInteger groupId;
@property (nonatomic, strong) VHNavigationBarView* navigationBarView;

@property (nonatomic, strong) MedicalVideoGroupDetailEntryModel* groupDetail;
@property (nonatomic, strong) NSArray<MedicalVideoEntryModel*>* otherVideoModels;   //其他人也在看

@property (nonatomic, strong) UIView* tableHeaderView;

@end

@implementation MedicalVideoDetailViewController
@synthesize playerModel = _playerModel;

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
   // [self setFd_interactivePopDisabled:YES];
    
    self.tableview.mj_header = nil;
    [self startLoadVideoGroupDetal];
    [self startLoadGroupOtherVideos];
    
    self.tableview.tableHeaderView = self.tableHeaderView;
    [self.tableview registerClass:[MedicalVideoDetailTitleTableViewCell class] forCellReuseIdentifier:[MedicalVideoDetailTitleTableViewCell cellReuseIdentifier]];
    [self.tableview registerClass:[MedicalVideoDetailDirectoryTableViewCell class] forCellReuseIdentifier:[MedicalVideoDetailDirectoryTableViewCell cellReuseIdentifier]];
    [self.tableview registerClass:[MedicalVideoDetailCircleTableViewCell class] forCellReuseIdentifier:[MedicalVideoDetailCircleTableViewCell cellReuseIdentifier]];
    [self.tableview registerClass:[MedicalVideoGroupOtherVideoTableViewCell class] forCellReuseIdentifier:[MedicalVideoGroupOtherVideoTableViewCell cellReuseIdentifier]];
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
        //headerHeight -= Status_Height;
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
            [weakSelf videoGroupDetailLoaded];
        }
    } complete:^(NSInteger code, NSString *message) {
        [MessageHubUtil hideMessage];
        SAFE_WEAKSELF(weakSelf)
        if (code != 0) {
            [MessageHubUtil showErrorMessage:message];
        }
    }];
}

- (void) videoGroupDetailLoaded{
    if (!self.groupDetail.currentMedicalVideoItem) {
        return;
    }
    _playerModel = [[VideoPlayerModel alloc] init];

    self.playerModel.title = self.groupDetail.currentMedicalVideoItem.title;
    self.playerModel.startPosition = self.groupDetail.currentMedicalVideoItem.currentTime;
    //默认播放地址
    self.playerModel.playerUrl = self.groupDetail.currentMedicalVideoItem.hdUrl;
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    if (manager.networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWWAN) { //非wifi
        self.playerModel.playerUrl = self.groupDetail.currentMedicalVideoItem.hdUrl;
    }
    //初始化播放器
    [[VideoPlayerUtil shareInstance] setupPlayerModel:self.playerModel];
}

- (void) startLoadGroupOtherVideos{
    WS(weakSelf)
    [MedicalVideoListBussiness startLoadMedicalGroupOthersVideos:self.groupId sresult:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if ([result isKindOfClass:[MedicalVideoGroupInfoListModel class]]) {
            MedicalVideoGroupInfoListModel* listModel = (MedicalVideoGroupInfoListModel*) result;
            weakSelf.otherVideoModels = listModel.content;
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
        case GroupCircleSection:{
            if (self.groupDetail) {
                return 1;
            }
            break;
        }
        case GroupOthersSection:{
            if (self.otherVideoModels) {
                return self.otherVideoModels.count;
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
        case GroupCircleSection:{
            return [MedicalVideoDetailCircleTableViewCell class];
            break;
        }
        case GroupOthersSection:{
            return [MedicalVideoGroupOtherVideoTableViewCell class];
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
            directoryeCell.delegate = self;
            break;
        }
        case GroupCircleSection:{
            MedicalVideoDetailCircleTableViewCell* circleCell = (MedicalVideoDetailCircleTableViewCell*) cell;
            [circleCell setEntryModel:self.groupDetail.circleInfo];
            break;
        }
        case GroupOthersSection:{
            MedicalVideoGroupOtherVideoTableViewCell* videoCell = (MedicalVideoGroupOtherVideoTableViewCell*) cell;
            [videoCell setEntryModel:self.otherVideoModels[indexPath.row]];
            break;
        }
        default:
            break;
    }
    
    return cell;
}

#pragma mark - table view delegate
- (CGFloat) headerViewHeight:(NSInteger) section {
    switch (section) {
        case GroupOthersSection:{
            return 60.;
            break;
        }
        default:
            break;
    }
    return 0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [self headerViewHeight:section];
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGFloat tableWidth = kScreenWidth;
    if ([UIDevice currentDevice].isPad) {
        tableWidth = kScreenWidth * 0.7;
    }
    CGFloat headerHeight = [self headerViewHeight:section];
    if (headerHeight == 0) {
        return nil;
    }
    UIView* headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableWidth, [self headerViewHeight:section])];
    headerview.backgroundColor = [UIColor whiteColor];
    switch (section) {
        case GroupOthersSection:{
            UILabel* titleLabel = [headerview addLabel:[UIColor commonTextColor] textSize:16];
            titleLabel.text = @"看了本视频的人也在学";
            titleLabel.font = [UIFont boldSystemFontOfSize:16];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(headerview);
                make.left.equalTo(headerview).offset(15.);
            }];
            break;
        }
        default:
            break;
    }
    return headerview;
}

#pragma mark table view footer view
- (CGFloat) footerViewHeight:(NSInteger) section{
    switch (section) {
        case GroupDirectorySection:
        case GroupCircleSection:
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

#pragma mark  MedicalVideoDirectoryDelegate
- (void) medicalVideoDirectoryChanged:(NSInteger) index{
    if (index == self.groupDetail.currentPlayIndex) {
        return;
    }
    
    self.groupDetail.medicalVideoItems[self.groupDetail.currentPlayIndex].currentTime = self.playerModel.startPosition;
    
    self.groupDetail.currentPlayIndex = index;
    self.groupDetail.currentMedicalVideoItem = self.groupDetail.medicalVideoItems[index];
    
    //重新初始化播放器
    
    _playerModel = [[VideoPlayerModel alloc] init];

    self.playerModel.title = self.groupDetail.currentMedicalVideoItem.title;
    self.playerModel.startPosition = self.groupDetail.currentMedicalVideoItem.currentTime;
    //默认播放地址
    self.playerModel.playerUrl = self.groupDetail.currentMedicalVideoItem.hdUrl;
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    if (manager.networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWWAN) { //非wifi
        self.playerModel.playerUrl = self.groupDetail.currentMedicalVideoItem.hdUrl;
    }
    //初始化播放器
    
    [[VideoPlayerUtil shareInstance] setupPlayerModel:self.playerModel];
}

@end
