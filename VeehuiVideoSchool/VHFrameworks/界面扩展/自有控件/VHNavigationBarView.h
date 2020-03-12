//
//  VHNavigationBarView.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/11.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ENavigationType) {
    Navigation_Trans,       //透明
    Navigation_Normal,      //不透明
    //,
};

NS_ASSUME_NONNULL_BEGIN

@interface VHNavigationBarView : UIView

@property (nonatomic) ENavigationType navigationType;

- (id) initWithNavigationType:(ENavigationType) navigationType;

@end

NS_ASSUME_NONNULL_END
