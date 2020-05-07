//
//  MeetingPreviewWholeTableViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/7.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingPreviewWholeTableViewController.h"
#import "MeetingPreviewSectionModel.h"
#import "MeetingPreviewInDayTableViewCell.h"

@interface MeetingPreviewWholeTableViewController ()

@property (nonatomic, strong) NSArray<MeetingPreviewSectionModel*>* sections;
@property (nonatomic, strong) NSArray<NSArray<MeetingPreviewDayModel*>*>* meetingDays;

@end

@implementation MeetingPreviewWholeTableViewController

- (id) initWithPreviewSections:(NSArray<MeetingPreviewSectionModel*>*) sections{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        _sections = sections;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 45.;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (NSArray<NSArray<MeetingPreviewDayModel*>*>*) meetingDays{
    if (!_meetingDays) {
        NSMutableArray<NSArray<MeetingPreviewDayModel*>*>* meetingDays = [NSMutableArray<NSArray<MeetingPreviewDayModel*>*> array];
        [self.sections enumerateObjectsUsingBlock:^(MeetingPreviewSectionModel * _Nonnull section, NSUInteger idx, BOOL * _Nonnull stop) {
            [meetingDays addObject:[section meetingsInDays]];
        }];
        _meetingDays = meetingDays;
    }
    return _meetingDays;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return self.meetingDays.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    NSArray<MeetingPreviewDayModel*>* meetingsInDay = self.meetingDays[section];
    return meetingsInDay.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray<MeetingPreviewDayModel*>* meetingsInDay = self.meetingDays[indexPath.section];
    MeetingPreviewInDayTableViewCell* cell = [[MeetingPreviewInDayTableViewCell alloc] initWithMeetingDayModel:meetingsInDay[indexPath.row]];
    // Configure the cell...
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.;
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 40)];
    
    headerview.backgroundColor = [UIColor whiteColor];
    UILabel* monthLabel = [headerview addLabel:[UIColor commonTextColor] textSize:15 weight:UIFontWeightMedium];
    [monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerview);
        make.left.equalTo(headerview).offset(12);
    }];
    
    MeetingPreviewSectionModel* sectionModel = self.sections[section];
    monthLabel.text = sectionModel.fullName;
    
    return headerview;
}

@end
