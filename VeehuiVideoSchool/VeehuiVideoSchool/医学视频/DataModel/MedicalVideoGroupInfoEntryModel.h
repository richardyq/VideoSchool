//
//  MedicalVideoGroupInfoEntryModel.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CircleInfoEntryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MedicalVideoGroupInfoEntryModel : EntryModel

//@property (nonatomic) NSInteger id;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* pictureUrl;

@property (nonatomic, strong) NSString* organization;
@property (nonatomic, strong) NSString* department;
@property (nonatomic, strong) NSString* medicalVideoComposer;

@property (nonatomic, strong) NSString* circleName;
@property (nonatomic) NSInteger circleId;
@property (nonatomic, strong) CircleInfoEntryModel*  circleInfo;        //圈子信息

@property (nonatomic) NSInteger watchingNumber;
@property (nonatomic) NSInteger vdCount;
@property (nonatomic) NSInteger purchaseNumber;

@property (nonatomic) NSInteger isPrice;
@property (nonatomic) NSInteger isVip;
@property (nonatomic) NSInteger price;

@property (nonatomic,copy) NSArray<NSString*>* productTypeCodeNames;

@end

@interface MedicalVideoGroupInfoListModel : ListModel

@end

NS_ASSUME_NONNULL_END
