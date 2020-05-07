//
//  MeetingPreviewSectionTableViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/7.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingPreviewSectionTableViewController.h"
#import "MeetingPreviewSectionModel.h"
#import "MeetingPreviewInDayTableViewCell.h"

@interface MeetingPreviewSectionTableViewController ()

@property (nonatomic, strong) MeetingPreviewSectionModel* previewSection;
@property (nonatomic, strong) NSArray<MeetingPreviewDayModel*>* dayModels;
@end

@implementation MeetingPreviewSectionTableViewController

- (id) initWithPreviewSection:(MeetingPreviewSectionModel*) previewSection{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        _previewSection = previewSection;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 45.;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _dayModels = [self.previewSection meetingsInDays];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.dayModels.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MeetingPreviewInDayTableViewCell* cell = [[MeetingPreviewInDayTableViewCell alloc] initWithMeetingDayModel:self.dayModels[indexPath.row]];
    // Configure the cell...
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}





@end
