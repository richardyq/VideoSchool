//
//  MedicalVideoInfoTableViewCell.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHTableViewCell.h"
#import "MedicalVideoGroupInfoEntryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MedicalVideoInfoTableViewCell : VHTableViewCell

- (void) setVideoGroupInfo:(MedicalVideoGroupInfoEntryModel*) entryModel;
@end

NS_ASSUME_NONNULL_END
