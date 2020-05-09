//
//  FavoriteEntryModel.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/9.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "SubjectEntryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FavoriteEntryModel : SubjectEntryModel

@property (nonatomic, strong) NSArray<FavoriteEntryModel*>* childrens;

@property (nonatomic) BOOL chosen;      //是否已被选择
@end

NS_ASSUME_NONNULL_END
