//
//  CommonDataModel.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/30.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "CommonDataModel.h"

@implementation CommonDataModel

+ (instancetype)shareInstance{
    static CommonDataModel *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance=[[CommonDataModel alloc] init];
    });
    return _instance;
}

- (void) userLogout{
    self.joinedCircles = nil;
    self.joinedCircleInfo = nil;
}
@end
