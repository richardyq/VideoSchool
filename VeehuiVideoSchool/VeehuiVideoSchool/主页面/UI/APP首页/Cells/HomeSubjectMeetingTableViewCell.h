//
//  HomeSubjectMeetingTableViewCell.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/1.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHTableViewCell.h"

@class MeetingEntryModel;

NS_ASSUME_NONNULL_BEGIN

@interface HomeSubjectMeetingTableViewCell : VHTableViewCell

- (id) initWithMeetingEntry:(MeetingEntryModel*) meeting;

@end

NS_ASSUME_NONNULL_END
