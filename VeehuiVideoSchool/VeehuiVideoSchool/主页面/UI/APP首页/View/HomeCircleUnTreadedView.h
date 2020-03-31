//
//  HomeCircleUnTreadedView.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/30.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JoinedCircleEntryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeCircleUnTreadedView : UIView

- (void) setupUntreadedCells:(JoinedCircleEntryModel*) circle;
@end

NS_ASSUME_NONNULL_END
