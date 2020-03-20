//
//  AlertUtil.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "AlertUtil.h"

@implementation AlertUtil

+ (void) showAlertWithTitle:(NSString*) title
                    message:(NSString*) message{
    [self showAlertWithTitle:title message:message confirmHandler:nil];
}

+ (void) showAlertWithTitle:(NSString*) title
                    message:(NSString*) message
             confirmHandler:(AlertAtionHandler) confirmHandler{
    [self showAlertWithTitle:title message:message confirmTitle:@"确定" confirmHandler:confirmHandler];
}

+ (void) showAlertWithTitle:(NSString*) title
                    message:(NSString*) message
               confirmTitle:(NSString*) confirmTitle
             confirmHandler:(AlertAtionHandler) confirmHandler{
    [self showAlertWithTitle:title message:message confirmTitle:confirmTitle confirmHandler:confirmHandler];
}


+ (void) showAlertWithTitle:(NSString*) title
                    message:(NSString*) message
               confirmTitle:(NSString*) confirmTitle
             confirmHandler:(AlertAtionHandler) confirmHandler
               cancelTitle:(NSString*) cancleTitle
             cancelHandler:(AlertAtionHandler) cancleHandler{
    
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* confirmAction = nil;
    if (confirmTitle && ![confirmTitle isEmpty]) {
        confirmAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:confirmHandler];
        [alertController addAction:confirmAction];
    }
    
    UIAlertAction* cancelAction = nil;
    if (cancleTitle && ![cancleTitle isEmpty]) {
        cancelAction = [UIAlertAction actionWithTitle:cancleTitle style:UIAlertActionStyleDefault handler:cancleHandler];
        [alertController addAction:cancelAction];
    }
    
    [[NSObject topMostController] presentViewController: alertController animated: YES completion: nil];
}


@end
