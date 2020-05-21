//
//  InnerCircleCourseFilterView.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/21.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "InnerCircleCourseFilterView.h"
#import "InnerCircleCourseFilterCell.h"
#import "InnerCourseFilterMenuView.h"

@interface InnerCircleCourseFilterView ()

@property (nonatomic, strong) NSArray<InnerCircleCourseFilterCell*>* filtercells;
@property (nonatomic, strong) InnerCircleCourseFilterCell* studyCell;       //学习中，已学完
@property (nonatomic, strong) InnerCircleCourseFilterCell* sortCell;        //最近加入，最新学习
@property (nonatomic, strong) InnerCircleCourseFilterCell* cateCell;        //分类

@property (nonatomic, strong) InnerCourseFilterEntryModel* studyFilterModel;
@property (nonatomic, strong) InnerCourseFilterEntryModel* sortFilterModel;

@end

@implementation InnerCircleCourseFilterView

- (id) init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self showBoarder:UIViewBorderLineTypeBottom];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    
    __block MASViewAttribute* cellLeft = self.mas_left;
    __block MASViewAttribute* cellWidth = nil;
    [self.filtercells enumerateObjectsUsingBlock:^(InnerCircleCourseFilterCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(cellLeft);
            if (cell == self.filtercells.lastObject) {
                make.right.equalTo(self);
            }
            if (cellWidth) {
                make.width.equalTo(cellWidth);
            }
        }];
        
        cellWidth = cell.mas_width;
        cellLeft = cell.mas_right;
    }];
}
#pragma mark - settingAndGetting
- (NSArray<InnerCircleCourseFilterCell*>*) filtercells{
    if (!_filtercells) {
        NSMutableArray<InnerCircleCourseFilterCell*>* cells = [NSMutableArray<InnerCircleCourseFilterCell*> array];
        
        [cells addObject:self.studyCell];
        [cells addObject:self.sortCell];
        [cells addObject:self.cateCell];
       
        _filtercells = cells;
    }
    return _filtercells;
}
         
- (InnerCircleCourseFilterCell*) studyCell{
    if (!_studyCell) {
        _studyCell = [[InnerCircleCourseFilterCell alloc] initWithName:@"学习中" iconName:@"ic_arrow_down" highlightIcon:@"ic_arrow_up"];
        [self addSubview:_studyCell];
        
        WS(weakSelf)
        [_studyCell addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
           SAFE_WEAKSELF(weakSelf)
            
            [weakSelf showStudyFilterMenuView];
        }];
    }
    return _studyCell;
}

- (void) showStudyFilterMenuView{
    [self.studyCell setExplanded:YES];
    WS(weakSelf)
    [InnerCourseStudyFilterMenuView showWith:self.studyFilterModel action:^(id ret) {
        SAFE_WEAKSELF(weakSelf)
        [weakSelf.studyCell setExplanded:NO];
        if (!ret) {
            return;
        }
        
        if ([ret isKindOfClass:[InnerCourseFilterEntryModel class]]) {
            InnerCourseFilterEntryModel* model = (InnerCourseFilterEntryModel*) ret;
            if ([model.value isEqualToString:weakSelf.studyFilterModel.value]) {
                return;
            }
            weakSelf.studyFilterModel = ret;
            [weakSelf.studyCell changeName:weakSelf.studyFilterModel.title];
        }
    }];
}

- (InnerCircleCourseFilterCell*) sortCell{
    if (!_sortCell) {
        _sortCell = [[InnerCircleCourseFilterCell alloc] initWithName:@"最近加入" iconName:@"ic_arrow_down" highlightIcon:@"ic_arrow_up"];
        [self addSubview:_sortCell];
        WS(weakSelf)
        [_sortCell addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
           SAFE_WEAKSELF(weakSelf)
            
            [weakSelf showSortFilterMenuView];
        }];
    }
    return _sortCell;
}

- (void) showSortFilterMenuView{
    [self.sortCell setExplanded:YES];
    WS(weakSelf)
    [InnerCourseSortFilterMenuView showWith:self.sortFilterModel action:^(id ret) {
        SAFE_WEAKSELF(weakSelf)
        [weakSelf.sortCell setExplanded:NO];
        if (!ret) {
            return;
        }
        
        if ([ret isKindOfClass:[InnerCourseFilterEntryModel class]]) {
            InnerCourseFilterEntryModel* model = (InnerCourseFilterEntryModel*) ret;
            if ([model.value isEqualToString:weakSelf.sortFilterModel.value]) {
                return;
            }
            weakSelf.sortFilterModel = ret;
            [weakSelf.sortCell changeName:weakSelf.sortFilterModel.title];
        }
    }];
}

- (InnerCircleCourseFilterCell*) cateCell{
    if (!_cateCell) {
        _cateCell = [[InnerCircleCourseFilterCell alloc] initWithName:@"分类" iconName:@"ic_filter_normal" highlightIcon:@"ic_filter_high"];
        [self addSubview:_cateCell];
    }
    return _cateCell;
}

- (InnerCourseFilterEntryModel*) studyFilterModel{
    if (!_studyFilterModel) {
        _studyFilterModel = [[InnerCourseFilterEntryModel alloc] initWithTitle:@"学习中" value:@"01"];
    }
    return _studyFilterModel;
}

- (InnerCourseFilterEntryModel*) sortFilterModel{
    if (!_sortFilterModel) {
        _sortFilterModel = [[InnerCourseFilterEntryModel alloc] initWithTitle:@"最近加入" value:@"01"];
    }
    return _sortFilterModel;
}
@end
