//
//  MedicalVideoAdvertiseListFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/7.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalVideoAdvertiseListFunction.h"
#import "AdvertiseEntryModel.h"

@implementation MedicalVideoAdvertiseListFunction

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v2/o/mvideoAds", kURL_BASE_NEWDOMAIN];
}

- (id) paraserResponse:(id) response{
    if (response && [response isKindOfClass:[NSArray class]]) {
        NSMutableArray<AdvertiseEntryModel*>* advertises = [NSMutableArray<AdvertiseEntryModel*> array];
        NSArray<NSDictionary*>* dicts = (NSArray<NSDictionary*>*) response;
        [dicts enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
            [advertises addObject:[AdvertiseEntryModel mj_objectWithKeyValues:dict]];
        }];
        return advertises;
    }
    return nil;
}

@end
