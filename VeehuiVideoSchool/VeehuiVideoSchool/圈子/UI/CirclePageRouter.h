//
//  CirclePageRouter.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/3.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MedicalVideoClassifyEntryModel;

NS_ASSUME_NONNULL_BEGIN

@interface CirclePageRouter : NSObject

/**
 entryProfessorStartPage
 跳转到医学专家首页
 */
+ (void) entryProfessorStartPage;

/**
 entryProfessorSubjectedListPage
 跳转到分类的专家列表页面
 */
+ (void) entryProfessorSubjectedListPage:(MedicalVideoClassifyEntryModel*) subject;
@end

NS_ASSUME_NONNULL_END
