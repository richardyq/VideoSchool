//
//  VHCollectionViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/3.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHCollectionViewCell.h"

@implementation VHCollectionViewCell

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

+ (NSString*) cellReuseIdentifier{
    return NSStringFromClass([self class]);
}

- (void) setEntryModel:(EntryModel*) model{
    
}
@end
