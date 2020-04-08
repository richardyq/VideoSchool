//
//  MedicalVideoGroupDetailEntryModel.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/11.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalVideoGroupDetailEntryModel.h"

@implementation MedicalVideoGroupDetailEntryModel

+ (NSDictionary*) mj_replacedKeyFromPropertyName{
    return @{@"desc":@"description"};
}

- (NSInteger) currentPlayIndex{
    if (!self.currentMedicalVideoItem) {
        return NSNotFound;
    }
    
    __block NSInteger playIndex = 0;
    [self.medicalVideoItems enumerateObjectsUsingBlock:^(MedicalVideoEntryModel * _Nonnull videoItem, NSUInteger idx, BOOL * _Nonnull stop) {
        if (videoItem.id == self.currentMedicalVideoItem.id) {
            playIndex = idx;
            *stop = YES;
        }
    }];
    return playIndex;
}
@end
