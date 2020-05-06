//
//  MeetingConferenceTableViewCell.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/30.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHTableViewCell.h"

@class MeetingConferenceModel;
@class MeetingConferenceVideoModel;

NS_ASSUME_NONNULL_BEGIN
@protocol MeetingConferenceTableCellDelegate <NSObject>

- (void) changePlayingVideo:(MeetingConferenceVideoModel*) video;

@end

@interface MeetingConferenceTableViewCell : VHTableViewCell

@property (nonatomic, weak) id<MeetingConferenceTableCellDelegate> delegate;

- (id) initWithConferense:(MeetingConferenceModel*) conference;
- (void) setCurrentVideo:(MeetingConferenceVideoModel*) currentVideo;

@end

NS_ASSUME_NONNULL_END
