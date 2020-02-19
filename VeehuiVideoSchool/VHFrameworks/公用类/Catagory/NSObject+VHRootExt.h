//
//  NSObject+VHRootExt.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/17.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (VHRootExt)

+ (id<UIApplicationDelegate>) rootApp;

+ (UIWindow*) rootWindow;

+ (UIViewController*) topMostController;

#pragma mark - 系统版本基本信息
+ (NSString*) appVersion;
+ (NSString*) deviceInfo;
+ (NSString*) systemName;
@end

NS_ASSUME_NONNULL_END
