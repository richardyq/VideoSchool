//
//  UserLoginTypeView.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/17.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModuleUtil.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^UserLoginTypeHandler)(EUserLoginType loginType);

@interface UserLoginTypeView : UIView

- (id) initWithLoginTypeHandler:(UserLoginTypeHandler) handler;

@end

NS_ASSUME_NONNULL_END
