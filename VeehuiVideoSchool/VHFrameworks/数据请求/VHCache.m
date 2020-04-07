//
//  VHCache.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/2.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHCache.h"

NSString* const kCacheName = @"VeehuiResponseCache";
NSString* const kCachePrefixPath = @"vhmodel://model.local.cache/";

@implementation VHCache

+ (void) saveToCache:(id) value cachePath:(NSString*) cachePath{
    YYCache *cache = [YYCache cacheWithName:kCacheName];
    if (!cachePath || [cachePath isEmpty]) {
        return;
    }
    if (!value || [value isKindOfClass:[NSNull class]]) {
        [cache removeObjectForKey:cachePath];
        return;
    }
    [cache setObject:value forKey:cachePath];
}

+ (id) loadFromeCache:(NSString*) cachePath{
    id value = nil;
    YYCache *cache = [YYCache cacheWithName:kCacheName];
    if (!cachePath || [cachePath isEmpty]) {
        return value;
    }
    
    value = [cache objectForKey:cachePath];
    return value;
}

@end
