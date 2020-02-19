//
//  MedicalVideoListBussiness.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/19.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalVideoListBussiness.h"
#import "MedicalVideoClassifyListFunction.h"

@implementation MedicalVideoListBussiness

+ (void) startLoadMediaclVideoClassify:(VHRequestResultHandler) result
                              complete:(VHRequestCompleteHandler) complete{
    VHHTTPFunction* function = [[MedicalVideoClassifyListFunction alloc] init];
    [[VHHTTPFunctionManager shareInstance] createFunction:function result:^(id resp) {
        if (result) {
            result(resp);
        }
    } complete:complete];
}
@end
