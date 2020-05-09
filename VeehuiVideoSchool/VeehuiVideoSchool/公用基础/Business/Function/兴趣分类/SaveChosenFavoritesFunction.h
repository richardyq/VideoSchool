//
//  SaveChosenFavoritesFunction.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/9.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHHTTPFunction.h"

NS_ASSUME_NONNULL_BEGIN

@class FavoriteEntryModel;

@interface SaveChosenFavoritesFunction : VHHTTPFunction

- (id) initWithFavorites:(NSArray<FavoriteEntryModel*>*) favorites;

@end

NS_ASSUME_NONNULL_END
