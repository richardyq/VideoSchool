//
//  UserJoinedCircleInfoFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/30.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "UserJoinedCircleInfoFunction.h"
#import "JoinedCircleEntryModel.h"

@interface UserJoinedCircleInfoFunction ()

@property (nonatomic, assign) NSInteger circleId;
@end

@implementation UserJoinedCircleInfoFunction

- (id) initWithCircleId:(NSInteger) circleId{
    self= [self init];
    if (self) {
        _circleId = circleId;
    }
    return self;
}

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v2/ucrc/circleActiveInfoInHomePage/%ld", kURL_BASE_NEWDOMAIN, self.circleId];
}

- (id) paraserResponse:(id) response{
    if ([response isKindOfClass:[NSDictionary class]]) {
        JoinedCircleEntryModel* circleInfoModel = [JoinedCircleEntryModel mj_objectWithKeyValues:response];
        return circleInfoModel;
    }
    return nil;
}
@end
