//
//  ReplayFavoritesFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/27.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "ReplayFavoritesFunction.h"
#import "MedicalVideoClassifyEntryModel.h"

@implementation ReplayFavoritesFunction

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v2/us/seniorFavorite", kURL_BASE_NEWDOMAIN];
}


- (id) paraserResponse:(id) response{
    if (response && [response isKindOfClass:[NSArray class]]) {
        NSMutableArray<MedicalVideoClassifyEntryModel*>* favorites = [NSMutableArray<MedicalVideoClassifyEntryModel*> array];
        NSArray<NSDictionary*>* respDicts = (NSArray<NSDictionary*>*) response;
        [respDicts enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
            [favorites addObject:[MedicalVideoClassifyEntryModel mj_objectWithKeyValues:dict]];
        }];
        return favorites;
    }
    return nil;
}
@end
