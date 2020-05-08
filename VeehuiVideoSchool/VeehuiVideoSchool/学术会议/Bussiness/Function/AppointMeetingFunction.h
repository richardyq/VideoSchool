//
//  AppointMeetingFunction.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/8.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHHTTPFunction.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppointMeetingFunction : VHHTTPFunction

- (id) initWithTypeCode:(NSInteger) opsTypeCode meetingId:(NSInteger) meetingId;

@end

NS_ASSUME_NONNULL_END
