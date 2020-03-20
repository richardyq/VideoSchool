//
//  APPVersionInfo.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APPVersionInfo : NSObject

@property (nonatomic, strong) NSString* appTypeCode;        //app类型编码[1-android,2-ios]
@property (nonatomic, strong) NSString* desc;               //描述
@property (nonatomic, strong) NSString* isForce;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* update;             //是否需要更新
@property (nonatomic, strong) NSString* url;                //web地址
@property (nonatomic, strong) NSString* version;
@end

NS_ASSUME_NONNULL_END
