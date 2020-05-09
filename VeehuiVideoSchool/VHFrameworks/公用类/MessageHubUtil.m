//
//  MessageHubUtil.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/21.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MessageHubUtil.h"

@implementation MessageHubUtil

+ (void) load{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumDismissTimeInterval:2.5];
    [SVProgressHUD setMaximumDismissTimeInterval:3];
}


+ (void) hideMessage{
    [SVProgressHUD dismiss];
}

+ (void) showWait{
    [SVProgressHUD show];
}

+ (void) showWait:(NSString*) msg{
    if (msg && ![msg isEmpty]) {
        [SVProgressHUD showWithStatus:msg];
    }
    else{
        [SVProgressHUD show];
    }
}

+ (void) showMessage:(NSString*) msg{
    if (!msg || [msg isEmpty]) {
        return;
    }
    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:msg];
}

+ (void) showInfoMessage:(NSString*) msg{
    if (!msg || [msg isEmpty]) {
        return;
    }
    [SVProgressHUD showInfoWithStatus:msg];
}

+ (void) showErrorMessage:(NSString*) msg{
    if (!msg || [msg isEmpty]) {
        return;
    }
    [SVProgressHUD showErrorWithStatus:msg];
}

+ (void) showSuccessMessage:(NSString*) msg{
    if (!msg || [msg isEmpty]) {
        return;
    }
    [SVProgressHUD showSuccessWithStatus:msg];
}
@end
