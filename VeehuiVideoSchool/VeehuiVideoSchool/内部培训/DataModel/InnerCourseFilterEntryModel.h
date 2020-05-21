//
//  InnerCourseFilterEntryModel.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/21.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "EntryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface InnerCourseFilterEntryModel : EntryModel

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* value;
@property (nonatomic) BOOL isSelected;

- (id) initWithTitle:(NSString*) title value:(NSString*) value;

@end

NS_ASSUME_NONNULL_END
