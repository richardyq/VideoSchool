//
//  MeetingConferenceTableViewCell.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/30.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHTableViewCell.h"

@class MeetingConferenceModel;

NS_ASSUME_NONNULL_BEGIN

@interface MeetingConferenceTableViewCell : VHTableViewCell

- (id) initWithConferense:(MeetingConferenceModel*) conference;

@end

NS_ASSUME_NONNULL_END
