//
//  UserFavoriteFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/7.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "UserFavoriteFunction.h"
#import "SubjectEntryModel.h"

@implementation UserFavoriteFunction

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v2/u/favorite", kURL_BASE_NEWDOMAIN];
}

- (id) paraserResponse:(id) response{
    if (response && [response isKindOfClass:[NSArray class]]) {
        NSMutableArray<SubjectEntryModel*>* subjects = [NSMutableArray<SubjectEntryModel*> array];
        NSArray<NSDictionary*>* dicts = (NSArray*) response;
        [dicts enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
            SubjectEntryModel* subject = [SubjectEntryModel mj_objectWithKeyValues:dict];
            if (!subject.code || [subject.code isEmpty]) {
                return ;
            }
            [subjects addObject:subject];
        }];
        return subjects;
    }
    return nil;
}

@end
