//
//  CircleDeptListFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/14.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "CircleDeptListFunction.h"
#import "MedicalVideoClassifyEntryModel.h"

@implementation CircleDeptListFunction

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v2/crcri/depts/03", kURL_BASE_NEWDOMAIN];
}

- (id) paraserResponse:(id) response{
    if (response && [response isKindOfClass:[NSArray class]]) {
        NSMutableArray<MedicalVideoClassifyEntryModel*>* subjects = [NSMutableArray<MedicalVideoClassifyEntryModel*> array];
        NSArray<NSDictionary*>* dicts = (NSArray*) response;
        [dicts enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
            MedicalVideoClassifyEntryModel* subject = [MedicalVideoClassifyEntryModel mj_objectWithKeyValues:dict];
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
