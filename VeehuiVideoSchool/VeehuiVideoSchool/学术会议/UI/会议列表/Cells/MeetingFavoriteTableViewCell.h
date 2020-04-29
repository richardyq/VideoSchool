//
//  MeetingFavoriteTableViewCell.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/28.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHTableViewCell.h"
@class MedicalVideoClassifyEntryModel;

NS_ASSUME_NONNULL_BEGIN

@interface MeetingFavoriteTableViewCell : VHTableViewCell

- (id) initWithCategories:(NSArray<MedicalVideoClassifyEntryModel*>*) categories;

@end

NS_ASSUME_NONNULL_END
