//
//  MedicalVideoSecondaryClassifyListFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalVideoSecondaryClassifyListFunction.h"
#import "MedicalVideoClassifyEntryModel.h"

@interface MedicalVideoSecondaryClassifyListFunction ()

@property (nonatomic, readonly) NSString* code;

@end

@implementation MedicalVideoSecondaryClassifyListFunction

- (id) initWithCode:(NSString*) code{
    self = [super init];
    if (self) {
        _code = code;
    }
    return self;
}

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v2/us/allSecondaryFavorite/%@", kURL_BASE_NEWDOMAIN, self.code];
}

- (id) reqeustDictionary{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    if (self.code && ![self.code isEmpty]) {
        [dict setValue:self.code forKey:@"code"];
    }
    return dict;
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
