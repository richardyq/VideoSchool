//
//  InnerCircleCourseListViewController.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/21.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHBaseListViewController.h"

typedef NS_ENUM(NSUInteger, InnerCircleCourseType) {
    CourseTypeAll,
    CourseTypeNecessarily,          //必学
    CourseTypeUnnecessarily,        //选学
};


NS_ASSUME_NONNULL_BEGIN

@interface InnerCircleCourseListViewController : VHBaseListViewController

- (id) initWithCourseType:(InnerCircleCourseType) courseType;

@end

NS_ASSUME_NONNULL_END
