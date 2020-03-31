//
//  HomeCircleUnTreadedView.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/30.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "HomeCircleUnTreadedView.h"

@interface HomeCircleUnTreadedCell : UIControl

@property (nonatomic, strong) UILabel* nameLabel;
@property (nonatomic) NSInteger code;

@end

@implementation HomeCircleUnTreadedCell

- (id) initWithName:(NSString*) name code:(NSInteger) code{
    self = [self init];
    if (self) {
        self.nameLabel.text = name;
        _code = code;
        
        [self setCornerRadius:3 color:[UIColor colorWithHexString:@"#51B360"] boarderwidth:1];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(7, 7, 7, 7));
    }];
}

#pragma mark - settingAndGetting
- (UILabel*) nameLabel{
    if (!_nameLabel) {
        _nameLabel = [self addLabel:[UIColor colorWithHexString:@"#51B360"] textSize:12];
    }
    return _nameLabel;
}

@end

@interface HomeCircleUnTreadedView ()

@property (nonatomic, strong) NSMutableArray<HomeCircleUnTreadedCell*>* untreadcells;

@end

@implementation HomeCircleUnTreadedView


- (void) updateConstraints{
    [super updateConstraints];
    
    [self layoutUntreadedCell];
}

#pragma mark - settingAndGetting
- (NSMutableArray<HomeCircleUnTreadedCell*>*) untreadcells{
    if (!_untreadcells) {
        _untreadcells = [NSMutableArray<HomeCircleUnTreadedCell*> array];
    }
    return _untreadcells;
}


- (void) setupUntreadedCells:(JoinedCircleEntryModel*) circle{
    if (!circle || ![circle isKindOfClass:[JoinedCircleEntryModel class]]) {
        return;
    }
    [self.untreadcells enumerateObjectsUsingBlock:^(HomeCircleUnTreadedCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        [cell removeFromSuperview];
    }];
    [self.untreadcells removeAllObjects];
    
    if (circle.waitingStudyNumber > 0) {
         HomeCircleUnTreadedCell* cell = [[HomeCircleUnTreadedCell alloc] initWithName:[NSString stringWithFormat:@"待学课程%ld", circle.waitingStudyNumber] code:1];
        [self.untreadcells addObject:cell];
        [self addSubview:cell];
    }
    
    if (circle.waitingExamineNumber > 0) {
         HomeCircleUnTreadedCell* cell = [[HomeCircleUnTreadedCell alloc] initWithName:[NSString stringWithFormat:@"待考课程%ld", circle.waitingExamineNumber] code:3];
        [self.untreadcells addObject:cell];
        [self addSubview:cell];
    }
    
    if (circle.waitingReceiveCreditNumber > 0) {
         HomeCircleUnTreadedCell* cell = [[HomeCircleUnTreadedCell alloc] initWithName:[NSString stringWithFormat:@"学分申请%ld", circle.waitingReceiveCreditNumber] code:4];
        [self.untreadcells addObject:cell];
        [self addSubview:cell];
    }
    
    [self layoutUntreadedCell];
}

- (void) layoutUntreadedCell{
    __block MASViewAttribute* cellLeft = self.mas_left;
    [self.untreadcells enumerateObjectsUsingBlock:^(HomeCircleUnTreadedCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cellLeft).offset(11);
            make.centerY.equalTo(self);
            make.height.mas_equalTo(@25);
        }];
        cellLeft = cell.mas_right;
    }];
}

@end
