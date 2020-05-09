//
//  UIColor+VHStandExt.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/17.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (VHStandExt)

#pragma mark - 常用颜色
+ (UIColor*) commonBackgroundColor;
+ (UIColor*) commonBoarderColor;
+ (UIColor*) mainThemeColor;

//半透明遮盖色
+ (UIColor*) commonTransColor;

#pragma mark - 文本颜色
+ (UIColor*) commonTextColor;
+ (UIColor*) commonGrayTextColor;
+ (UIColor*) commonDarkGrayTextColor;
+ (UIColor*) commonLightGrayTextColor;
@end

NS_ASSUME_NONNULL_END
