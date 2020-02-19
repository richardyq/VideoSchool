//
//  WechatAuthRespModel.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WechatAuthRespModel : NSObject

@property (nonatomic, readonly) NSString* openid;
@property (nonatomic, readonly) NSString* accessToken;
@property (nonatomic, readonly) NSString* unionId;

- (id) initWithOpenId:(NSString*) openId accessToken:(NSString*) accessToken unionId:(NSString*) unionId;

@end

NS_ASSUME_NONNULL_END
