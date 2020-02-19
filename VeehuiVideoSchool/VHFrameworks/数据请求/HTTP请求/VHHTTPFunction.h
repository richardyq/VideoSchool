//
//  VHHTTPFunction.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, EHTTPRequestMethod) {
    Request_GET,
    Request_POST,
    Request_PUT
};


@interface VHHTTPFunction : NSObject

@property (nonatomic, copy) VHRequestErrorFilter errorFilter;

@property (nonatomic, readonly) NSString* id;

- (void) requestResult:(VHRequestResultHandler) resultHandler
              complete:(VHRequestCompleteHandler) completeHandler;

@end

NS_ASSUME_NONNULL_END
