//
//  HomeMeetingInfoModel.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/9.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeMeetingInfoModel : EntryModel

@property (nonatomic) NSInteger ortherCount;        //正在直播的其他会场数
@property (nonatomic) NSInteger watchingNumber;     //展示用观看/预约人数

@property (nonatomic, strong) NSString* nextStartTimeInfo;  //下次开始时间
@property (nonatomic, strong) NSString* title;          //标题
@property (nonatomic, strong) NSString* statusCode;     //会议状态编码 ['01':'预告','02':'直播中','03':'休息中','04':'结束']
@property (nonatomic, strong) NSString* organizer;      //主办单位

@end

NS_ASSUME_NONNULL_END
