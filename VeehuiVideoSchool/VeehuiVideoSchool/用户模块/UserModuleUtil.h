//
//  UserModuleUtil.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/17.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"
#import "SubjectEntryModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, EUserLoginType) {
    Login_None,
    Login_Wechat,
    Login_Mobile,
};

@interface UserModuleUtil : NSObject

@property (nonatomic, readonly) UserInfoModel* loginedUserModel;
@property (nonatomic, readonly) NSString* userToken;
@property (nonatomic, readonly) NSInteger loginedUserId;

@property (nonatomic, readonly) BOOL mobileBind;    //手机号是否已经绑定
@property (nonatomic, strong) NSArray<SubjectEntryModel*>* favoriteSubject;

+ (instancetype)shareInstance;

- (void) saveLoginedUser:(UserInfoModel* _Nullable) userModel;
- (void) userLogout;
- (void) saveUserToken:(NSString*) userToken;
- (void) saveLoginedUserId:(NSInteger) userId;

@end

NS_ASSUME_NONNULL_END
