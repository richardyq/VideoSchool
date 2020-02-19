//
//  VHRequestDefine.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#ifndef VHRequestDefine_h
#define VHRequestDefine_h

typedef void(^VHRequestResultHandler)(id result);
typedef void(^VHRequestCompleteHandler)(NSInteger code, NSString* message);
typedef BOOL(^VHRequestErrorFilter)(NSInteger code);


#define    kURL_BASE_NEWDOMAIN       @"http://apigw-dev.veehui.com/api"

#endif /* VHRequestDefine_h */
