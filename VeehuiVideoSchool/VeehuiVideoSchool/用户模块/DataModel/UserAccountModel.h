//
//  UserAccountModel.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserAccountModel : NSObject

@property (nonatomic) NSInteger userId;
@property (nonatomic) BOOL isNew;
@property (nonatomic, strong) NSString* token;
@property (nonatomic, strong) NSString* wxopen_secret;

@end

NS_ASSUME_NONNULL_END
