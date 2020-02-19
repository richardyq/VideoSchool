//
//  MedicalVideoListBussiness.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/19.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MedicalVideoListBussiness : NSObject

/**
 startLoadMediaclVideoClassify
 获取医学视频分类列表
 @param result          result 请求数据结果返回回调方法
 @param complete        complete 请求结束回调方法
 */
+ (void) startLoadMediaclVideoClassify:(VHRequestResultHandler) result
                              complete:(VHRequestCompleteHandler) complete;

@end

NS_ASSUME_NONNULL_END
