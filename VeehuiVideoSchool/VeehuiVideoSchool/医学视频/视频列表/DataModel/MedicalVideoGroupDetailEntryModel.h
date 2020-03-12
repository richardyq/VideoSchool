//
//  MedicalVideoGroupDetailEntryModel.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/11.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalVideoGroupInfoEntryModel.h"
#import "MedicalVideoEntryModel.h"
#import "CircleInfoEntryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MedicalVideoGroupDetailEntryModel : MedicalVideoGroupInfoEntryModel

@property (nonatomic, strong) NSString* desc;
@property (nonatomic, strong) NSString* noteToBuy;      //购买须知
@property (nonatomic, strong) CircleInfoEntryModel*  circleInfo;        //圈子信息
@property (nonatomic, strong) NSArray<MedicalVideoEntryModel*>* medicalVideoItems;

@end

NS_ASSUME_NONNULL_END
