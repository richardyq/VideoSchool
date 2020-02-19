//
//  VHGridItemControl.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/19.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VHGridItemControl : UIControl

- (id) initWithImage:(UIImage*) iconImage
                name:(NSString*) name;

- (id) initWithImageName:(NSString*) iconImageName
                    name:(NSString*) name;
@end

NS_ASSUME_NONNULL_END
