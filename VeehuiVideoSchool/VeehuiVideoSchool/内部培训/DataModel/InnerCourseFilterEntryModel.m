//
//  InnerCourseFilterEntryModel.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/21.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "InnerCourseFilterEntryModel.h"

@implementation InnerCourseFilterEntryModel

- (id) initWithTitle:(NSString*) title value:(NSString*) value{
    self = [super init];
    if (self) {
        _title = title;
        _value = value;
    }
    return self;
}
@end
