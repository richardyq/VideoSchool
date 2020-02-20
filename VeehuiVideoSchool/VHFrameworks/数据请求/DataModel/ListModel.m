//
//  ListModel.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel

+ (NSDictionary*) mj_objectClassInArray{
    return @{@"content": [EntryModel class]};
}
@end
