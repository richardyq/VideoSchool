//
//  AlertUtil.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef void(^AlertAtionHandler)(UIAlertAction *action);

@interface AlertUtil : NSObject

+ (void) showAlertWithTitle:(NSString*) title
                    message:(NSString*) message;

+ (void) showAlertWithTitle:(NSString*) title
                    message:(NSString*) message
             confirmHandler:(AlertAtionHandler) confirmHandler;

+ (void) showAlertWithTitle:(NSString*) title
                    message:(NSString*) message
               confirmTitle:(NSString*) confirmTitle
             confirmHandler:(AlertAtionHandler) confirmHandler;

+ (void) showAlertWithTitle:(NSString*) title
                    message:(NSString*) message
               confirmTitle:(NSString*) confirmTitle
             confirmHandler:(AlertAtionHandler) confirmHandler
                cancelTitle:(NSString*) cancleTitle
              cancelHandler:(AlertAtionHandler)  cancleHandler;

@end

