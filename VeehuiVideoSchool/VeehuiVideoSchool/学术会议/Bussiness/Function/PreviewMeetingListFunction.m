//
//  PreviewMeetingListFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/27.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "PreviewMeetingListFunction.h"
#import "MeetingEntryModel.h"
#import "UserModuleUtil.h"

@interface PreviewMeetingListFunction ()

@property (nonatomic) NSInteger pageNo;
@property (nonatomic) NSInteger pageSize;
 
@end

@implementation PreviewMeetingListFunction


- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v3/um/previewMeetingList", kURL_BASE_NEWDOMAIN];
}


- (id) paraserResponse:(id) response{
    if (response && [response isKindOfClass:[NSDictionary class]]) {
        return [MeetingListModel mj_objectWithKeyValues:response];
    }
    return nil;
}

@end
