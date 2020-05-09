//
//  FavoriteChooseTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/9.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "FavoriteEntryModel.h"
#import "FavoriteChooseTableViewCell.h"

@interface FavoriteChooseCell : UIControl

@property (nonatomic, strong) UIView* favoriteView;
@property (nonatomic, strong) UILabel* nameLabel;

@end

@implementation FavoriteChooseCell

- (id) initWithFavoriteModel:(FavoriteEntryModel*) favorite{
    self = [super init];
    if (self) {
        self.selected = favorite.chosen;
        self.nameLabel.text = favorite.name;
        
        WS(weakSelf)
        [self addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            SAFE_WEAKSELF(weakSelf)
            favorite.chosen = !(favorite.chosen);
            weakSelf.selected = favorite.chosen;
        }];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    [self.favoriteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(2.5, 7.5, 2.5, 7.5));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.favoriteView);
        make.width.lessThanOrEqualTo(self.favoriteView);
    }];
}

#pragma mark - settingAndGetting
- (UIView*) favoriteView{
    if (!_favoriteView) {
        _favoriteView = [self addView];
        [_favoriteView setCornerRadius:17.5];
        _favoriteView.userInteractionEnabled = NO;
    }
    return _favoriteView;
}

- (UILabel*) nameLabel{
    if (!_nameLabel) {
        _nameLabel = [self.favoriteView addLabel:[UIColor commonTextColor] textSize:14];
    }
    return _nameLabel;
}

- (void) setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    if (selected) {
        [self.favoriteView setCornerRadius:17.5 color:[UIColor mainThemeColor] boarderwidth:1];
        self.nameLabel.textColor = [UIColor mainThemeColor];
    }
    else{
        [self.favoriteView setCornerRadius:17.5 color:[UIColor commonBoarderColor] boarderwidth:1];
        self.nameLabel.textColor = [UIColor commonTextColor];
    }
}
@end

@interface FavoriteChooseTableViewCell ()

@property (nonatomic, strong) UIView* chooseview;
@property (nonatomic, strong) NSMutableArray<FavoriteChooseCell*>* cells;

@end

@implementation FavoriteChooseTableViewCell

- (id) initWithFavoriteModel:(FavoriteEntryModel*) favorite{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FavoriteChooseTableViewCell"];
    if (self) {
        [self setEntryModel:favorite];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.chooseview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(5, 15, 5, 15));
    }];
    
    __block MASViewAttribute* cellLeft = self.chooseview.mas_left;
    __block MASViewAttribute* cellTop = self.chooseview.mas_top;
    [self.cells enumerateObjectsUsingBlock:^(FavoriteChooseCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cellLeft);
            make.height.mas_equalTo(@40.);
            make.top.equalTo(cellTop);
            make.width.equalTo(self.chooseview).dividedBy(3.);
            
            if (cell == self.cells.lastObject) {
                make.bottom.equalTo(self.chooseview);
            }
        }];
        
        cellLeft = cell.mas_right;
        if ((idx % 3) == 2) {
            cellLeft = self.chooseview.mas_left;
            cellTop = cell.mas_bottom;
        }
    }];
}
#pragma mark - settingAndGetting
- (UIView*) chooseview{
    if (!_chooseview) {
        _chooseview = [self.contentView addView];
    }
    return _chooseview;
}

- (NSMutableArray<FavoriteChooseCell*>*) cells{
    if (!_cells) {
        _cells = [NSMutableArray<FavoriteChooseCell*> array];
    }
    return _cells;
}

- (void) setEntryModel:(EntryModel *)model{
    if (!model || ![model isKindOfClass:[FavoriteEntryModel class]]) {
        return;
    }
    FavoriteEntryModel* favoriteModel = (FavoriteEntryModel*) model;
    [self.chooseview removeAllSubviews];
    [self.cells removeAllObjects];
    
    [favoriteModel.childrens enumerateObjectsUsingBlock:^(FavoriteEntryModel * _Nonnull favorite, NSUInteger idx, BOOL * _Nonnull stop) {
        FavoriteChooseCell* cell = [[FavoriteChooseCell alloc] initWithFavoriteModel:favorite];
        [self.chooseview addSubview:cell];
        [self.cells addObject:cell];
    }];
    
    [self.contentView setNeedsUpdateConstraints];
}

@end
