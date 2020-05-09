//
//  MeetingApplyViewController.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/8.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHBaseListViewController.h"

@class MeetingDetailModel;

NS_ASSUME_NONNULL_BEGIN

@interface MeetingApplyViewController : VHBaseListViewController

- (id) initWithMeetingDetail:(MeetingDetailModel*) detail;

@end

NS_ASSUME_NONNULL_END
