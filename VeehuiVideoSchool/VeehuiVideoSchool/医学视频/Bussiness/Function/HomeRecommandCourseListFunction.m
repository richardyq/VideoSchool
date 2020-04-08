//
//  HomeRecommandCourseListFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/31.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "HomeRecommandCourseListFunction.h"
#import "MedicalVideoGroupInfoEntryModel.h"

@implementation HomeRecommandCourseListFunction

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v2/umv/mvgRecommendedHighQuality/1/6", kURL_BASE_NEWDOMAIN];
}

- (id) paraserResponse:(id) response{
    if (response && [response isKindOfClass:[NSDictionary class]]) {
        return [MedicalVideoGroupInfoListModel mj_objectWithKeyValues:response];
    }
    return nil;
}

@end
