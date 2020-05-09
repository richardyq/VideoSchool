//
//  MeetingPreviewDetailViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/8.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingPreviewDetailViewController.h"
#import "MeetingPreviewDetailImageTableViewCell.h"
#import "MeetingPreviewDetailCountdownTableViewCell.h"
#import "MeetingScheduleTableViewCell.h"
#import "MeetingLivingSummaryTableViewCell.h"
#import "MeetingDetailModel.h"
#import "MeetingBussiness.h"
#import "MeetingPageRouter.h"

typedef NS_ENUM(NSUInteger, PreviewDetailSection) {
    PictureImage_Section,
    Countdown_Section,
    Summay_Section,
    Schedule_Section,
    SectionCount,
};

@interface MeetingPreviewDetailViewController ()

@property (nonatomic, strong) MeetingDetailModel* meetingDetail;
@property (nonatomic, strong) UIView* appointView;

@property (nonatomic, strong) UIButton* appintButton;
@property (nonatomic, strong) UIButton* applyButton;    //报名

@end

@implementation MeetingPreviewDetailViewController

- (id) initWithMeetingDetail:(MeetingDetailModel*) detail{
    self = [super init];
    if (self) {
        _meetingDetail = detail;
    }
    return self;
}

- (void) makeParamDictionary{
    //TODO:构建特定参数
    [self.paramDictionary setValue:@(self.meetingDetail.id) forKey:@"meetingId"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"会议预告";
    self.tableview.mj_header = nil;
    
    [self.tableview registerClass:[MeetingPreviewDetailImageTableViewCell class] forCellReuseIdentifier:[MeetingPreviewDetailImageTableViewCell cellReuseIdentifier]];
    [self.tableview registerClass:[MeetingPreviewDetailCountdownTableViewCell class] forCellReuseIdentifier:[MeetingPreviewDetailCountdownTableViewCell cellReuseIdentifier]];
    [self.tableview registerClass:[MeetingScheduleTableViewCell class] forCellReuseIdentifier:[MeetingScheduleTableViewCell cellReuseIdentifier]];
    [self.tableview registerClass:[MeetingLivingSummaryTableViewCell class] forCellReuseIdentifier:[MeetingLivingSummaryTableViewCell cellReuseIdentifier]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(meetingContentLoaded:) name:MeetingDetailContentLoadedNotification object:nil];
    
    [self setupAppointButton];
}

- (void) updateViewConstraints{
    [super updateViewConstraints];
    
    __block CGFloat tableWidth = kScreenWidth;
    if ([UIDevice currentDevice].isPad) {
        tableWidth *= 0.7;
    }
    
    [self.appointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(tableWidth);
        make.height.mas_equalTo(@(PhoneXBottom + 49));
        make.bottom.equalTo(self.view);
    }];
    
    [self.applyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.appointView);
    }];
    
    [self.appintButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.applyButton.mas_right);
        make.right.top.bottom.equalTo(self.appointView);
        make.width.equalTo(self.applyButton).multipliedBy(2.);
    }];
    
    [self.tableview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(tableWidth);
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.appointView.mas_top);
    }];
}

#pragma mark - settingAndGetting
- (UIView*) appointView{
    if (!_appointView) {
        _appointView = [self.view addView];
    }
    return _appointView;
}

- (UIButton*) applyButton{
    if (!_applyButton) {
        _applyButton = [self.appointView addButton:UIButtonTypeCustom];
        [_applyButton setTitle:@"参会报名" forState:UIControlStateNormal];
        [_applyButton setBackgroundImage:[UIImage rectImage:[UIColor colorWithHexString:@"2F8ED3"] size:CGSizeMake(150, 75)] forState:UIControlStateNormal];
        [_applyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _applyButton.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [_applyButton addTarget:self action:@selector(applyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _applyButton;
}

- (UIButton*) appintButton{
    if (!_appintButton) {
        _appintButton = [self.appointView addButton:UIButtonTypeCustom];
        [_appintButton setTitle:@"预约看直播，不错过每一刻精彩" forState:UIControlStateNormal];
        [_appintButton setBackgroundImage:[UIImage rectImage:[UIColor mainThemeColor] size:CGSizeMake(300, 75)] forState:UIControlStateNormal];
        [_appintButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _appintButton.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [_appintButton addTarget:self action:@selector(appointButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _appintButton;
}

- (void) setupAppointButton{
    if (self.meetingDetail.isAppointment) {
        [self.appintButton setTitle:@"已成功预约，请注意直播提醒" forState:UIControlStateNormal];
        [self.appintButton setBackgroundImage:[UIImage rectImage:[UIColor colorWithHexString:@"2FD38E"] size:CGSizeMake(300, 75)] forState:UIControlStateNormal];
        [self.appintButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.appintButton.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    else{
        [self.appintButton setTitle:@"预约看直播，不错过每一刻精彩" forState:UIControlStateNormal];
        [self.appintButton setBackgroundImage:[UIImage rectImage:[UIColor mainThemeColor] size:CGSizeMake(300, 75)] forState:UIControlStateNormal];
        [self.appintButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.appintButton.titleLabel.font = [UIFont systemFontOfSize:13];
    }
}

#pragma mark - DZNEmptyDataSetDelegate
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return NO;
}

#pragma mark - table view data source
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return SectionCount;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case PictureImage_Section:
        case Countdown_Section:{
            return 1;
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
        case PictureImage_Section:{
            return [MeetingPreviewDetailImageTableViewCell class];
            break;
        }
        case Countdown_Section:{
            return [MeetingPreviewDetailCountdownTableViewCell class];
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
    return self.meetingDetail;
}

- (void) meetingContentLoaded:(NSNotification*) notification{
    [self.tableview reloadData];
}

#pragma mark button events
- (void) appointButtonClicked:(id) sender{
    self.appintButton.enabled = NO;
    WS(weakSelf)
    [MessageHubUtil showWait];
    [MeetingBussiness appointMeeting:!self.meetingDetail.isAppointment meetingId:self.meetingDetail.id result:^(id result) {
        
    } complete:^(NSInteger code, NSString *message) {
        [MessageHubUtil hideMessage];
        SAFE_WEAKSELF(weakSelf)
        if (code != 0) {
            [MessageHubUtil showErrorMessage:message];
            [weakSelf enableAppointButton];
            return ;
        }
        
        if (weakSelf.meetingDetail.isAppointment == 0) {
            [MessageHubUtil showMessage:@"已成功预约。"];
            [weakSelf appointmentChanged:1];
        }
        else{
            [MessageHubUtil showMessage:@"已取消预约。"];
            [weakSelf appointmentChanged:0];
        }
        [weakSelf performSelector:@selector(enableAppointButton) afterDelay:3];
    }];
}

- (void) appointmentChanged:(NSInteger) appoint{
    self.meetingDetail.isAppointment = appoint;
    [self setupAppointButton];
    
}

- (void) enableAppointButton{
    self.appintButton.enabled = YES;
}

- (void) applyButtonClicked:(id) sender{
    [MeetingPageRouter entryApplyMeetingPage:self.meetingDetail];
}
@end
