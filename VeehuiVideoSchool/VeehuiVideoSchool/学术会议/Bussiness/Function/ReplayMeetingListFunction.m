//
//  ReplayMeetingListFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/27.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "ReplayMeetingListFunction.h"
#import "MeetingEntryModel.h"

@interface ReplayMeetingListFunction ()

@property (nonatomic, strong) NSString* subjectCode;
@property (nonatomic) NSInteger pageNo;
@property (nonatomic) NSInteger pageSize;

@end

@implementation ReplayMeetingListFunction

- (id) initWithSubjectCode:(NSString*) subjectCode pageNo:(NSInteger) pageNo pageSize:(NSInteger) pageSize{
    self = [super init];
    if (self) {
        _subjectCode = subjectCode;
        _pageNo = pageNo;
        _pageSize = pageSize;
    }
    return self;
}

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v3/um/replayMeetingList/%@/%ld/%ld", kURL_BASE_NEWDOMAIN, self.subjectCode, self.pageNo, self.pageSize];
}

- (id) reqeustDictionary{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setValue:self.subjectCode forKey:@"subjectCode"];
    [dict setValue:@(self.pageNo) forKey:@"pageNo"];
    [dict setValue:@(self.pageSize) forKey:@"pageSize"];
    return dict;
}

- (id) paraserResponse:(id) response{
    if (response && [response isKindOfClass:[NSDictionary class]]) {
        return [MeetingListModel mj_objectWithKeyValues:response];
    }
    return nil;
}
@end
