//
//  ClassifiedMedicalVideosFunction.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHHTTPFunction.h"

NS_ASSUME_NONNULL_BEGIN

@interface ClassifiedMedicalVideosFunction : VHHTTPFunction

- (id) initWithCode:(NSString*) code pageNo:(NSInteger) pageNo pageSize:(NSInteger) pageSize;

@end

NS_ASSUME_NONNULL_END
