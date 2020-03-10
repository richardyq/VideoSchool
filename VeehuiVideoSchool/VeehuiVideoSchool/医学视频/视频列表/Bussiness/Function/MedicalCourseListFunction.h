//
//  MedicalCourseListFunction.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/10.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHHTTPFunction.h"

NS_ASSUME_NONNULL_BEGIN

@interface MedicalCourseListFunction : VHHTTPFunction

- (id) initWithPageNo:(NSInteger) pageNo pageSize:(NSInteger) pageSize;
@end

NS_ASSUME_NONNULL_END
