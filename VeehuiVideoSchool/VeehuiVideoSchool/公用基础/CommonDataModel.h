//
//  CommonDataModel.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/30.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CircleInfoEntryModel.h"
#import "JoinedCircleEntryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommonDataModel : NSObject

@property (nonatomic, strong) NSArray<JoinedCircleEntryModel*>* joinedCircles;
@property (nonatomic, strong) JoinedCircleEntryModel* joinedCircleInfo;

+ (instancetype)shareInstance;

- (void) userLogout;

@end

NS_ASSUME_NONNULL_END
