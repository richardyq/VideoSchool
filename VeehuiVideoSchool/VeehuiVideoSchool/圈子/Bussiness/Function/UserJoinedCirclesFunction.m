//
//  UserJoinedCirclesFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/30.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "UserJoinedCirclesFunction.h"
#import "JoinedCircleEntryModel.h"

@implementation UserJoinedCirclesFunction

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v2/ucrc/circleInfoListForMember", kURL_BASE_NEWDOMAIN];
}

- (id) paraserResponse:(id) response{
    if (response && [response isKindOfClass:[NSArray class]]) {
        //return [APPVersionInfo mj_objectWithKeyValues:response];
        NSMutableArray* circles = [NSMutableArray<JoinedCircleEntryModel*> array];
        NSArray<NSDictionary*>* dicts = (NSArray*) response;
        [dicts enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
            [circles addObject:[JoinedCircleEntryModel mj_objectWithKeyValues:dict]];
        }];
        return circles;
    }
    return nil;
}
@end
