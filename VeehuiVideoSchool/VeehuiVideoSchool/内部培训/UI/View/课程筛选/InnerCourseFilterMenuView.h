//
//  InnerCourseFilterMenuView.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/21.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHPopView.h"
#import "InnerCourseFilterEntryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface InnerCourseFilterMenuView : VHPopView

@property (nonatomic, strong) NSArray<InnerCourseFilterEntryModel*>* filterEntryModels;

@end

@interface InnerCourseStudyFilterMenuView : InnerCourseFilterMenuView

@end

@interface InnerCourseSortFilterMenuView : InnerCourseFilterMenuView

@end

NS_ASSUME_NONNULL_END
