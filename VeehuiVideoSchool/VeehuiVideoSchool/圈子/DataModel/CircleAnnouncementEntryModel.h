//
//  CircleAnnouncementEntryModel.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/11.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "EntryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CircleAnnouncementEntryModel : EntryModel

@property (nonatomic, strong) NSString* content;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* publishTime;
@property (nonatomic, strong) NSString* fullContent;

@end

NS_ASSUME_NONNULL_END
