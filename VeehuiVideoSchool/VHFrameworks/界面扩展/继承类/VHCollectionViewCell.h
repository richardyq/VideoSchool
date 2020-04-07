//
//  VHCollectionViewCell.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/3.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VHCollectionViewCell : UICollectionViewCell

+ (NSString*) cellReuseIdentifier;

- (void) setEntryModel:(EntryModel*) model;

@end

NS_ASSUME_NONNULL_END
