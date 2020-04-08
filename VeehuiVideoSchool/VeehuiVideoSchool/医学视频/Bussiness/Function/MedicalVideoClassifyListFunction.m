//
//  MedicalVideoClassifyListFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/19.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalVideoClassifyListFunction.h"
#import "MedicalVideoClassifyEntryModel.h"

@implementation MedicalVideoClassifyListFunction

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v2/umv/classifyVideo", kURL_BASE_NEWDOMAIN];
}

- (id) paraserResponse:(id) response{
    if (response && [response isKindOfClass:[NSArray class]]) {
        NSMutableArray* classifies = [NSMutableArray<MedicalVideoClassifyEntryModel*> array];
        NSArray<NSDictionary*>* dicts = (NSArray<NSDictionary*>*) response;
        [dicts enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
            [classifies addObject:[MedicalVideoClassifyEntryModel mj_objectWithKeyValues:dict]];
        }];
        
        return classifies;
    }
    return nil;
}

@end
