//
//  WechatAuthRespModel.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "WechatAuthRespModel.h"

@implementation WechatAuthRespModel

- (id) initWithOpenId:(NSString*) openId accessToken:(NSString*) accessToken unionId:(NSString*) unionId{
    self = [super init];
    if (self) {
        _openid = openId;
        _accessToken = accessToken;
        _unionId = unionId;
    }
    return self;
}
@end
