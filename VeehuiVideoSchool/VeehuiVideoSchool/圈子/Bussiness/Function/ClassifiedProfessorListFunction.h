//
//  ClassifiedProfessorListFunction.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHHTTPFunction.h"

NS_ASSUME_NONNULL_BEGIN

@interface ClassifiedProfessorListFunction : VHHTTPFunction

- (id) initWithCode:(NSString*) code pageNo:(NSInteger) page;

@end

NS_ASSUME_NONNULL_END
