//
//  PorfessorSubjectedListViewController.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/9.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHBaseListViewController.h"

@class MedicalVideoClassifyEntryModel;

NS_ASSUME_NONNULL_BEGIN

@interface PorfessorSubjectedListViewController : VHBaseListViewController

- (id) initWithClassifyModel:(MedicalVideoClassifyEntryModel*) classify;

@end

NS_ASSUME_NONNULL_END
