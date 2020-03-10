//
//  UITableView+VHExt.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/10.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "UITableView+VHExt.h"


@implementation UITableView (VHExt)

#pragma mark
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint contentOffset = scrollView.contentOffset;
    //CGFloat offsetY = scrollView.contentOffset.y;
    if (!self.dataSource || ![self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        return;
    }
    NSInteger topmostSection = NSNotFound;
    NSInteger sectionCount = [self.dataSource numberOfSectionsInTableView:self];
    for (NSInteger section = 0; section < sectionCount; ++section) {
        CGRect sectionRect = [self rectForSection:section];
        if (CGRectContainsPoint(sectionRect, contentOffset)) {
            topmostSection = section;
            break;
        }
    }
    
    if (topmostSection != NSNotFound) {
        [self tableviewDidScrollToSection:topmostSection];
    }
}

- (void) tableviewDidScrollToSection:(NSInteger) section{
    
}

@end
