//
//  VHCache.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/2.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const kCachePrefixPath;

NS_ASSUME_NONNULL_BEGIN

@interface VHCache : NSObject

+ (void) saveToCache:(id) value cachePath:(NSString*) cachePath;

+ (id) loadFromeCache:(NSString*) cachePath;

@end

NS_ASSUME_NONNULL_END
