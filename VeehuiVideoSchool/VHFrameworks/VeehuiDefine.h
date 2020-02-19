//
//  VeehuiDefine.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/17.
//  Copyright © 2020 殷全. All rights reserved.
//

#ifndef VeehuiDefine_h
#define VeehuiDefine_h

#define isPhoneX \
({BOOL isphoneX = NO;\
if (@available(iOS 11.0, *)) {\
isphoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isphoneX);})

#define PhoneXBottom   (isPhoneX?20:0)


//arc
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define SAFE_WEAKSELF(weakSelf)   if (!weakSelf) {\
return ;    \
}

#define Navi_height         (isPhoneX ? 88 : 64)
#define Status_Height       (isPhoneX ? 44 : 20)

#endif /* VeehuiDefine_h */
