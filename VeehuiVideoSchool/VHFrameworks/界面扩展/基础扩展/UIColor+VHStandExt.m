//
//  UIColor+VHStandExt.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/17.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "UIColor+VHStandExt.h"


@implementation UIColor (VHStandExt)

#pragma mark - 常用颜色
+ (UIColor*) commonBackgroundColor{
    return [UIColor colorWithHexString:@"F6F6F6"];
}

+ (UIColor*) commonBoarderColor{
    return [UIColor colorWithHexString:@"DADADA"];
}

+ (UIColor*) mainThemeColor{
    //return [UIColor colorWithHexString:@"FF831E"];
    return [UIColor colorWithHexString:@"FF6A00"];
}

//半透明遮盖色
+ (UIColor*) commonTransColor{
    return [UIColor colorWithHexString:@"00000062"];
}

#pragma mark - 文本颜色
+ (UIColor*) commonTextColor{
    return [UIColor colorWithHexString:@"333333"];
}

+ (UIColor*) commonGrayTextColor{
    return [UIColor colorWithHexString:@"888888"];
}

+ (UIColor*) commonDarkGrayTextColor{
    return [UIColor colorWithHexString:@"666666"];
}

+ (UIColor*) commonLightGrayTextColor{
    return [UIColor colorWithHexString:@"A8A8A8"];
}
@end
