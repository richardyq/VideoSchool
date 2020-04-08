//
//  HomeSubjectListFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/1.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "HomeSubjectListFunction.h"


@implementation HomeSubjectListFunction

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v3/umv/complexContentSubject/1", kURL_BASE_NEWDOMAIN];
}

- (id) paraserResponse:(id) response{
    if (response && [response isKindOfClass:[NSDictionary class]]) {
        return [HomeSubjectListModel mj_objectWithKeyValues:response];
    }
    return nil;
}
@end
