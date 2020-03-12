//
//  MedicalVideoEntryModel.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/11.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "EntryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MedicalVideoEntryModel : EntryModel

@property (nonatomic, strong) NSString* title;
@property (nonatomic) NSInteger videoId;
@property (nonatomic) NSInteger groupId;
@property (nonatomic, strong) NSString* speaker;
@property (nonatomic) NSInteger watchingNumber;

@property (nonatomic) NSInteger currentTime;
@property (nonatomic) NSInteger duration;
@end

NS_ASSUME_NONNULL_END
