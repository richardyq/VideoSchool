//
//  MedicalVideoCategoryView.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/22.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MedicalVideoClassifyEntryModel;

typedef void(^CategoryViewSelectAction)(NSInteger index);

NS_ASSUME_NONNULL_BEGIN

@interface MedicalVideoCategoryView : UIView

@property (nonatomic, assign) NSInteger selectedIndex;

- (id) initWithCategories:(NSArray<MedicalVideoClassifyEntryModel*>*) categories
             selectAction:(CategoryViewSelectAction) action;

@end

NS_ASSUME_NONNULL_END
