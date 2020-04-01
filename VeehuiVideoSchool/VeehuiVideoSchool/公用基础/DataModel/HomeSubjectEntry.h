//
//  HomeSubjectEntry.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/1.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "EntryModel.h"
#import "MedicalVideoGroupInfoEntryModel.h"
#import "MeetingEntryModel.h"
#import "SubjectEntryModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeSubjectEntry : EntryModel

@property (nonatomic, strong) NSArray<MeetingEntryModel*>* meetingInfos;     //会议
@property (nonatomic, strong) NSArray<MedicalVideoGroupInfoEntryModel*>* lengthwaysMedicalVideos;       //纵向展示视频
@property (nonatomic, strong) NSArray<MedicalVideoGroupInfoEntryModel*>* transverseMedicalVideos;       //横向展示视频
@property (nonatomic, strong) SubjectEntryModel* subject;

@end

@interface HomeSubjectListModel : ListModel

@end

NS_ASSUME_NONNULL_END
