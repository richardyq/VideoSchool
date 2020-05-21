//
//  InnerCircleBussiness.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InnerCircleBussiness : NSObject

/**
 startLoadInnerInfo
 获取内部机构圈子信息
 @param circleId
 @param result              结果返回回掉
 @param complete            调用完成回调
 */
+ (void) startLoadInnerInfo:(NSInteger) circleId
                     result:(VHRequestResultHandler) result
                   complete:(VHRequestCompleteHandler) complete;
@end

NS_ASSUME_NONNULL_END
