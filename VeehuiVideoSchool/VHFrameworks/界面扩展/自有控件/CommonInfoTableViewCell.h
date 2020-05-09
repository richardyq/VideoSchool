//
//  CommonInfoTableViewCell.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/8.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHTableViewCell.h"

@interface CommonInfoModel : EntryModel

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* value;
@property (nonatomic, strong) NSString* placeholder;

@end

NS_ASSUME_NONNULL_BEGIN

@interface CommonInfoTableViewCell : VHTableViewCell

@property (nonatomic, strong) UILabel* nameLabel;
@property (nonatomic, strong) UILabel* valueLabel;

@end

NS_ASSUME_NONNULL_END
