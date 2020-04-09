//
//  CircleInfoEntryModel.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/12.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "CircleInfoEntryModel.h"

@implementation CircleInfoEntryModel

@end

@implementation CircleInfoEntryList

+ (NSDictionary*) mj_objectClassInArray{
    return @{@"content": [CircleInfoEntryModel class]};
}

@end
