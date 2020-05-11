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
@property (nonatomic, strong) UILabel* valueLabel;
@property (nonatomic) NSInteger code;

@property (nonatomic, strong) UIView* rightLine;

- (id) initWithName:(NSString*) name value:(NSString*) value code:(NSInteger) code;

@end

@implementation HomeCircleUnTreadedCell

- (id) initWithName:(NSString*) name value:(NSString*) value code:(NSInteger) code{
    self = [self init];
    if (self) {
        self.nameLabel.text = name;
        self.valueLabel.text = value;
        _code = code;
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(8);
    }];
    
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.nameLabel.mas_bottom);
        make.bottom.equalTo(self).offset(-8);
    }];
    
    [self.rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.width.mas_equalTo(@1);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(@22);
    }];
}

- (void) showRightLine{
    self.rightLine.hidden = NO;
}

#pragma mark - settingAndGetting
- (UILabel*) nameLabel{
    if (!_nameLabel) {
        _nameLabel = [self addLabel:[UIColor commonGrayTextColor] textSize:12];
    }
    return _nameLabel;
}

- (UILabel*) valueLabel{
    if (!_valueLabel) {
        _valueLabel = [self addLabel:[UIColor commonTextColor] textSize:18 weight:UIFontWeightBold];
    }
    return _valueLabel;
}

- (UIView*) rightLine{
    if (!_rightLine) {
        _rightLine = [self addView];
        _rightLine.backgroundColor = [UIColor commonBoarderColor];
        _rightLine.hidden = YES;
    }
    return _rightLine;
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
    
    HomeCircleUnTreadedCell* cell = [[HomeCircleUnTreadedCell alloc] initWithName:@"必学课程" value:[NSString stringWithFormat:@"%ld", circle.requiredCourseCount] code:1];
    [self.untreadcells addObject:cell];
    [self addSubview:cell];
    [cell showRightLine];
    
    cell = [[HomeCircleUnTreadedCell alloc] initWithName:@"选学课程" value:[NSString stringWithFormat:@"%ld", circle.electiveCourseCount] code:1];
    [self.untreadcells addObject:cell];
    [self addSubview:cell];
    [cell showRightLine];
    
    cell = [[HomeCircleUnTreadedCell alloc] initWithName:@"待考课程" value:[NSString stringWithFormat:@"%ld", circle.toBeTestedCourseCount] code:1];
    [self.untreadcells addObject:cell];
    [self addSubview:cell];
    [cell showRightLine];
    
    cell = [[HomeCircleUnTreadedCell alloc] initWithName:@"学分申请" value:[NSString stringWithFormat:@"%ld", circle.toBeApplyCreditCourseCount] code:1];
    [self.untreadcells addObject:cell];
    [self addSubview:cell];
    
    [self layoutUntreadedCell];
}

- (void) layoutUntreadedCell{
    __block MASViewAttribute* cellLeft = self.mas_left;
    __block MASViewAttribute* cellWidth = nil;
    [self.untreadcells enumerateObjectsUsingBlock:^(HomeCircleUnTreadedCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cellLeft);
            make.centerY.equalTo(self);
            if (cellWidth) {
                make.width.equalTo(cellWidth);
            }
            if (cell == self.untreadcells.lastObject) {
                make.right.equalTo(self);
            }
        }];
        cellLeft = cell.mas_right;
        cellWidth = cell.mas_width;
    }];
}

@end
