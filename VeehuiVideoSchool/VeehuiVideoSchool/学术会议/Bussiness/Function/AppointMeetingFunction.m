//
//  AppointMeetingFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/8.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "AppointMeetingFunction.h"
#import "UserModuleUtil.h"

@interface AppointMeetingFunction ()

@property (nonatomic) NSInteger opsTypeCode;    //操作类型['0':'取消','1':'预约']
@property (nonatomic) NSInteger meetingId;

@end

@implementation AppointMeetingFunction

- (id) initWithTypeCode:(NSInteger) opsTypeCode meetingId:(NSInteger) meetingId{
    self = [super init];
    if (self) {
        _opsTypeCode = opsTypeCode;
        _meetingId = meetingId;
    }
    return self;
}

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v2/u/appointment/%ld", kURL_BASE_NEWDOMAIN, self.opsTypeCode];
}

- (id) reqeustDictionary{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setValue:@(self.meetingId) forKey:@"meetingId"];
    [dict setValue:@([UserModuleUtil shareInstance].loginedUserId) forKey:@"userId"];
    return dict;
}

- (EHTTPRequestMethod) requestMethod{
    return Request_POST;
}

@end
