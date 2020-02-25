//
//  MeetingStartViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/24.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingStartViewController.h"
#import "MeetingGatherEntryModel.h"
#import "MeetingBussiness.h"
#import "MeetingEntryModel.h"
#import "MeetingInfoListTableViewCell.h"

typedef NS_ENUM(NSUInteger, EMeetingTableSection) {
    MeetingLivingSection,
    MeetingPreviewSection,
    MeetingReplaySection,
    SectionCount,
};

@interface MeetingStartViewController ()
<UITableViewDataSource>
//会议总览信息
@property (nonatomic, strong) MeetingGatherEntryModel* gatherEntryModel;
//直播会议列表
@property (nonatomic, strong) NSMutableArray<MeetingEntryModel*>* liveMeetings;
@end

@implementation MeetingStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"学术会议";
    [self.tableview registerClass:[MeetingInfoListTableViewCell class] forCellReuseIdentifier:[MeetingInfoListTableViewCell cellReuseIdentifier]];
    [self startLoadMeetingGather];
    [self startLoadLiveMeetings];
}

#pragma mark - 加载数据
//获取会议总览信息
- (void) startLoadMeetingGather{
    [MessageHubUtil showWait];
    WS(weakSelf)
    [MeetingBussiness startLoadMeetingGather:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if ([result isKindOfClass:[MeetingGatherEntryModel class]]) {
            [weakSelf gatherModelLoaded:result];
        }
    } complete:^(NSInteger code, NSString *message) {
        [MessageHubUtil hideMessage];
        if (code != 0) {
            [MessageHubUtil showErrorMessage:message];
        }
        SAFE_WEAKSELF(weakSelf)
    }];
}

- (void) gatherModelLoaded:(MeetingGatherEntryModel*) gatherModel{
    _gatherEntryModel = gatherModel;
    
}

//获取会议直播列表
- (void) startLoadLiveMeetings{
    WS(weakSelf)
    [MeetingBussiness startLoadLiveMeetingList:1 pageSize:5 result:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if ([result isKindOfClass:[MeetingListModel class]]) {
            [weakSelf liveMeetingsLoaded:result];
        }
    } complete:^(NSInteger code, NSString *message) {
        if (code != 0) {
            [MessageHubUtil showErrorMessage:message];
        }
    }];
}

- (void) liveMeetingsLoaded:(MeetingListModel*) listModel{
    [self.liveMeetings removeAllObjects];
    [self.liveMeetings addObjectsFromArray:listModel.content];
    
    [self.tableview reloadData];
}

#pragma mark - settingAndGetting
- (NSMutableArray<MeetingEntryModel*>*) liveMeetings{
    if (!_liveMeetings) {
        _liveMeetings = [NSMutableArray<MeetingEntryModel*> array];
    }
    return _liveMeetings;
}

#pragma mark - table view data source
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return SectionCount;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case MeetingLivingSection:{
            return self.liveMeetings.count;
            break;
        }
        case MeetingPreviewSection:{
            return 0;
            break;
        }
        case MeetingReplaySection:{
            return 0;
            break;
        }
        default:
            break;
    }
    return 0;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VHTableViewCell* cell = [self.tableview dequeueReusableCellWithIdentifier:[VHTableViewCell cellReuseIdentifier]];
    
    switch (indexPath.section) {
        case MeetingLivingSection:{
            cell = [self.tableview dequeueReusableCellWithIdentifier:[MeetingInfoListTableViewCell cellReuseIdentifier]];
            [cell setEntryModel:self.liveMeetings[indexPath.row]];
            break;
        }
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
