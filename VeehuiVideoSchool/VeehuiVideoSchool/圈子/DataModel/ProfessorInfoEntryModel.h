//
//  ProfessorInfoEntryModel.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/15.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "CircleInfoEntryModel.h"
#import "MedicalVideoGroupInfoEntryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfessorInfoEntryModel : CircleInfoEntryModel

@property (nonatomic) NSInteger likeCount;
@property (nonatomic, strong) NSArray<MedicalVideoGroupInfoEntryModel*>* medicalVideos;
@end

@interface ProfessorInfoEntryList : ListModel

@end

NS_ASSUME_NONNULL_END
