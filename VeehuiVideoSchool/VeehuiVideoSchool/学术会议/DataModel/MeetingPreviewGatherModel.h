//
//  MeetingPreviewGatherModel.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/7.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "EntryModel.h"
#import "MeetingEntryModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MeetingPreviewGatherModel : EntryModel

@property (nonatomic, strong) NSArray<MeetingEntryModel*>* meetings;
@property (nonatomic) NSInteger count;      //共 count 场会议直播预告

@end

NS_ASSUME_NONNULL_END
