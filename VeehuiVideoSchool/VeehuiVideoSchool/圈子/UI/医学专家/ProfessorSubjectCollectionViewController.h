//
//  ProfessorSubjectCollectionViewController.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/3.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ProfessorDeptsDelegate <NSObject>

- (void) professorDeptPages:(NSInteger) pages;
- (void) professorDeptPageShown:(NSInteger) page;
@end

@interface ProfessorSubjectCollectionViewController : UICollectionViewController

@property (nonatomic, weak) id<ProfessorDeptsDelegate> deptDelegate;
@end

NS_ASSUME_NONNULL_END
