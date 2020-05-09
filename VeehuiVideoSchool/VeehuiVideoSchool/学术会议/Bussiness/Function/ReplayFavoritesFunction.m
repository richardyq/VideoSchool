//
//  ReplayFavoritesFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/27.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "ReplayFavoritesFunction.h"
#import "SubjectEntryModel.h"

@implementation ReplayFavoritesFunction

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v2/us/seniorFavorite", kURL_BASE_NEWDOMAIN];
}


- (id) paraserResponse:(id) response{
    if (response && [response isKindOfClass:[NSArray class]]) {
        NSMutableArray<SubjectEntryModel*>* favorites = [NSMutableArray<SubjectEntryModel*> array];
        NSArray<NSDictionary*>* respDicts = (NSArray<NSDictionary*>*) response;
        [respDicts enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
            SubjectEntryModel* subject = [SubjectEntryModel mj_objectWithKeyValues:dict];
            if (subject.code && [subject.code isNotBlank] && [subject.code isEqualToString:@"00"]) {
                //剔除【最新分类】
                return ;
            }
            [favorites addObject:[SubjectEntryModel mj_objectWithKeyValues:dict]];
        }];
        return favorites;
    }
    return nil;
}
@end
