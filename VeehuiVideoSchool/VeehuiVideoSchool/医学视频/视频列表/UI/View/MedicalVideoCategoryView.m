//
//  MedicalVideoCategoryView.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/22.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalVideoCategoryView.h"
#import "MedicalVideoClassifyEntryModel.h"

@interface MedicalVideoCategoryViewCell : UIControl

@property (nonatomic, strong) UILabel* nameLabel;


@end

@implementation MedicalVideoCategoryViewCell

- (id) initWithCategory:(MedicalVideoClassifyEntryModel*) category{
    self = [super init];
    if (self) {
        self.nameLabel.text = category.name;
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

#pragma mark - settingAndGetting

- (UILabel*) nameLabel{
    if (!_nameLabel) {
        _nameLabel = [self addLabel:[UIColor commonTextColor] textSize:13];
    }
    return _nameLabel;
}

- (void) setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    
    if (selected) {
        self.nameLabel.textColor = [UIColor mainThemeColor];
        self.nameLabel.font = [UIFont systemFontOfSize:15];
    }
    else{
        self.nameLabel.textColor = [UIColor commonTextColor];
        self.nameLabel.font = [UIFont systemFontOfSize:13];
    }
}

@end

@interface MedicalVideoCategoryView ()

@property (nonatomic, strong) NSMutableArray<MedicalVideoCategoryViewCell*>* categoryCells;
@property (nonatomic, copy) CategoryViewSelectAction selectAction;

@end

@implementation MedicalVideoCategoryView

- (id) initWithCategories:(NSArray<MedicalVideoClassifyEntryModel*>*) categories
             selectAction:(CategoryViewSelectAction) action{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor commonBackgroundColor];
        [self setupCategoryCells:categories];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    
    __block MASViewAttribute* cellLeft = self.mas_left;
    __block MASViewAttribute* cellTop = self.mas_top;
    [self.categoryCells enumerateObjectsUsingBlock:^(MedicalVideoCategoryViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cellLeft);
            make.top.equalTo(cellTop);
            make.width.equalTo(self).dividedBy(5);
            make.height.mas_equalTo(@45);
            
            if (cell == self.categoryCells.lastObject) {
                make.bottom.equalTo(self);
            }
        }];
        
        cellLeft = cell.mas_right;
        if ((idx % 5) == 4) {
            cellLeft = self.mas_left;
            cellTop = cell.mas_bottom;
        }
        
    }];
}

#pragma mark - settingAndGetting
- (NSMutableArray<MedicalVideoCategoryViewCell*>*) categoryCells{
    if (!_categoryCells) {
        _categoryCells = [NSMutableArray<MedicalVideoCategoryViewCell*> array];
    }
    return _categoryCells;
}

- (void) setupCategoryCells:(NSArray<MedicalVideoClassifyEntryModel*>*) categories{
    [self removeAllSubviews];
    [categories enumerateObjectsUsingBlock:^(MedicalVideoClassifyEntryModel * _Nonnull cate, NSUInteger idx, BOOL * _Nonnull stop) {
        MedicalVideoCategoryViewCell* cell = [[MedicalVideoCategoryViewCell alloc] initWithCategory:cate];
        [self.categoryCells addObject:cell];
        cell.selected = (self.selectedIndex == idx);
        [self addSubview:cell];
        
        [cell addTarget:self action:@selector(categoryCellClicked:) forControlEvents:UIControlEventTouchUpInside];
    }];
}

#pragma mark click event
- (void) categoryCellClicked:(id) sender{
    NSInteger index = [self.categoryCells indexOfObject:sender];
    if (index == NSNotFound) {
        return;
    }
    self.selectedIndex = index;
    [self.categoryCells enumerateObjectsUsingBlock:^(MedicalVideoCategoryViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        cell.selected = (self.selectedIndex == idx);
    }];
    
    if (self.selectAction) {
        self.selectAction(self.selectedIndex);
    }
}

@end
