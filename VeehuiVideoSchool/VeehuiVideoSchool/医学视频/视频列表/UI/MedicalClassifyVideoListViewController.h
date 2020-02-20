//
//  MedicalClassifyVideoListViewController.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHBaseListViewController.h"
#import "MedicalVideoClassifyEntryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MedicalClassifyVideoListViewController : VHBaseListViewController

- (id) initWithClassifyModel:(MedicalVideoClassifyEntryModel*) classifyEntryModel;
@end

NS_ASSUME_NONNULL_END
