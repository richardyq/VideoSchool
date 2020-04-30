//
//  MeetingReplayViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/30.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingReplayViewController.h"
#import "MeetingTitleTableViewCell.h"
#import "MeetingSummaryTableViewCell.h"
#import "MeetingConferenceTableViewCell.h"
#import "MeetingBussiness.h"
#import "MeetingInfoListTableViewCell.h"

typedef NS_ENUM(NSUInteger, MeetingReplayTableSection) {
    Title_Section,
    Summary_Section,
    Conference_Section,
    Recommand_Section,  
    SectionCount,
};

@interface MeetingReplayViewController ()
<UITableViewDataSource>

@property (nonatomic, strong) NSString* subjectCode;
@end

@implementation MeetingReplayViewController

@synthesize playerModel = _playerModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableview registerClass:[MeetingTitleTableViewCell class] forCellReuseIdentifier:[MeetingTitleTableViewCell cellReuseIdentifier]];
    [self.tableview registerClass:[MeetingSummaryTableViewCell class] forCellReuseIdentifier:[MeetingSummaryTableViewCell cellReuseIdentifier]];
    [self.tableview registerClass:[MeetingConferenceTableViewCell class] forCellReuseIdentifier:[MeetingConferenceTableViewCell cellReuseIdentifier]];
    [self.tableview registerClass:[MeetingInfoListTableViewCell class] forCellReuseIdentifier:[MeetingInfoListTableViewCell cellReuseIdentifier]];

    [self startLoadMeetingReplayDetail];
}

- (void) makeParamDictionary{
    //TODO:构建特定参数
    [self.paramDictionary setValue:@(self.meetingDetail.id) forKey:@"meetingId"];
}

#pragma mark - 获取网络数据
- (void) startLoadMeetingReplayDetail{
    WS(weakSelf)
    [MeetingBussiness startLoadMeetingReplayDetail:self.meetingDetail.id result:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if ([result isKindOfClass:[MeetingDetailModel class]]) {
            weakSelf.meetingDetail = result;
            weakSelf.subjectCode = @"00";
        }
    } complete:^(NSInteger code, NSString *message) {
        SAFE_WEAKSELF(weakSelf)
        if (code == 0) {
            [weakSelf.tableview reloadData];
            [weakSelf startLoadRecommandMeetings];
            [weakSelf replayDetailLoaded];
        }
    }];
}

- (void) replayDetailLoaded{
    _playerModel = [[VideoPlayerModel alloc] init];

    self.playerModel.title = self.meetingDetail.currentVideo.title;
    self.playerModel.startPosition = self.meetingDetail.currentVideo.currentTime;
       //默认播放地址
    self.playerModel.playerUrl = self.meetingDetail.currentVideo.hdUrl;
    
    //初始化播放器
    [[VideoPlayerUtil shareInstance] setupPlayerModel:self.playerModel];
}

- (void) startLoadRecommandMeetings{
    WS(weakSelf)
    [MeetingBussiness startLoadReplayMeetingList:self.subjectCode pageNo:1 pageSize:5 result:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if ([result isKindOfClass:[MeetingListModel class]]) {
            MeetingListModel* listModel = (MeetingListModel*) result;
            weakSelf.models = listModel.content;
        }
    } complete:^(NSInteger code, NSString *message) {
        SAFE_WEAKSELF(weakSelf)
        //self.errorMessage = nil;
        if (weakSelf != 0) {
            //[MessageHubUtil showErrorMessage:message];
            weakSelf.errorMessage = message;
            
        }
        [weakSelf refreshCommandEnd:self.pageNo totalPage:self.totalPages];
    }];
}

#pragma mark - table view data source
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return SectionCount;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case Title_Section:
        case Summary_Section:
            return 1;
            break;
        case Conference_Section:{
            return self.meetingDetail.conferenceInfos.count;
            break;
        }
        case Recommand_Section:{
            return self.models.count;
            break;
        }
        default:
            break;
    }
    return 0;
}

- (Class) tableViewCellClass:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case Title_Section:{
            return [MeetingTitleTableViewCell class];
            break;
        }
        case Summary_Section:{
            return [MeetingSummaryTableViewCell class];
            break;
        }
        case Conference_Section:{
            return [MeetingConferenceTableViewCell class];
            break;
        }
        case Recommand_Section:{
            return [MeetingInfoListTableViewCell class];
            break;
        }
        default:
            break;
    }
    return [VHTableViewCell class];
}

- (EntryModel*) entryModel:(NSIndexPath*) indexPath{
    switch (indexPath.section) {
        case Title_Section:
        case Summary_Section:{
            return self.meetingDetail;
            break;
        }
        
        default:
            break;
    }
    
    if (self.models.count > 0 && self.models.count > indexPath.row) {
        return self.models[indexPath.row];
    }
    return nil;
}

- (VHTableViewCell*) tableViewCell:(Class) class indexPath:(NSIndexPath*) indexPath{
    VHTableViewCell* cell = [super tableViewCell:class indexPath:indexPath];
    switch (indexPath.section) {
        case Conference_Section:{
            cell = [[MeetingConferenceTableViewCell alloc] initWithConferense:self.meetingDetail.conferenceInfos[indexPath.row]];
            break;
        }
        default:
            break;
    }
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case Recommand_Section:{
            if (self.models.count > 0) {
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
    headerview.backgroundColor = [UIColor whiteColor];

    UILabel* titleLabel = [headerview addLabel:[UIColor commonTextColor] textSize:16 weight:UIFontWeightMedium];
    switch (section) {
        case Recommand_Section:{
            titleLabel.text = @"精彩推荐";
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
@end
