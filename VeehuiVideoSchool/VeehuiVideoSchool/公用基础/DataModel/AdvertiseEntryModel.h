//
//  AdvertiseEntryModel.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/7.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "EntryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AdvertiseEntryModel : EntryModel

@property (nonatomic, strong) NSString* backgroundColor;
@property (nonatomic, strong) NSString* pictureUrl;
@property (nonatomic) NSInteger productId;          //商品id
@property (nonatomic, strong) NSString typeCode;           //商品类型[01-会员，02-课程，03-会议，04-医学视频，05-圈子]

@end

NS_ASSUME_NONNULL_END
