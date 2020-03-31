//
//  HomeRecommandCourseTableViewCell.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/31.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHTableViewCell.h"
#import "MedicalVideoGroupInfoEntryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeRecommandCourseTableViewCell : VHTableViewCell

- (id) initWithCourseList:(MedicalVideoGroupInfoListModel*) courseList;

@end

NS_ASSUME_NONNULL_END
