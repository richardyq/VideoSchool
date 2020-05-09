//
//  SubjectEntryModel.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/1.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "EntryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SubjectEntryModel : EntryModel

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* subjectCode;
@property (nonatomic, strong) NSString* code;       //有些地方用code，有些地方用subjectCode

@end

NS_ASSUME_NONNULL_END
