//
//  VHLabelControl.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/15.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VHLabelControl : UIControl

@property (nonatomic, readonly) UILabel* textLabel;

- (id) initWithText:(NSString*) text font:(UIFont*) font textColor:(UIColor*) textColor;

@end

NS_ASSUME_NONNULL_END
