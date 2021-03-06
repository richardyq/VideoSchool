//
//  MedicalVideoPageRouter.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/19.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MedicalVideoClassifyEntryModel;

NS_ASSUME_NONNULL_BEGIN

@interface MedicalVideoPageRouter : NSObject

/**
 entryMedicalVideoStartListPage
 跳转到医学视频首页
 */
+ (void) entryMedicalVideoStartListPage;

/**
 entryClassifiedMedicalVideListPage
 跳转到分类医学视频列表界面
 @param  classifyModel  分类对象
 */
+ (void) entryClassifiedMedicalVideListPage:(MedicalVideoClassifyEntryModel*) classifyModel;

/**
entryMedicalCourseListPage
跳转到精品课程首页
*/
+ (void) entryMedicalCourseListPage;

/**
 entryMedicalVideoDetailPage
 跳转到医学视频详情页面
 @param  groupId   视频组id
 */
+ (void) entryMedicalVideoDetailPage:(NSInteger) groupId;

@end

NS_ASSUME_NONNULL_END
