//
//  UIView+VHBoarderExt.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/17.
//  Copyright © 2020 殷全. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIViewBorderLineType) {
    UIViewBorderLineTypeTop,
    UIViewBorderLineTypeRight,
    UIViewBorderLineTypeBottom,
    UIViewBorderLineTypeLeft,
};

NS_ASSUME_NONNULL_BEGIN

@interface UIView (VHBoarderExt)

#pragma mark - view的边线
- (void) showBoarder;

- (void) showBoarder:(UIViewBorderLineType) boarderType;
- (void) hideBoarder:(UIViewBorderLineType) boarderType;

- (void) setCornerRadius:(CGFloat) radius;

- (void) setCornerRadius:(CGFloat) radius color:(UIColor*) color boarderwidth:(CGFloat) boarderwidth;

- (void) addShadowToView:(UIColor *)theColor;

@end

NS_ASSUME_NONNULL_END
