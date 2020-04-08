//
//  MedicalGroupDetailFunction.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/11.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHHTTPFunction.h"

NS_ASSUME_NONNULL_BEGIN

@interface MedicalGroupDetailFunction : VHHTTPFunction

- (id) initWithGroupId:(NSInteger) groupId;

@end

NS_ASSUME_NONNULL_END
