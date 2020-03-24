//
//  VHPopView.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/24.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PopViewAction)(id ret);
NS_ASSUME_NONNULL_BEGIN

@interface VHPopView : UIView

@property (nonatomic, copy) PopViewAction action;

+ (void) showWith:(id) param action:(PopViewAction) action;

- (void) close:(id) ret;
@end

NS_ASSUME_NONNULL_END
