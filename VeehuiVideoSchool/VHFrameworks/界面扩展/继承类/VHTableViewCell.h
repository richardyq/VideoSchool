//
//  VHTableViewCell.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/19.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VHTableViewCell : UITableViewCell

+ (NSString*) cellReuseIdentifier;

- (void) setEntryModel:(EntryModel*) model;
@end

NS_ASSUME_NONNULL_END
