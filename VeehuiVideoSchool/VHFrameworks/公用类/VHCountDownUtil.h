//
//  VHCountDownUtil.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString* const kCountDownNotifitionName;

@interface VHCountDownUtil : NSObject

+ (instancetype)shareInstance;

- (void) startCountDown:(id) sender;

- (void) stopCountDown:(id) sender;
@end

NS_ASSUME_NONNULL_END
