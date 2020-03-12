//
//  MedicalVideoGroupDetailEntryModel.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/11.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalVideoGroupDetailEntryModel.h"

@implementation MedicalVideoGroupDetailEntryModel

+ (NSDictionary*) mj_replacedKeyFromPropertyName{
    return @{@"desc":@"description"};
}

@end
