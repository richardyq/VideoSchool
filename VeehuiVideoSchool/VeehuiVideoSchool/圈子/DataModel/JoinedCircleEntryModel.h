//
//  JoinedCircleEntryModel.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/30.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "EntryModel.h"
#import "CircleAnnouncementEntryModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface JoinedCircleMeetingModel : NSObject<NSCoding>

@property (nonatomic, strong) NSString* statusCode;
@property (nonatomic, strong) NSString* pictureUrl;
@property (nonatomic) NSInteger countdown;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* orgnazition;
@property (nonatomic, assign) NSInteger watchingNumber;
@property (nonatomic) NSInteger id;

@end

@interface JoinedCircleVideoGroupModel : NSObject<NSCoding>

@property (nonatomic) NSInteger id;
@property (nonatomic, strong) NSString* createTime;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* portraitUrl;
@property (nonatomic) NSInteger permission;
@end


@interface JoinedCircleEntryModel : EntryModel<NSCoding>

@property (nonatomic, strong) JoinedCircleMeetingModel* circleMeetingInfo;
@property (nonatomic, strong) NSArray<JoinedCircleVideoGroupModel*>* circleMvgInfos;
@property (nonatomic, strong) NSArray<CircleAnnouncementEntryModel*>* circleAnnouncements;

@property (nonatomic) NSInteger circleId;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* circleName;
@property (nonatomic, strong) NSString* portraitUrl;
@property (nonatomic) NSInteger haveWaitingProcess;
@property (nonatomic) NSInteger requiredCourseCount;      //必学课程
@property (nonatomic) NSInteger electiveCourseCount;       //选学课程
@property (nonatomic) NSInteger toBeTestedCourseCount;     //待考课程
@property (nonatomic) NSInteger toBeApplyCreditCourseCount;       //学分申请
@property (nonatomic, strong) NSString* introduction;

@end

NS_ASSUME_NONNULL_END
