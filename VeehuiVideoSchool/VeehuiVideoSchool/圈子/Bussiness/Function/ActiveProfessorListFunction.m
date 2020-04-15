//
//  ActiveProfessorListFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/14.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "ActiveProfessorListFunction.h"
#import "CircleInfoEntryModel.h"

@implementation ActiveProfessorListFunction

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v2/crc/activeExperts", kURL_BASE_NEWDOMAIN];
    //return nil;
}

- (id) paraserResponse:(id) response{
    if ([response isKindOfClass:[NSArray class]]) {
        NSArray<NSDictionary*>* dicts = (NSArray<NSDictionary*>*) response;
        NSMutableArray<CircleInfoEntryModel*>* professors = [NSMutableArray<CircleInfoEntryModel*> array];
        [dicts enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
            [professors addObject:[CircleInfoEntryModel mj_objectWithKeyValues:dict]];
        }];
        
        CircleInfoEntryList* professorList = [[CircleInfoEntryList alloc] init];
        professorList.content = professors;
        return professorList;
    }
    return nil;
}

@end
