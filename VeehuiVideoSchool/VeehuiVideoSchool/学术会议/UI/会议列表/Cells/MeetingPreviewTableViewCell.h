//
//  MeetingPreviewTableViewCell.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/27.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHTableViewCell.h"

@class MeetingListModel;

NS_ASSUME_NONNULL_BEGIN

@interface MeetingPreviewTableViewCell : VHTableViewCell

- (id) initWithMeetingList:(MeetingListModel*) meetinglist;

@end

NS_ASSUME_NONNULL_END
