//
//  MeetingPreviewSectionModel.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/7.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "EntryModel.h"
#import "MeetingEntryModel.h"
#import "MeetingPreviewDayModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MeetingPreviewSectionModel : EntryModel

@property (nonatomic, strong) NSString* code;       //年月
@property (nonatomic, strong) NSString* fullName;   //显示年月
@property (nonatomic) NSInteger index;
@property (nonatomic, strong) NSString* name;       //显示月份

@property (nonatomic, strong) NSArray<MeetingEntryModel*>* meetings;

- (NSArray<MeetingPreviewDayModel*>*) meetingsInDays;

@end

NS_ASSUME_NONNULL_END
