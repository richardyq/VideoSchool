//
//  UIImage+VHExt.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/17.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GradientType) {
    
    GradientTypeTopToBottom =0,//从上到小
    
    GradientTypeLeftToRight =1,//从左到右
    
    GradientTypeUpleftToLowright =2,//左上到右下
    
    GradientTypeUprightToLowleft =3,//右上到左下
    
};

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (VHExt)

#pragma mark - 绘制形状
+ (UIImage*) rectImage:(UIColor*) color size:(CGSize) size;
+ (UIImage*) gradientColorImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize;
#pragma mark - 颜色方法
/*
 imageWithColor
 使用某种颜色填充image
 */
- (UIImage *)imageWithColor:(UIColor *)color;

/*
 mostColor
 获取image的主颜色
 */
- (UIColor*) mostColor;

@end

NS_ASSUME_NONNULL_END
