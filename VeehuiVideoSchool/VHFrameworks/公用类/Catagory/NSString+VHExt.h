//
//  NSString+VHExt.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/17.
//  Copyright © 2020 殷全. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (VHExt)

- (BOOL) isEmpty;

/**
 isMobileNumber
 判断是否是手机号
 */
- (BOOL) isMobileNumber;

+ (NSString*) formatWithInteger:(NSInteger) number
                         remain:(NSInteger) remain
                           unit:(NSString*) unit;

+ (NSString*) stringWithDuration:(NSInteger) duration;

@end

NS_ASSUME_NONNULL_END
