//
//  VHTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/19.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHTableViewCell.h"

@implementation VHTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

#pragma mark - settingAndGetting

+ (NSString*) cellReuseIdentifier{
    return NSStringFromClass([self class]);
}

- (void) setEntryModel:(EntryModel*) model{
    
}
@end
