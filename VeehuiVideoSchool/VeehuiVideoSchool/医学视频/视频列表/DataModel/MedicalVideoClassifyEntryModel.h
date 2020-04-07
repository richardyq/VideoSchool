//
//  MedicalVideoClassifyEntryModel.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/19.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MedicalVideoGroupInfoEntryModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MedicalVideoClassifyEntryModel : EntryModel

@property (nonatomic, copy) NSString* code;
@property (nonatomic, copy) NSString* name;

@property (nonatomic, strong) NSArray<MedicalVideoGroupInfoEntryModel*>* medicalVideos;
 
@end

NS_ASSUME_NONNULL_END
