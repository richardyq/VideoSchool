//
//  LiveMeetingListFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/24.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "LiveMeetingListFunction.h"
#import "MeetingEntryModel.h"

@interface LiveMeetingListFunction ()

@property (nonatomic) NSInteger pageNo;
@property (nonatomic) NSInteger pageSize;
 
@end

@implementation LiveMeetingListFunction

- (id) initWithPageNo:(NSInteger) pageNo pageSize:(NSInteger) pageSize{
    self = [super init];
    if (self) {
        _pageNo = pageNo;
        _pageSize = pageSize;
    }
    return self;
}

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v3/um/liveMeetingList/%ld/%ld", kURL_BASE_NEWDOMAIN, self.pageNo, self.pageSize];
}

- (NSDictionary*) reqeustDictionary{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
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
