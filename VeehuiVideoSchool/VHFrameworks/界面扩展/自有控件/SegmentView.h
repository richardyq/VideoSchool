//
//  SegmentView.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/19.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SegmentViewSelectedIndexChanged)(NSInteger index);

@interface SegmentView : UIScrollView

@property (nonatomic) CGFloat minSegmentCellWidth;
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic) CGFloat indicateWidth;

- (id) initWithNormalFont:(UIFont*) normalFont normalColor:(UIColor*) normalColor
                 highFont:(UIFont*) highFont highColor:(UIColor*) highColor;

- (void) setSegmentTitles:(NSArray<NSString*>*) titles;

- (void) onSelectedIndexChanged:(SegmentViewSelectedIndexChanged) action;

@end

NS_ASSUME_NONNULL_END
