//
//  FollowedProfessorListFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/15.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "FollowedProfessorListFunction.h"

#import "ProfessorInfoEntryModel.h"

@interface FollowedProfessorListFunction ()

@property (nonatomic) NSInteger pageNo;
@end

@implementation FollowedProfessorListFunction

- (id) initWtithPageNo:(NSInteger) pageNo{
    self = [super init];
    if (self) {
        _pageNo = pageNo;
    }
    return self;
}

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v2/ucrc/followExperts/%ld/10", kURL_BASE_NEWDOMAIN, (long)self.pageNo];
    return nil;
}

- (id) paraserResponse:(id) response{
    if ([response isKindOfClass:[NSDictionary class]]) {
        return [ProfessorInfoEntryList mj_objectWithKeyValues:response];
    }
    return nil;
}

@end
