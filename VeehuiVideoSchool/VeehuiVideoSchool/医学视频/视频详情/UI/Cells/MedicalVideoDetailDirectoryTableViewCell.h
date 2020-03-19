//
//  MedicalVideoDetailDirectoryTableViewCell.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/12.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHTableViewCell.h"
#import "MedicalVideoDirectoryDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface MedicalVideoDetailDirectoryTableViewCell : VHTableViewCell

@property (nonatomic, weak) id<MedicalVideoDirectoryDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
