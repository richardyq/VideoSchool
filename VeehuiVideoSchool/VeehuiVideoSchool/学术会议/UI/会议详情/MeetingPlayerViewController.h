//
//  MeetingPlayerViewController.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/30.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHBaseListViewController.h"
#import "MeetingDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MeetingPlayerViewController : VHBaseListViewController

@property (nonatomic, strong) MeetingDetailModel* meetingDetail;
@property (nonatomic, strong) VideoPlayerView* playerView;
@property (nonatomic, strong) VideoPlayerModel* playerModel;

- (id) initWithMeetingDetail:(MeetingDetailModel*) detail;
@end

NS_ASSUME_NONNULL_END
