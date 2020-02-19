//
//  CommonBaseBussiness.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "CommonBaseBussiness.h"

#import "MobileVerifyCodeFunction.h"

@implementation CommonBaseBussiness

+ (void) obtainMobileVerifyCode:(NSString*) mobile
                         result:(VHRequestResultHandler) result
                       complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[MobileVerifyCodeFunction alloc] initWithMobile:mobile];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:result complete:complete];
}
@end
