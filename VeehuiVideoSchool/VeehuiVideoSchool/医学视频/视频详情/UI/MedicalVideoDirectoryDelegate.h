//
//  MedicalVideoDirectoryDelegate.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MedicalVideoDirectoryDelegate <NSObject>

- (void) medicalVideoDirectoryChanged:(NSInteger) index;

@end

NS_ASSUME_NONNULL_END
