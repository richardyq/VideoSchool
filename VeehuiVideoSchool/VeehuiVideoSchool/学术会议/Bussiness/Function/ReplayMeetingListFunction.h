//
//  ReplayMeetingListFunction.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/27.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHHTTPFunction.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReplayMeetingListFunction : VHHTTPFunction

- (id) initWithSubjectCode:(NSString*) subjectCode pageNo:(NSInteger) pageNo pageSize:(NSInteger) pageSize;

@end

NS_ASSUME_NONNULL_END
