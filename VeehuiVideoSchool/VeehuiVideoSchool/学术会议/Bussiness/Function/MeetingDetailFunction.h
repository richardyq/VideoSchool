//
//  MeetingDetailFunction.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/30.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHHTTPFunction.h"

NS_ASSUME_NONNULL_BEGIN

@interface MeetingDetailFunction : VHHTTPFunction

@property (nonatomic, readonly) NSInteger meetingId;

- (id) initWithMeetingId:(NSInteger) meetingId;

@end

NS_ASSUME_NONNULL_END
