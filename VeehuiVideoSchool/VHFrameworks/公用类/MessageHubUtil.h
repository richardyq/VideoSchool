//
//  MessageHubUtil.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/21.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageHubUtil : NSObject

+ (void) hideMessage;

//显示等待界面
+ (void) showWait;
+ (void) showWait:(NSString*) msg;

+ (void) showMessage:(NSString*) msg;
+ (void) showInfoMessage:(NSString*) msg;
+ (void) showErrorMessage:(NSString*) msg;
+ (void) showSuccessMessage:(NSString*) msg;

@end

NS_ASSUME_NONNULL_END
