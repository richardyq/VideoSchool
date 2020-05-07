//
//  MeetingLivingViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/6.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingLivingViewController.h"
#import "MeetingBussiness.h"
#import "MeetingTitleTableViewCell.h"
#import "MeetingWatchCountTableViewCell.h"
#import "MeetingLivingConferenceTableViewCell.h"
#import "MeetingScheduleTableViewCell.h"
#import "MeetingLivingSummaryTableViewCell.h"

typedef NS_ENUM(NSUInteger, MeetingLivingTableSection) {
    Title_Section,
    WatchNumber_Section,
    Conference_Section,
    Schedule_Section,
    Summay_Section,
    SectionCount,
};

@interface MeetingLivingViewController ()
<UITableViewDelegate>

@property (nonatomic, strong) MeetingConferenceModel* playingConference;
@end

@implementation MeetingLivingViewController
@synthesize playerView = _playerView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.playingConference = self.meetingDetail.conferenceInfos.firstObject;
    [self.tableview registerClass:[MeetingTitleTableViewCell class] forCellReuseIdentifier:[MeetingTitleTableViewCell cellReuseIdentifier]];
    [self.tableview registerClass:[MeetingWatchCountTableViewCell class] forCellReuseIdentifier:[MeetingWatchCountTableViewCell cellReuseIdentifier]];
    [self.tableview registerClass:[MeetingLivingConferenceTableViewCell class] forCellReuseIdentifier:[MeetingLivingConferenceTableViewCell cellReuseIdentifier]];
    [self.tableview registerClass:[MeetingScheduleTableViewCell class] forCellReuseIdentifier:[MeetingScheduleTableViewCell cellReuseIdentifier]];
    [self.tableview registerClass:[MeetingLivingSummaryTableViewCell class] forCellReuseIdentifier:[MeetingLivingSummaryTableViewCell cellReuseIdentifier]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(meetingContentLoaded:) name:MeetingDetailContentLoadedNotification object:nil];
    
    [self startPlayMeeting];
}

- (void) makeParamDictionary{
    //TODO:构建特定参数
    [self.paramDictionary setValue:@(self.meetingDetail.id) forKey:@"meetingId"];
}

- (VideoPlayerView*) playerView{
    if (!_playerView) {
        _playerView = (VideoPlayerView*)[self.view addView:[LivePlayerView class]];
        _playerView.controlDelegate = self;
    }
    return _playerView;
}

- (Class) fullPlayerViewControllerClass{
    return [LiveFullPlayerViewController class];
}

#pragma mark - table view data source
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return SectionCount;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case Title_Section:
        case WatchNumber_Section:
            return 1;
        case Conference_Section:{
            return self.meetingDetail.conferenceInfos.count;
            break;
        }
        
        case Schedule_Section:{
            if (self.meetingDetail.schedule && [self.meetingDetail.schedule isNotBlank]) {
                return 1;
            }
            break;
        }
        case Summay_Section:{
            if (self.meetingDetail.summary && [self.meetingDetail.summary isNotBlank]) {
                return 1;
            }
            break;
        }
    }
    
    return 0;
}

- (Class) tableViewCellClass:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case Title_Section:{
            return [MeetingTitleTableViewCell class];
            break;
        }
        case WatchNumber_Section:{
            return [MeetingWatchCountTableViewCell class];
            break;
        }
        case Conference_Section:{
            return [MeetingLivingConferenceTableViewCell class];
            break;
        }
        case Schedule_Section:{
            return [MeetingScheduleTableViewCell class];
            break;
        }
        case Summay_Section:{
                return [MeetingLivingSummaryTableViewCell class];
                break;
            }
        default:
        break;
    }
     return [VHTableViewCell class];
}

- (EntryModel*) entryModel:(NSIndexPath*) indexPath{
    switch (indexPath.section) {
        case Title_Section:{
            return self.meetingDetail;
            break;
        }
        case WatchNumber_Section:{
            return self.meetingDetail;
            break;
        }
        case Conference_Section:{
            return self.meetingDetail.conferenceInfos[indexPath.row];
            break;
        }
        case Schedule_Section:
        case Summay_Section:{
            return self.meetingDetail;
            break;
        }
    default:
        break;
            
    }
    return nil;
}

- (void) meetingContentLoaded:(NSNotification*) notification{
    [self.tableview reloadData];
}

#pragma mark - table view delegate
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    switch (section) {
        case WatchNumber_Section:
        case Conference_Section:{
            return 7.5;
            break;
        }
        case Schedule_Section:{
            if (self.meetingDetail.schedule && [self.meetingDetail.schedule isNotBlank]) {
                return 7.5;
            }
            break;
        }
        case Summay_Section:{
            if (self.meetingDetail.summary && [self.meetingDetail.summary isNotBlank]) {
                return 7.5;
            }
            break;
        }
            
        default:
            break;
    }
    return 0;
}

- (UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView* footerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.width, 7.5)];
    footerview.backgroundColor = [UIColor commonBackgroundColor];
    return footerview;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case Conference_Section:{
            return 45.;
            break;
        }
        default:
            break;
    }
    return 0;
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    switch (section) {
        case Conference_Section:{
            UIView* headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.width, 45)];
            headerview.backgroundColor = [UIColor commonBackgroundColor];
            UILabel* nameLabel = [headerview addLabel:[UIColor commonTextColor] textSize:15 weight:UIFontWeightMedium];
            [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(headerview);
                make.left.equalTo(headerview).offset(10);
            }];
            nameLabel.text = @"会议直播";
            
            UIButton* refeshButton = [headerview addButtonWithImageName:@"ic_refresh"];
            [refeshButton setTitle:@" 刷新" forState:UIControlStateNormal];
            [refeshButton setTitleColor:[UIColor mainThemeColor] forState:UIControlStateNormal];
            refeshButton.titleLabel.font = [UIFont systemFontOfSize:12];
            
            [refeshButton mas_makeConstraints:^(MASConstraintMaker *make) {
                //make.size.mas_equalTo(CGSizeMake(25, 25));
                make.centerY.equalTo(headerview);
                make.right.equalTo(headerview).offset(-10);
            }];
            
            WS(weakSelf)
            [refeshButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                SAFE_WEAKSELF(weakSelf)
                [weakSelf refreshMeetingDetail];
            }];
            return headerview;
            break;
        }
        default:
            break;
    }
    return nil;
}

- (VHTableViewCell*) tableViewCell:(Class) class indexPath:(NSIndexPath*) indexPath{
    
    VHTableViewCell* cell = [super tableViewCell:class indexPath:indexPath];
    
    switch (indexPath.section) {
        case Conference_Section:{
            MeetingLivingConferenceTableViewCell* conferenceCell = (MeetingLivingConferenceTableViewCell*) cell;
            MeetingConferenceModel* conference = self.meetingDetail.conferenceInfos[indexPath.row];
            BOOL isPlaying = (self.playingConference.id == conference.id);
            [conferenceCell setIsPlaying:isPlaying];
            break;
        }
        default:
            break;
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case Conference_Section:{
            MeetingConferenceModel* conference = self.meetingDetail.conferenceInfos[indexPath.row];
            if (conference == self.playingConference) {
                return;
            }
            
            if ([conference.statusCode isEqualToString:@"04"] || [conference.statusCode isEqualToString:@"05"]) {
                [MessageHubUtil showMessage:@"本场直播已结束！"];
                return;
            }
            
            self.playingConference = conference;
            [self.tableview reloadData];
            
            [self startPlayMeeting];
            break;
        }
        default:
            break;
    }
}

#pragma mark - 播放直播
- (void) startPlayMeeting{
    if (!self.playingConference) {
        return;
    }
    self.playerModel.title = self.playingConference.title;
    //self.playerModel.startPosition = self.playingConference.currentTime;
    //默认播放地址
    self.playerModel.playerUrl = self.playingConference.originalMuUrl;
    LivePlayerView* livePlayerView = (LivePlayerView*) self.playerView;
    if ([self.playingConference.statusCode isEqualToString:@"02"]) {
        [livePlayerView setStatusText:@"直播"];
    }
    else if ([self.playingConference.statusCode isEqualToString:@"03"]){
        [livePlayerView setStatusText:@"休息"];
        //茶歇视频
        self.playerModel.playerUrl = self.playingConference.breakHdUrl;
    }
    
    //初始化播放器
    [[VideoPlayerUtil shareInstance] setupPlayerModel:self.playerModel];
}

- (void) setupFullPlayerViewController{
    __block VideoFullPlayerViewController* fullController = nil;
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull controller, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([controller isKindOfClass:[VideoFullPlayerViewController class]] ||
            [controller isMemberOfClass:[VideoFullPlayerViewController class]]) {
            fullController = controller;
            *stop = YES;
        }
    }];
    
    LivePlayerView* livePlayerView = (LivePlayerView*) fullController.playerView;
    if ([self.playingConference.statusCode isEqualToString:@"02"]) {
        [livePlayerView setStatusText:@"直播"];
    }
    else if ([self.playingConference.statusCode isEqualToString:@"03"]){
        [livePlayerView setStatusText:@"休息"];
        //茶歇视频
        self.playerModel.playerUrl = self.playingConference.breakHdUrl;
    }
}

#pragma mark 刷新会场信息
- (void) refreshMeetingDetail{
    WS(weakSelf)
    [MessageHubUtil showWait];
    [MeetingBussiness startLoadMeetingDetail:self.meetingDetail.id result:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if ([result isKindOfClass:[MeetingDetailModel class]]) {
            weakSelf.meetingDetail = result;
        }
    } complete:^(NSInteger code, NSString *message) {
        [MessageHubUtil hideMessage];
        SAFE_WEAKSELF(weakSelf)
        if (code != 0) {
            [MessageHubUtil showErrorMessage:message];
            return;
        }
        [weakSelf.tableview reloadData];
    }];
}
@end
