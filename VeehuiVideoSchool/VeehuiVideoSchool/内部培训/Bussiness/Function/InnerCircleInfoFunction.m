//
//  InnerCircleInfoFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "InnerCircleInfoFunction.h"
#import "JoinedCircleEntryModel.h"

@interface InnerCircleInfoFunction ()

@property (nonatomic) NSInteger circleId;

@end

@implementation InnerCircleInfoFunction

- (id) initWithCircleId:(NSInteger) circleId{
    self = [super init];
    if (self) {
        _circleId = circleId;
    }
    return self;
}

- (NSString*) requestUrl{
    NSString* requestUrl = [NSString stringWithFormat:@"%@/v2/ucrc/circleActiveInfoInHomePage/%ld", kURL_BASE_NEWDOMAIN, self.circleId];
    //requestUrl = [requestUrl URLEncodedString];
    return requestUrl;
}

- (id) paraserResponse:(id) response{
    if ([response isKindOfClass:[NSDictionary class]]) {
        NSDictionary* respDict = (NSDictionary*) response;
        JoinedCircleEntryModel* circleInfoModel = [JoinedCircleEntryModel mj_objectWithKeyValues:response];
        if (circleInfoModel.id == 0) {
            circleInfoModel.id = self.circleId;
        }
        if (!circleInfoModel.name || ![circleInfoModel.name isNotBlank]) {
            circleInfoModel.name = [respDict valueForKey:@"circleName"];
        }
        /*
        if (!circleInfoModel.bulletins || circleInfoModel.bulletins.count == 0) {
            NSArray<NSDictionary*>* dicts = [respDict valueForKey:@"circleAnnouncements"];
            NSMutableArray<CircleAnnouncementEntryModel*>* announcements = [NSMutableArray<CircleAnnouncementEntryModel*> array];
            [dicts enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
                [announcements addObject:[CircleAnnouncementEntryModel mj_objectWithKeyValues:dict]];
            }];
            circleInfoModel.bulletins = announcements;
        }
         */
        return circleInfoModel;
    }
    return nil;
}
@end
