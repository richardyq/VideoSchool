//
//  HomeCircleAnnouncementView.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/11.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JoinedCircleEntryModel;

NS_ASSUME_NONNULL_BEGIN

@interface HomeCircleAnnouncementView : UIView

- (void) setupAnnouncements:(JoinedCircleEntryModel*) circleModel;

@end

NS_ASSUME_NONNULL_END
