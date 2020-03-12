//
//  MedicalGroupOthersFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/12.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalGroupOthersFunction.h"
#import "MedicalVideoGroupInfoEntryModel.h"

@interface MedicalGroupOthersFunction ()

@property (nonatomic) NSInteger groupId;

@end

@implementation MedicalGroupOthersFunction

- (id) initWithGroupId:(NSInteger) groupId{
    self = [super init];
    if (self) {
        _groupId = groupId;
    }
    return self;
}

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v3/p/mvgWatchOthers/%ld/1/10", kURL_BASE_NEWDOMAIN, self.groupId];
}

- (NSDictionary*) reqeustDictionary{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setValue:@(self.groupId) forKey:@"groupId"];
    
    return dict;
}

- (id) paraserResponse:(id) response{
    if (response && [response isKindOfClass:[NSDictionary class]]) {
        return [MedicalVideoGroupInfoListModel mj_objectWithKeyValues:response];
    }
    return nil;
}
@end
