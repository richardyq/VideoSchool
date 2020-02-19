//
//  VHHTTPFunctionManager.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VHHTTPFunctionManager : NSObject


+ (instancetype)shareInstance;

- (void) createFunction:(VHHTTPFunction*) function
                 result:(VHRequestResultHandler) result
               complete:(VHRequestCompleteHandler) complete;

@end

NS_ASSUME_NONNULL_END
