//
//  UserInfoModel.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/17.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoModel : NSObject

#pragma mark - 基本信息
@property (nonatomic,assign) NSInteger id;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *portraitUrl; //
@property (nonatomic,copy) NSString *mobile;

#pragma mark - vip等级信息
@property (nonatomic,assign) NSInteger isVip;
@property (nonatomic,copy) NSString *vipEndTime;
@property (nonatomic,assign) NSInteger vipEndTimeTimeStamp;
/**   vip开始时间  */
@property (nonatomic, copy) NSString *vipStartTime;
/**   vip开始时间戳  */
@property (nonatomic, assign) NSInteger vipStartTimeTimeStamp;
@property (nonatomic, copy) NSString* vipLevelCode;

#pragma mark - 圈子信息
@property (nonatomic,assign) NSInteger circleId; //圈子id
@property (nonatomic,assign) NSInteger isOwner; //是否所有者
@property (nonatomic, copy) NSString *authTypeCode; //01 个人 02 机构 03 已重置
@property (nonatomic, copy) NSString *verifyCode; //个人资料认证状态;认证状态(01 未认证 02-已认证，03-已重置，04-认证中，05-认证失败)
@property (nonatomic,assign) NSInteger isAssistant; //是否是圈子助手
@property (nonatomic,copy) NSString* assistantTypeCode;   //"01" 普通助手  “02”高级助手

#pragma mark - 详细信息
@property (nonatomic,assign) NSInteger isSigned;    //是否已经签到
@property (nonatomic, copy) NSString *department;
@property (nonatomic, copy) NSString *duties;
@property (nonatomic,assign) NSInteger fansCount;
@property (nonatomic,assign) NSInteger followsCount;
@property (nonatomic,assign) NSInteger postingsCount;
@property (nonatomic,assign) NSInteger likeCount;
@property (nonatomic,copy) NSString *organization;
@property (nonatomic,copy) NSString *professional;
@property (nonatomic,copy) NSString *birthday;
@property (nonatomic,copy) NSString *introduction;
@property (nonatomic,assign) NSInteger sex;
@property (nonatomic,copy) NSString *county; //地区
@property (nonatomic,copy) NSString *province; //省
@property (nonatomic,copy) NSString *city; //城市
@end

NS_ASSUME_NONNULL_END
