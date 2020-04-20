//
//  CircleSecondaryDeptListFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "CircleSecondaryDeptListFunction.h"
#import "MedicalVideoClassifyEntryModel.h"

@interface CircleSecondaryDeptListFunction ()

@property (nonatomic, readonly) NSString* code;

@end

@implementation CircleSecondaryDeptListFunction

- (id) initWithCode:(NSString*) code{
    self = [super init];
    if (self) {
        _code = code;
    }
    return self;
}

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v2/crcri/secondaryDepts/%@", kURL_BASE_NEWDOMAIN, self.code];
}

- (id) paraserResponse:(id) response{
    if ([response isKindOfClass:[NSArray class]]) {
        NSMutableArray<MedicalVideoClassifyEntryModel*>* depts = [NSMutableArray<MedicalVideoClassifyEntryModel*> array];
        NSArray<NSDictionary*>* dicts = (NSArray<NSDictionary*>*) response;
        [dicts enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
            [depts addObject:[MedicalVideoClassifyEntryModel mj_objectWithKeyValues:dict]];
        }];
        
        return depts;
    }
    return nil;
}

@end
