//
//  NSString+VHExt.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/17.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "NSString+VHExt.h"




@implementation NSString (VHExt)

- (BOOL) isEmpty{
    BOOL isEmpty = NO;
    
    isEmpty = (self.length == 0);
    
    return isEmpty;
}

//验证字符串是否是手机号，简单判断
- (BOOL) isMobileNumber{
    BOOL isMobile = NO;
    
    if ([self isEmpty]) {
        return isMobile;
    }
    
    if (self.length != 11) {
        return isMobile;
    }
    
    NSString * regex = @"^1[0-9]{10}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    isMobile = [predicate evaluateWithObject:self];
    
    return isMobile;
}

+ (NSString*) formatWithInteger:(NSInteger) number
                         remain:(NSInteger) remain
                           unit:(NSString*) unit{
    NSString* numberString = [NSString stringWithFormat:@"%ld", number];
    if (number < 10000) {
        return numberString;
    }
    
    CGFloat smallNumber = number/10000.;
    
    NSNumber *ftnumber = @(smallNumber);
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.roundingMode = NSNumberFormatterRoundFloor;
    formatter.maximumFractionDigits = remain;
    numberString = [formatter stringFromNumber:ftnumber];
    numberString = [numberString stringByAppendingString:unit];
    //NSString* formatString = [NSString stringWithFormat:@"%%.%ldf%@",remain, unit];
    //numberString = [NSString stringWithFormat:formatString, smallNumber];
    
    return numberString;
}
@end
