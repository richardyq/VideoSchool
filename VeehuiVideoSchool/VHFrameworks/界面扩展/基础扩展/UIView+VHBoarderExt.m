//
//  UIView+VHBoarderExt.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/17.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "UIView+VHBoarderExt.h"

NSInteger const topLineTag = 0x3950;
NSInteger const leftLineTag = topLineTag + 1;
NSInteger const bottomLineTag = leftLineTag + 1;
NSInteger const rightLineTag = bottomLineTag + 1;
//NSInteger const WatermarkImageViewTag = 0x89B5;


@implementation UIView (VHBoarderExt)

- (void) showBoarder{
    self.layer.borderColor = [UIColor commonBoarderColor].CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.masksToBounds = YES;
}

- (void) showBoarder:(UIViewBorderLineType) boarderType{
    NSInteger lineTag = topLineTag;
    switch (boarderType) {
        case UIViewBorderLineTypeTop:
            lineTag = topLineTag;
            break;
        case UIViewBorderLineTypeLeft:
            lineTag = leftLineTag;
            break;
        case UIViewBorderLineTypeBottom:
            lineTag = bottomLineTag;
            break;
        case UIViewBorderLineTypeRight:
            lineTag = rightLineTag;
            break;
            
    }
    
    UIView* lineView = [self viewWithTag:lineTag];
    if (lineView) {
        return;
    }
    
    lineView = [UIView new];
    lineView.tag = lineTag;
    [self addSubview:lineView];
    lineView.backgroundColor = [UIColor commonBoarderColor];
    
    switch (boarderType) {
        case UIViewBorderLineTypeTop:
        {
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self);
                make.left.right.equalTo(self);
                make.height.mas_equalTo(@0.5);
            }];
            break;
        }
            
        case UIViewBorderLineTypeLeft:
        {
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self);
                make.top.bottom.equalTo(self);
                make.width.mas_equalTo(@0.5);
            }];
            break;
        }
        case UIViewBorderLineTypeRight: {
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self);
                make.top.bottom.equalTo(self);
                make.width.mas_equalTo(@0.5);
            }];
            break;
        }
        case UIViewBorderLineTypeBottom: {
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self);
                make.left.right.equalTo(self);
                make.height.mas_equalTo(@0.5);
            }];
            break;
        }
    }
}

- (void) hideBoarder:(UIViewBorderLineType) boarderType{
    NSInteger lineTag = topLineTag;
    switch (boarderType) {
        case UIViewBorderLineTypeTop:
            lineTag = topLineTag;
            break;
        case UIViewBorderLineTypeLeft:
            lineTag = leftLineTag;
            break;
        case UIViewBorderLineTypeBottom:
            lineTag = bottomLineTag;
            break;
        case UIViewBorderLineTypeRight:
            lineTag = rightLineTag;
            break;
            
    }
    
    UIView* lineView = [self viewWithTag:lineTag];
    if (!lineView) {
        return;
    }
    
    [lineView removeFromSuperview];
    lineView = nil;
}

- (void) setCornerRadius:(CGFloat) radius{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (void) setCornerRadius:(CGFloat) radius color:(UIColor*) color boarderwidth:(CGFloat) boarderwidth{
    self.layer.cornerRadius = radius;
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = boarderwidth;
    self.layer.masksToBounds = YES;
}

// 添加四边阴影效果
- (void) addShadowToView:(UIColor *)theColor {
    
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowColor = theColor.CGColor;
}


@end
