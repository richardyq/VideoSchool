//
//  MedicalVideoClassifyEntryModel.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/19.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalVideoClassifyEntryModel.h"

@implementation MedicalVideoClassifyEntryModel

+ (NSDictionary*) mj_objectClassInArray{
    return @{@"medicalVideos": [MedicalVideoGroupInfoEntryModel class]};
}
@end
