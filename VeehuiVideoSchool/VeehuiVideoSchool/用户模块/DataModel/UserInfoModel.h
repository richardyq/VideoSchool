//
//  UserInfoModel.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/17.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoModel : EntryModel

#pragma mark - 基本信息
//@property (nonatomic,assign) NSInteger id;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *portraitUrl; //
@property (nonatomic,copy) NSString *introduction;  //用户简介
@property (nonatomic,assign) NSInteger sex;

@property (nonatomic, copy) NSString* isBindMobile;
@property (nonatomic, copy) NSString* mobile;

@property (nonatomic,assign) NSInteger circleId; //圈子id
@property (nonatomic,assign) NSInteger fansCount;       //粉丝数
@property (nonatomic,assign) NSInteger followsCount;    //关注数
@property (nonatomic,assign) NSInteger likeCount;       //获赞数
@property (nonatomic,assign) NSInteger postingsCount;   //发帖数
@property (nonatomic, copy) NSString* circleName;
@property (nonatomic, copy) NSString* circlePortraitUrl;

@property (nonatomic,copy) NSString* verifyCode;        //认证状态(01-未认证，02-已认证，03-已重置)4



@end

NS_ASSUME_NONNULL_END
