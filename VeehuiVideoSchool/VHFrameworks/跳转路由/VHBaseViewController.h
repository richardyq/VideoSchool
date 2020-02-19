//
//  VHBaseViewController.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/17.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^dismissControllerHandler)(id ret);

@interface VHBaseViewController : UIViewController

@property (nonatomic, readonly) NSString* controllerId;

@property (nonatomic, copy) dismissControllerHandler dismissHandler;

- (void) dismissController:(_Nullable id) ret;

- (void) onDismissControllerHandler:(dismissControllerHandler) handler;
@end

NS_ASSUME_NONNULL_END
