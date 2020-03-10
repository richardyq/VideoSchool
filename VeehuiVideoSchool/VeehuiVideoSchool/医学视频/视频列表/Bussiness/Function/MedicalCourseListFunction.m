//
//  MedicalCourseListFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/10.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalCourseListFunction.h"
#import "MedicalVideoGroupInfoEntryModel.h"

@interface MedicalCourseListFunction ()

@property (nonatomic) NSInteger pageNo;
@property (nonatomic) NSInteger pageSize;

@end

@implementation MedicalCourseListFunction

- (id) initWithPageNo:(NSInteger) pageNo pageSize:(NSInteger) pageSize{
    self = [super init];
    if (self) {
        _pageNo = 1;
        _pageSize = 20;
    }
    return self;
}

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v3/umv/mvgRecommended/%ld/%ld", kURL_BASE_NEWDOMAIN, self.pageNo, self.pageSize];
}

- (id) paraserResponse:(id) response{
    if (response && [response isKindOfClass:[NSDictionary class]]) {
        return [MedicalVideoGroupInfoListModel mj_objectWithKeyValues:response];
    }
    return nil;
}
@end
