//
//  UIView+VHSubviewExt.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/17.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, WatermarPosition) {
    WatermarPosition_TL,
    WatermarPosition_TR,
    WatermarPosition_BL,
    WatermarPosition_BR,
};

@interface UIView (VHSubviewExt)

#pragma mark - 添加subview
/*
 addLabel
 add a UILabel to this view
 */
- (UILabel*) addLabel;
- (UILabel*) addLabel:(UIColor*) textColor textSize:(CGFloat) textSize;
- (UIButton*) addButtonWithImageName:(NSString*) imageName;
/*
 addImageView
 add a UIImageView to this view
 */
- (UIImageView*) addImageView;
- (UIImageView*) addImageView:(NSString*) imageName;

/*
 addTextField
 add TextField to this view
 */
- (UITextField*) addTextField:(NSString*) placeholder;
- (UITextField*) addTextField:(NSString*) placeholder class:(Class) class;

- (UITextField*) addTextField:(NSString*) placeholder
                    textColor:(UIColor*) textColor
                     textSize:(CGFloat) textSize;
- (UITextField*) addTextField:(NSString*) placeholder
                        class:(Class) class
textColor:(UIColor*) textColor
textSize:(CGFloat) textSize;

/*
 addButton
 add UIButton to this view
 */
- (UIButton*) addButton:(UIButtonType) buttonType;
- (UIButton*) addSolidButton:(UIColor*) color size:(CGSize) size title:(NSString*) title titleSize:(CGFloat) titleSize;
- (UIButton*) addStokeButton:(UIColor*) color size:(CGSize) size title:(NSString*) title titleSize:(CGFloat) titleSize;

/*
 addView
 add view to this view
 */
- (UIView*) addView;

- (UIView*) addView:(Class) class;
- (UIView*) addView:(Class) class frame:(CGRect) frame;

#pragma mark - 添加水印
- (void) addWatermark:(NSString*) imagename positon:(WatermarPosition) position;
- (void) addWatermark:(NSString*) imagename positon:(WatermarPosition) position  offset:(CGFloat) offset;
- (void) removeWatermark;


@end

NS_ASSUME_NONNULL_END
