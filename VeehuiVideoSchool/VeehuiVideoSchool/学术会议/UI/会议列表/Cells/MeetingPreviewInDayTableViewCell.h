//
//  MeetingPreviewInDayTableViewCell.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/7.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHTableViewCell.h"

@class MeetingPreviewDayModel;

NS_ASSUME_NONNULL_BEGIN

@interface MeetingPreviewInDayTableViewCell : VHTableViewCell

- (id) initWithMeetingDayModel:(MeetingPreviewDayModel*) model;

@end

NS_ASSUME_NONNULL_END
