//
//  SaveChosenFavoritesFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/9.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "SaveChosenFavoritesFunction.h"
#import "FavoriteEntryModel.h"

@interface SaveChosenFavoritesFunction ()

@property NSArray<FavoriteEntryModel*>* favorites;

@end

@implementation SaveChosenFavoritesFunction

- (id) initWithFavorites:(NSArray<FavoriteEntryModel*>*) favorites{
    self = [super init];
    if (self) {
        _favorites = favorites;
    }
    return self;
}

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v2/u/favorite", kURL_BASE_NEWDOMAIN];
}

- (id) reqeustDictionary{
    NSMutableArray<NSDictionary*>* param = [NSMutableArray<NSDictionary*> array];
    [self.favorites enumerateObjectsUsingBlock:^(FavoriteEntryModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        [param addObject:[model mj_keyValues]];
    }];
    return param;
}

- (EHTTPRequestMethod) requestMethod{
    return Request_POST;
}
@end
