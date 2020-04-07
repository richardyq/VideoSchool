//
//  CommonBaseBussiness.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "CommonBaseBussiness.h"

#import "MobileVerifyCodeFunction.h"
#import "CheckMobileVerifyCodeFunction.h"
#import "BindMobileFunction.h"
#import "SeniorSubjectListFunction.h"

@implementation CommonBaseBussiness

+ (void) obtainMobileVerifyCode:(NSString*) mobile
                         result:(VHRequestResultHandler) result
                       complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[MobileVerifyCodeFunction alloc] initWithMobile:mobile];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:result complete:complete];
}

+ (void) checkMobileVerifyCode:(NSString*) mobile
                    verifyCode:(NSString*) verifyCode
                        result:(VHRequestResultHandler) result
                      complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[CheckMobileVerifyCodeFunction alloc] initWithMobile:mobile verifyCode:verifyCode];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:result complete:complete];
}

+ (void) startbindMobile:(NSString*) mobile
                  result:(VHRequestResultHandler) result
                       complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[BindMobileFunction alloc] initWithMobile:mobile];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:result complete:complete];
}

+ (void) startSeniorSubjects:(VHRequestResultHandler) result
                    complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[SeniorSubjectListFunction alloc] init];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:result complete:complete];
}

@end
