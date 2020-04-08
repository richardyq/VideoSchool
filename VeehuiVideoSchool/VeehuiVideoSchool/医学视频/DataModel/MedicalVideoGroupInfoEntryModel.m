//
//  MedicalVideoGroupInfoEntryModel.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalVideoGroupInfoEntryModel.h"

@implementation MedicalVideoGroupInfoEntryModel



@end

@implementation MedicalVideoGroupInfoListModel

+ (NSDictionary*) mj_objectClassInArray{
    return @{@"content": [MedicalVideoGroupInfoEntryModel class]};
}

@end
