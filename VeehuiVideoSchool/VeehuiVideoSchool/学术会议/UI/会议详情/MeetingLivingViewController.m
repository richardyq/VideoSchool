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

- (VHTableViewCell*) tableViewCell:(Class) class indexPath:(NSIndexPath*) indexPath{
    
    VHTableViewCell* cell = [super tableViewCell:class indexPath:indexPath];
    
    switch (indexPath.section) {
        case Conference_Section:{
            MeetingLivingConferenceTableViewCell* conferenceCell = (MeetingLivingConferenceTableViewCell*) cell;
            MeetingConferenceModel* conference = self.meetingDetail.conferenceInfos[indexPath.row];
            BOOL isPlaying = (self.playingConference == conference);
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
@end
