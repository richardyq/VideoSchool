//
//  HomeStartGirdTableViewCell.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/19.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHTableViewCell.h"

typedef NS_ENUM(NSUInteger, EHomeStartGirdIndex) {
    StartGird_Meeting,
    StartGird_MedicalVideo,
    StartGird_Course,
    StartGird_Score,
    StartGird_Subjects,
};

NS_ASSUME_NONNULL_BEGIN

typedef void(^HomeStartGirdAction)(NSInteger index);

@interface HomeStartGirdTableViewCell : VHTableViewCell

- (void) onGridAction:(HomeStartGirdAction) action;
@end

NS_ASSUME_NONNULL_END
