//
//  ClassifiedProfessorListFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "ClassifiedProfessorListFunction.h"
#import "ProfessorInfoEntryModel.h"

@interface ClassifiedProfessorListFunction ()

@property (nonatomic, strong) NSString* code;
@property (nonatomic) NSInteger pageNo;
@end

@implementation ClassifiedProfessorListFunction

- (id) initWithCode:(NSString*) code pageNo:(NSInteger) page{
    self = [super init];
    if (self) {
        _code = code;
        _pageNo = page;
    }
    return self;
}

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v2/crc/deptExperts/%@/%ld/10", kURL_BASE_NEWDOMAIN, self.code, self.pageNo];
    return nil;
}

- (id) reqeustDictionary{
    NSMutableDictionary* param = [NSMutableDictionary dictionary];
    [param setValue:self.code forKey:@"code"];
    [param setValue:@(self.pageNo) forKey:@"pageNo"];
    [param setValue:@(10) forKey:@"pageSize"];
    return param;
}

- (id) paraserResponse:(id) response{
    if ([response isKindOfClass:[NSDictionary class]]) {
        ProfessorInfoEntryList* listModel = [ProfessorInfoEntryList mj_objectWithKeyValues:response];
        return listModel;
    }
    return nil;
}
@end
