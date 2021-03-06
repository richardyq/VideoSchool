//
//  MeetingStartViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/24.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingStartViewController.h"
#import "MeetingGatherEntryModel.h"
#import "MeetingPreviewGatherModel.h"
#import "MeetingBussiness.h"
#import "MeetingEntryModel.h"
#import "MeetingInfoListTableViewCell.h"
#import "MeetingPreviewTableViewCell.h"
#import "MeetingFavoriteTableViewCell.h"
#import "SubjectEntryModel.h"
#import "MeetingPageRouter.h"

typedef NS_ENUM(NSUInteger, EMeetingTableSection) {
    MeetingLivingSection,
    MeetingPreviewSection,
    MeetingReplayHeaderSection,
    MeetingFavoriteSection,
    MeetingReplaySection,
    SectionCount,
};

@interface MeetingStartViewController ()
<UITableViewDataSource, UITableViewDelegate>
//会议总览信息
@property (nonatomic, strong) MeetingGatherEntryModel* gatherEntryModel;
//直播会议列表
@property (nonatomic, strong) NSMutableArray<MeetingEntryModel*>* liveMeetings;

@property (nonatomic, strong) MeetingPreviewGatherModel* previewMeetingGather;

@property (nonatomic, strong) NSArray<SubjectEntryModel*>* favorites;
//@property (nonatomic, strong) SegmentView* favoriteSegmentView;

@end

@implementation MeetingStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"会议视频";
    [self.tableview registerClass:[MeetingInfoListTableViewCell class] forCellReuseIdentifier:[MeetingInfoListTableViewCell cellReuseIdentifier]];
    [self.tableview registerClass:[MeetingPreviewTableViewCell class] forCellReuseIdentifier:[MeetingPreviewTableViewCell cellReuseIdentifier]];
    [self.tableview registerClass:[MeetingFavoriteTableViewCell class] forCellReuseIdentifier:[MeetingFavoriteTableViewCell cellReuseIdentifier]];
    
    [self startLoadMeetingGather];
    //[self startLoadLiveMeetings];
    
    [self refreshDataCommand];
    
    self.tableview.mj_header = nil;
}

#pragma mark - 加载数据

- (void) refreshDataCommand{
    [self startLoadLiveMeetings];
    [self startLoadPreviewMeetings];
    [self startLoadReplayFavorites];
}

- (void) loadMoreDataCommand{
    //SubjectEntryModel* subject = self.favorites.firstObject;
    [self startLoadReplayMeetingList:@"00" pageNo:self.pageNo + 1];
}

//获取会议总览信息
- (void) startLoadMeetingGather{
    //[MessageHubUtil showWait];
    WS(weakSelf)
    [MeetingBussiness startLoadMeetingGather:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if ([result isKindOfClass:[MeetingGatherEntryModel class]]) {
            [weakSelf gatherModelLoaded:result];
        }
    } complete:^(NSInteger code, NSString *message) {
        //[MessageHubUtil hideMessage];
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
    [MeetingBussiness startLoadLiveMeetingList:1 pageSize:10 result:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if ([result isKindOfClass:[MeetingListModel class]]) {
            [weakSelf liveMeetingsLoaded:result];
        }
    } complete:^(NSInteger code, NSString *message) {
        SAFE_WEAKSELF(weakSelf)
        weakSelf.errorMessage = nil;
        if (code != 0) {
            //[MessageHubUtil showErrorMessage:message];
            weakSelf.errorMessage = message;
            
        }
        [weakSelf refreshCommandEnd:self.pageNo totalPage:self.totalPages];
    }];
}

- (void) liveMeetingsLoaded:(MeetingListModel*) listModel{
    [self.liveMeetings removeAllObjects];
    [self.liveMeetings addObjectsFromArray:listModel.content];
}

- (void) refreshCommandEnd:(NSInteger)pageNo totalPage:(NSInteger)totalPage{
    [super refreshCommandEnd:pageNo totalPage:totalPage];
    //self.tableview.mj_header = nil;
}

//获取会议预告列表
- (void) startLoadPreviewMeetings{
    WS(weakSelf)
    [MeetingBussiness startLoadPreviewMeetingGather:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if ([result isKindOfClass:[MeetingPreviewGatherModel class]]) {
            [weakSelf previewMeetingsLoaded:result];
        }
    } complete:^(NSInteger code, NSString *message) {
        SAFE_WEAKSELF(weakSelf)
        self.errorMessage = nil;
        if (weakSelf != 0) {
            //[MessageHubUtil showErrorMessage:message];
            weakSelf.errorMessage = message;
            
        }
        [weakSelf refreshCommandEnd:self.pageNo totalPage:self.totalPages];
    }];
}

- (void) previewMeetingsLoaded:(MeetingPreviewGatherModel*) gatherModel{
    self.previewMeetingGather = gatherModel;
}

//回放兴趣
- (void) startLoadReplayFavorites{
    WS(weakSelf)
    [MeetingBussiness startLoadReplayFavoriteList:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if ([result isKindOfClass:[NSArray class]]) {
            [weakSelf replayFavoriatesLoaded:result];
        }
    } complete:^(NSInteger code, NSString *message) {
        SAFE_WEAKSELF(weakSelf)
        self.errorMessage = nil;
        if (weakSelf != 0) {
            //[MessageHubUtil showErrorMessage:message];
            weakSelf.errorMessage = message;
            
        }
        [weakSelf refreshCommandEnd:self.pageNo totalPage:self.totalPages];
    
        //获取回放列表
        weakSelf.pageNo = 1;
        //SubjectEntryModel* subject = weakSelf.favorites.firstObject;
        
        [weakSelf startLoadReplayMeetingList:@"00" pageNo:weakSelf.pageNo];
    }];
}

- (void) replayFavoriatesLoaded:(NSArray*) favorites{
    self.favorites = favorites;
    
    NSArray<NSString*>* names = [favorites valueForKey:@"name"];
    [self.tableview reloadData];
}

//回放列表
- (void) startLoadReplayMeetingList:(NSString*) subjectCode pageNo:(NSInteger) pageNo{
    WS(weakSelf)
    [MeetingBussiness startLoadReplayMeetingList:subjectCode pageNo:pageNo pageSize:10 result:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if ([result isKindOfClass:[MeetingListModel class]]) {
            [weakSelf replayMeetingsLoaded:result];
        }
    } complete:^(NSInteger code, NSString *message) {
        SAFE_WEAKSELF(weakSelf)
        self.errorMessage = nil;
        if (weakSelf != 0) {
            //[MessageHubUtil showErrorMessage:message];
            weakSelf.errorMessage = message;
            
        }
        [weakSelf refreshCommandEnd:self.pageNo totalPage:self.totalPages];
    }];
}

- (void) replayMeetingsLoaded:(MeetingListModel*) meetingList{
    self.pageNo = meetingList.pageNo;
    self.totalPages = meetingList.pageSize;
    if (meetingList.pageNo == 1) {
        [self.models removeAllObjects];
    }
    
    [self.models addObjectsFromArray:meetingList.content];
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
            if (self.previewMeetingGather &&
                self.previewMeetingGather.count > 0) {
                return 1;
            }
            return 0;
            break;
        }
        case MeetingReplayHeaderSection:{
            return 0;
            break;
        }
        case MeetingFavoriteSection:{
            if (self.favorites &&
                self.favorites.count > 0) {
                return 1;
            }
            return 0;
            break;
        }
        case MeetingReplaySection:{
            return self.models.count;
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
        case MeetingPreviewSection:{
            cell = [[MeetingPreviewTableViewCell alloc] initWithMeetingGather:self.previewMeetingGather];
            break;
        }
        case MeetingFavoriteSection:{
            cell = [[MeetingFavoriteTableViewCell alloc] initWithCategories:self.favorites];
            break;
        }
        case MeetingReplaySection:{
            cell = [self.tableview dequeueReusableCellWithIdentifier:[MeetingInfoListTableViewCell cellReuseIdentifier]];
                [cell setEntryModel:self.models[indexPath.row]];
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
    switch (section) {
        case MeetingLivingSection:{
            if (self.liveMeetings.count > 0) {
                return 47.;
            }
            break;
        }
        case MeetingPreviewSection:{
            if (self.previewMeetingGather &&
                self.previewMeetingGather.count > 0) {
                return 47.;
            }
            break;
        }
        case MeetingReplayHeaderSection:{
            if (self.favorites &&
                self.favorites > 0) {
                return 47.;
            }
            break;
        }
            
        default:
            break;
    }
    return 0.;
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* headerview= [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.width, 47.)];
    headerview.backgroundColor = [UIColor commonBackgroundColor];
    
    UILabel* titleLabel = [headerview addLabel:[UIColor commonTextColor] textSize:16 weight:UIFontWeightMedium];
    switch (section) {
        case MeetingLivingSection:{
            titleLabel.text = @"会议直播";
            break;
        }
        case MeetingPreviewSection:{
            titleLabel.text = @"会议预告";
            break;
        }
        case MeetingReplayHeaderSection:{
            titleLabel.text = @"会议视频";
            break;
        }
        
        default:
            break;
    }
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerview);
        make.left.equalTo(headerview).offset(15);
    }];
    return headerview;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case MeetingLivingSection:{
            MeetingEntryModel* meeting = self.liveMeetings[indexPath.row];
            [MeetingPageRouter entryMeetingDatailPage:meeting.id];
            break;
        }
        case MeetingReplaySection:{
            MeetingEntryModel* meeting = self.models[indexPath.row];
            [MeetingPageRouter entryMeetingDatailPage:meeting.id];
            break;
        }
        default:
            break;
    }
}

- (NSString*) emptyTableText{
    return @"暂无会议数据";
}
@end
