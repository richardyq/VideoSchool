//
//  UIView+VHSubviewExt.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/17.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "UIView+VHSubviewExt.h"

NSInteger const WatermarkImageViewTag = 0x89B5;

@implementation UIView (VHSubviewExt)

#pragma mark - 添加subview
- (UILabel*) addLabel{
    UILabel* label = [[UILabel alloc] init];
    [self addSubview:label];
    return label;
}

- (UILabel*) addLabel:(UIColor*) textColor textSize:(CGFloat) textSize{
    UILabel* label = [self addLabel];
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:textSize];
    
    return label;
}

- (UIImageView*) addImageView{
    UIImageView* imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    return imageView;
}

- (UIImageView*) addImageView:(NSString*) imageName{
    UIImageView* imageView = [self addImageView];
    imageView.image = [UIImage imageNamed:imageName];
    return imageView;
}



- (UITextField*) addTextField:(NSString*) placeholder{
    UITextField* textfield = [[UITextField alloc] init];
    [self addSubview:textfield];
    textfield.placeholder = placeholder;
    textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    return textfield;
}


- (UITextField*) addTextField:(NSString*) placeholder class:(Class) class{
    UITextField* textfield = [[class alloc] init];
    [self addSubview:textfield];
    textfield.placeholder = placeholder;
    
    textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    return textfield;
}

- (UITextField*) addTextField:(NSString*) placeholder
                    textColor:(UIColor*) textColor
                     textSize:(CGFloat) textSize{
    UITextField* textfield = [self addTextField:placeholder];
    textfield.textColor = textColor;
    textfield.font = [UIFont systemFontOfSize:textSize];
    return textfield;
}

- (UITextField*) addTextField:(NSString*) placeholder
                        class:(Class) class
                    textColor:(UIColor*) textColor
                     textSize:(CGFloat) textSize{
    UITextField* textfield = [self addTextField:placeholder class:class];
    textfield.textColor = textColor;
    textfield.font = [UIFont systemFontOfSize:textSize];
    return textfield;
}

- (UIButton*) addButton:(UIButtonType) buttonType{
    UIButton* button = [UIButton buttonWithType:buttonType];
    [self addSubview:button];
    
    return button;
}

- (UIButton*) addButtonWithImageName:(NSString*) imageName{
    UIButton* button = [self addButton:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    return button;
}

- (UIButton*) addSolidButton:(UIColor*) color size:(CGSize) size title:(NSString*) title titleSize:(CGFloat) titleSize{
    UIButton* button = [self addButton:UIButtonTypeCustom];
    UIImage* bgImage = [UIImage rectImage:color size:size];
    [button setBackgroundImage:bgImage forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:titleSize];
    [button setCornerRadius:4];
    return button;
}

- (UIButton*) addStokeButton:(UIColor*) color size:(CGSize) size title:(NSString*) title titleSize:(CGFloat) titleSize{
    UIButton* button = [self addButton:UIButtonTypeCustom];
    UIImage* bgImage = [UIImage rectImage:[UIColor whiteColor] size:size];
    [button setBackgroundImage:bgImage forState:UIControlStateNormal];
    UIImage* highImage = [UIImage rectImage:[UIColor commonBoarderColor] size:size];
    [button setBackgroundImage:highImage forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:titleSize];
    [button setCornerRadius:4 color:color boarderwidth:1];
    
    return button;
}

- (UIView*) addView{
    UIView* view = [UIView new];
    [self addSubview:view];
    return view;
}

- (UIView*) addView:(Class) class{
    UIView* view = [[class alloc] init];
    [self addSubview:view];
    return view;
}

- (UIView*) addView:(Class) class frame:(CGRect) frame{
    UIView* view = [[class alloc] initWithFrame:frame];
    [self addSubview:view];
    return view;
}

#pragma mark - 添加水印
- (void) addWatermark:(NSString*) imagename positon:(WatermarPosition) position{
    [self addWatermark:imagename positon:position offset:0];
}

- (void) addWatermark:(NSString*) imagename positon:(WatermarPosition) position  offset:(CGFloat) offset{
    //删除原有水印
    UIImageView* watermarkImageView = [self viewWithTag:WatermarkImageViewTag];
    if (watermarkImageView) {
        [watermarkImageView removeFromSuperview];
    }
    
    //添加水印
    watermarkImageView = [self addImageView:imagename];
    watermarkImageView.tag = WatermarkImageViewTag;
    //水印布局
    switch (position) {
        case WatermarPosition_TL:{
            [watermarkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.equalTo(self).offset(offset);
            }];
            break;
        }
        case WatermarPosition_TR:{
            [watermarkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(offset);
                make.right.equalTo(self).offset(-offset);
            }];
            break;
        }
        case WatermarPosition_BL:{
            [watermarkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(offset);
                make.bottom.equalTo(self).offset(-offset);
            }];
            break;
        }
        case WatermarPosition_BR:{
            [watermarkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.right.equalTo(self).offset(-offset);
            }];
            break;
        }
            
    }
    
}

- (void) removeWatermark{
    UIImageView* watermarkImageView = [self viewWithTag:WatermarkImageViewTag];
    if (watermarkImageView) {
        [watermarkImageView removeFromSuperview];
    }
}

@end
