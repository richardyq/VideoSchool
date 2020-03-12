//
//  CircleInfoEntryModel.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/12.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "EntryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CircleInfoEntryModel : EntryModel

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* portraitUrl;

@property (nonatomic, strong) NSString* organization;
@property (nonatomic, strong) NSString* department;
@property (nonatomic, strong) NSString* deptCode;

@property (nonatomic) NSInteger fansCount;              //粉丝数
@property (nonatomic) NSInteger followCount;            //关注数
@end

NS_ASSUME_NONNULL_END
