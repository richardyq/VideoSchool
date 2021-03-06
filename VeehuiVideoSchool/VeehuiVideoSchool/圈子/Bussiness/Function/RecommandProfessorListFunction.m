//
//  RecommandProfessorListFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/8.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "RecommandProfessorListFunction.h"
#import "ProfessorInfoEntryModel.h"

@interface RecommandProfessorListFunction ()

@property (nonatomic) NSInteger pageNo;
@end

@implementation RecommandProfessorListFunction

- (id) initWtithPageNo:(NSInteger) pageNo{
    self = [super init];
    if (self) {
        _pageNo = pageNo;
    }
    return self;
}

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v2/crc/experts/%ld/10", kURL_BASE_NEWDOMAIN, (long)self.pageNo];
    return nil;
}

- (id) paraserResponse:(id) response{
    if ([response isKindOfClass:[NSDictionary class]]) {
        return [ProfessorInfoEntryList mj_objectWithKeyValues:response];
    }
    return nil;
}
@end
