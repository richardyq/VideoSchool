//
//  UserModuleUtil.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/17.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, EUserLoginType) {
    Login_None,
    Login_Wechat,
    Login_Mobile,
};

@interface UserModuleUtil : NSObject

@property (nonatomic, readonly) UserInfoModel* loginedUserModel;
@property (nonatomic, readonly) NSString* userToken;

+ (instancetype)shareInstance;

- (void) saveLoginedUser:(UserInfoModel* _Nullable) userModel;
- (void) userLogout;



@end

NS_ASSUME_NONNULL_END
