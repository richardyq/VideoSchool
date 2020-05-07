//
//  PreviewMeetingsFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/7.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "PreviewMeetingsFunction.h"
#import "MeetingPreviewSectionModel.h"
#import "MeetingPreviewGatherModel.h"

@implementation PreviewMeetingsFunction

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v3/um/previewMeetingList", kURL_BASE_NEWDOMAIN];
}

- (id) paraserResponse:(id) response{
    if (response && [response isKindOfClass:[NSArray class]]) {
        NSArray<NSDictionary*>* dicts = (NSArray<NSDictionary*>*) response;
        NSMutableArray<MeetingEntryModel*>* meetings = [NSMutableArray<MeetingEntryModel*> array];
        [dicts enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
            MeetingPreviewSectionModel* section = [MeetingPreviewSectionModel mj_objectWithKeyValues:dict];
            [meetings addObjectsFromArray:section.meetings];
        }];
        
        MeetingPreviewGatherModel* gather = [[MeetingPreviewGatherModel alloc] init];
        gather.count = meetings.count;
        
        if (meetings.count <= 3) {
            gather.meetings = meetings;
        }
        else{
            gather.meetings = [meetings subarrayWithRange:NSMakeRange(0, 3)];
        }
        return gather;
    }
    return nil;
}

@end
