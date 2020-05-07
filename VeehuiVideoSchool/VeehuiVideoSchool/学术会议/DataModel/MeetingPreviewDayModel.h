//
//  MeetingPreviewDayModel.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/7.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "EntryModel.h"
#import "MeetingEntryModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MeetingPreviewDayModel : EntryModel

@property (nonatomic, strong) NSString* date;
@property (nonatomic, strong) NSMutableArray<MeetingEntryModel*>* meetings;

- (id) initWithDate:(NSString*) date;
@end

NS_ASSUME_NONNULL_END
