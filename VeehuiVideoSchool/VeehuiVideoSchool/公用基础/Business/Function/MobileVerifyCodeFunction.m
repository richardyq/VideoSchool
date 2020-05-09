//
//  MobileVerifyCodeFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MobileVerifyCodeFunction.h"

@interface MobileVerifyCodeFunction ()

@property (nonatomic, strong) NSString* mobile;
@end

@implementation MobileVerifyCodeFunction

- (id) initWithMobile:(NSString*) mobile{
    self = [super init];
    if (self) {
        _mobile = mobile;
    }
    return self;
}

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v2/o/authVCode/01/86/%@", kURL_BASE_NEWDOMAIN, self.mobile];
}

- (id) reqeustDictionary{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    if (self.mobile && ![self.mobile isEmpty]) {
        [dict setValue:self.mobile forKey:@"mobile"];
    }
    return dict;
}

- (id) paraserResponse:(id) response{
    if (response && [response isKindOfClass:[NSDictionary class]]) {
        
    }
    return nil;
}
@end
