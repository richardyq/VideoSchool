//
//  VideoFullPlayerViewController.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/29.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VideoFullPlayerView.h"
typedef void(^FullPlayerClosedAction)(void);

NS_ASSUME_NONNULL_BEGIN

@interface VideoFullPlayerViewController : UIViewController

+ (void) showWithOrientation:(UIDeviceOrientation) orientation
               originalFrame:(CGRect) frame
                 closeAction:(FullPlayerClosedAction) closeAction;


- (void) startCloseFull;
@end

NS_ASSUME_NONNULL_END
