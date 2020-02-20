//
//  SegmentView.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/19.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "SegmentView.h"

@interface SegmentCell : UIControl

@property (nonatomic, strong) UILabel* nameLabel;

@property (nonatomic, readonly) UIFont* normalFont;
@property (nonatomic, readonly) UIFont* highFont;

@property (nonatomic, readonly) UIColor* normalColor;
@property (nonatomic, readonly) UIColor* highColor;

@property (nonatomic, strong) NSString* text;
 
@end

@implementation SegmentCell

- (void) updateConstraints{
    [super updateConstraints];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.lessThanOrEqualTo(self);
    }];
}

- (id) initWithNormalFont:(UIFont*) normalFont normalColor:(UIColor*) normalColor
                 highFont:(UIFont*) highFont highColor:(UIColor*) highColor{
    self = [super init];
    if (self) {
        _normalFont = normalFont;
        _normalColor = normalColor;
        _highFont = highFont;
        _highColor = highColor;
    }
    return self;
}

#pragma mark - settingAndGetting
- (UILabel*) nameLabel{
    if (!_nameLabel) {
        _nameLabel = [self addLabel];
    }
    return _nameLabel;
}

- (void) setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    if (selected) {
        self.nameLabel.textColor = self.highColor;
        self.nameLabel.font = self.highFont;
    }
    else{
        self.nameLabel.textColor = self.normalColor;
        self.nameLabel.font = self.normalFont;
    }
}

- (void) setText:(NSString *)text{
    self.nameLabel.text = text;
}

- (NSString*) text{
    return self.nameLabel.text;
}
@end

@interface SegmentView ()

@property (nonatomic, strong) UIView* contentView;

@property (nonatomic, strong) NSMutableArray<SegmentCell*>* segmentCells;

@property (nonatomic, readonly) UIFont* normalFont;
@property (nonatomic, readonly) UIFont* highFont;

@property (nonatomic, readonly) UIColor* normalColor;
@property (nonatomic, readonly) UIColor* highColor;

@property (nonatomic, strong) UIView* indicateView;

@property (nonatomic, copy) SegmentViewSelectedIndexChanged changeHandler;
@end

@implementation SegmentView
- (id) initWithNormalFont:(UIFont*) normalFont normalColor:(UIColor*) normalColor
                 highFont:(UIFont*) highFont highColor:(UIColor*) highColor{
    self = [super init];
    if (self) {
        _normalFont = normalFont;
        _normalColor = normalColor;
        _highFont = highFont;
        _highColor = highColor;
        
        [self showBoarder:UIViewBorderLineTypeBottom];
    }
    return self;
}


- (void) updateConstraints{
    [super updateConstraints];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self);
    }];
    
    [self.indicateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(@3);
    }];
}

- (void) onSelectedIndexChanged:(SegmentViewSelectedIndexChanged) action{
    _changeHandler = action;
}

- (void) setSegmentTitles:(NSArray<NSString*>*) titles{
    
    if (!titles || titles.count == 0) {
        return;
    }
    
    [self.segmentCells enumerateObjectsUsingBlock:^(SegmentCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        [cell removeFromSuperview];
    }];
    [self.segmentCells removeAllObjects];
    
    [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
        SegmentCell* cell = [[SegmentCell alloc] initWithNormalFont:self.normalFont normalColor:self.normalColor highFont:self.highFont highColor:self.highColor];
        [self.contentView addSubview:cell];
        cell.text = title;
        [self.segmentCells addObject:cell];
        [cell addTarget:self action:@selector(segmentCellClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selected = (idx == self.selectedIndex);
    }];
    
    __block MASViewAttribute* cellLeft = self.contentView.mas_left;
    __block MASViewAttribute* cellWidth = nil;
    __block SegmentCell* highCell = nil;
    [self.segmentCells enumerateObjectsUsingBlock:^(SegmentCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-1.);
            make.left.equalTo(cellLeft);
            if (cellWidth) {
                make.width.equalTo(cellWidth);
            }
            if (self.minSegmentCellWidth > 0) {
                make.width.mas_greaterThanOrEqualTo(@(self.minSegmentCellWidth));
            }
            if (self.segmentCells.lastObject == cell) {
                make.right.equalTo(self.contentView);
            }
            
            if (idx == self.selectedIndex) {
                highCell = cell;
            }
        }];
        cellLeft = cell.mas_right;
        cellWidth = cell.mas_width;
    }];
    
    self.showsHorizontalScrollIndicator = NO;
    [self performSelector:@selector(resetContentSize) afterDelay:0.08];
    
    [self.indicateView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(@3);
        
        if (self.indicateWidth == 0) {
            make.width.equalTo(self.segmentCells.firstObject);
        }
        else{
            make.width.mas_equalTo(@(self.indicateWidth));
        }
        
        if (highCell) {
            make.centerX.equalTo(highCell);
        }
    }];
}

- (void) resetContentSize{
    self.contentSize = self.contentView.size;
}

#pragma mark - settingAndGetting
- (UIView*) contentView{
    if (!_contentView) {
        _contentView = [self addView:[UIView class] frame:CGRectMake(0, 0, kScreenWidth, 47)];
        [_contentView showBoarder:UIViewBorderLineTypeBottom];
    }
    return _contentView;
}

- (UIView*) indicateView{
    if (!_indicateView) {
        _indicateView = [self.contentView addView];
        _indicateView.backgroundColor = self.highColor;
    }
    return _indicateView;
}

- (NSMutableArray<SegmentCell*>*) segmentCells{
    if (!_segmentCells) {
        _segmentCells = [NSMutableArray<SegmentCell*> array];
    }
    return _segmentCells;
}

- (void) setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    
    [self.segmentCells enumerateObjectsUsingBlock:^(SegmentCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        cell.selected = (idx == self.selectedIndex);
    }];
    [self moveIndicateView];
}

#pragma mark - segment cell event
- (void) segmentCellClicked:(id) sender{
    NSInteger index = [self.segmentCells indexOfObject:sender];
    if (index == NSNotFound) {
        return;
    }
    if (index == self.selectedIndex) {
        return;
    }
    _selectedIndex = index;
    
    [self.segmentCells enumerateObjectsUsingBlock:^(SegmentCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        cell.selected = (idx == self.selectedIndex);
    }];
    
    [self moveIndicateView];
    if (self.changeHandler) {
        self.changeHandler(index);
    }
}

#pragma mark - 指示器变化
- (void) moveIndicateView{
    __block SegmentCell* highCell = nil;
    [self.segmentCells enumerateObjectsUsingBlock:^(SegmentCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == self.selectedIndex) {
            highCell = cell;
            *stop = YES;
        }
    }];
    if (!highCell) {
        return;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.indicateView.centerX = highCell.centerX;
    }];
}

@end
