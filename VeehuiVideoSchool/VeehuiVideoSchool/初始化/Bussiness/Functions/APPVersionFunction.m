//
//  APPVersionFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "APPVersionFunction.h"
#import "APPVersionInfo.h"

@interface APPVersionFunction ()

@end

@implementation APPVersionFunction

- (id) init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSString*) requestUrl{
    NSString* version = [NSObject appVersion];
    return [NSString stringWithFormat:@"%@/v2/o/version/2/%@", kURL_BASE_NEWDOMAIN, version];
}

- (id) paraserResponse:(id) response{
    if (response && [response isKindOfClass:[NSDictionary class]]) {
        return [APPVersionInfo mj_objectWithKeyValues:response];
    }
    return nil;
}
@end
