//
//  HomeSubjectHeaderTableViewCell.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/1.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHTableViewCell.h"

@class HomeSubjectEntry;

NS_ASSUME_NONNULL_BEGIN

@interface HomeSubjectHeaderTableViewCell : VHTableViewCell

- (id) initWithSubjectEntry:(HomeSubjectEntry*) subjectEntry;

@end

NS_ASSUME_NONNULL_END
