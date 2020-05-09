//
//  FavoriteListFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/9.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "FavoriteListFunction.h"
#import "FavoriteEntryModel.h"

@implementation FavoriteListFunction

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v2/o/subjcet", kURL_BASE_NEWDOMAIN];
}

- (id) paraserResponse:(id) response{
    if (response && [response isKindOfClass:[NSArray class]]) {
        NSArray<NSDictionary*>* dicts = (NSArray<NSDictionary*>*) response;
        NSMutableArray<FavoriteEntryModel*>* favorites = [NSMutableArray<FavoriteEntryModel*> array];
        
        [dicts enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
            [favorites addObject:[FavoriteEntryModel mj_objectWithKeyValues:dict]];
        }];
        return favorites;
    }
    return nil;
}
@end
