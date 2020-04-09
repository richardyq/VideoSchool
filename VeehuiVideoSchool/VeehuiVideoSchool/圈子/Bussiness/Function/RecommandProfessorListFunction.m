//
//  RecommandProfessorListFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/8.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "RecommandProfessorListFunction.h"
#import "CircleInfoEntryModel.h"

@implementation RecommandProfessorListFunction

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v2/crc/circleInfosFavoriteNoFollowTwo", kURL_BASE_NEWDOMAIN];
}

- (id) paraserResponse:(id) response{
    if ([response isKindOfClass:[NSArray class]]) {
        NSMutableArray<CircleInfoEntryModel*>* circles = [NSMutableArray<CircleInfoEntryModel*> array];
        NSArray<NSDictionary*>* dicts = (NSArray<NSDictionary*>*) response;
        [dicts enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
            [circles addObject:[CircleInfoEntryModel mj_objectWithKeyValues:dict]];
        }];
        return circles;
    }
    return nil;
}
@end
