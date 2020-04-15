//
//  ProfessorInfoEntryModel.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/15.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "ProfessorInfoEntryModel.h"

@implementation ProfessorInfoEntryModel

+ (NSDictionary*) mj_objectClassInArray{
    return @{@"medicalVideos": [MedicalVideoGroupInfoEntryModel class]};
}

@end

@implementation ProfessorInfoEntryList

+ (NSDictionary*) mj_objectClassInArray{
    return @{@"content": [ProfessorInfoEntryModel class]};
}

@end
