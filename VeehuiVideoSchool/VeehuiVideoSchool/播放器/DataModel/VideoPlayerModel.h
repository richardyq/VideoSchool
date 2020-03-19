//
//  VideoPlayerModel.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoPlayerModel : NSObject

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* playerUrl;      //播放视频URL

@property (nonatomic) NSInteger startPosition;          //播放起始，单位（s）
@property (nonatomic) NSInteger duration;               //视频总时长
@end

NS_ASSUME_NONNULL_END
