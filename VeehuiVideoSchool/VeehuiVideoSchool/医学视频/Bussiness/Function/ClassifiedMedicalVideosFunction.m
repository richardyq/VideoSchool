//
//  ClassifiedMedicalVideosFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "ClassifiedMedicalVideosFunction.h"
#import "MedicalVideoGroupInfoEntryModel.h"

@interface ClassifiedMedicalVideosFunction ()

@property (nonatomic, readonly) NSString* code;
@property (nonatomic) NSInteger pageNo;
@property (nonatomic) NSInteger pageSize;

@end

@implementation ClassifiedMedicalVideosFunction

- (id) initWithCode:(NSString*) code pageNo:(NSInteger) pageNo pageSize:(NSInteger) pageSize{
    self = [super init];
    if (self) {
        _code = code;
        _pageNo = pageNo;
        _pageSize = pageSize;
    }
    return self;
}

- (NSString*) requestUrl{
    NSString* args = [[self reqeustDictionary] mj_JSONString];
    
    NSString* requestUrl = [NSString stringWithFormat:@"%@/v2/umv/query?args=%@", kURL_BASE_NEWDOMAIN, [args URLEncodedString]];
    //requestUrl = [requestUrl URLEncodedString];
    return requestUrl;
}

- (id) reqeustDictionary{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    if (self.code && ![self.code isEmpty]) {
        [dict setValue:self.code forKey:@"subjectCode"];
    }
    
    [dict setValue:@(self.pageNo) forKey:@"pageNo"];
    [dict setValue:@(self.pageSize) forKey:@"pageSize"];
    
    return dict;
}

- (id) paraserResponse:(id) response{
    if (response && [response isKindOfClass:[NSDictionary class]]) {
        return [MedicalVideoGroupInfoListModel mj_objectWithKeyValues:response];
    }
    return nil;
}

@end
