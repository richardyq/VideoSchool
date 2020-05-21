//
//  InnerCircleCourseFilterCell.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/21.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InnerCircleCourseFilterCell : UIControl

- (id) initWithName:(NSString*) name iconName:(NSString*) iconName highlightIcon:(NSString*) highIconName;

- (void) changeName:(NSString*) name;

- (void) setExplanded:(BOOL) expland;

@end

NS_ASSUME_NONNULL_END
