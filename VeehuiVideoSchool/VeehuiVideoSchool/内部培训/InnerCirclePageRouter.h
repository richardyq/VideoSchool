//
//  InnerCirclePageRouter.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InnerCircleCourseListViewController.h"
NS_ASSUME_NONNULL_BEGIN


@interface InnerCirclePageRouter : NSObject

+ (void) entryInnerCircleStartPage:(NSInteger) circleId;

//跳转到内部培训课程列表
+ (void) entryInnerCircleCoursesPage:(InnerCircleCourseType) courseType;
@end

NS_ASSUME_NONNULL_END
