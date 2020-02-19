//
//  HomeStartGirdTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/19.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "HomeStartGirdTableViewCell.h"

@interface HomeStartGridItemControl : VHGridItemControl

@end

@implementation HomeStartGridItemControl

- (UILabel*) buildNameLabel{
    UILabel* nameLabel = [self addLabel:[UIColor commonTextColor] textSize:12];
    nameLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
    return nameLabel;
}

- (CGSize) iconImageSize{
    return CGSizeMake(45, 45);
}

- (CGFloat) iconTopOffset{
    return 6;
}

- (CGFloat) nameTopOffset{
    return 7;
}

- (CGFloat) nameBottomOffset{
    return 8;
}

@end

@interface HomeStartGirdTableViewCell ()

@property (nonatomic, strong) UIView* gridView;
@property (nonatomic, strong) NSArray<HomeStartGridItemControl*>* gridItems;

@property (nonatomic, copy) HomeStartGirdAction gridAction;
@end

@implementation HomeStartGirdTableViewCell

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.gridView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 5, 0, 5));
    }];
    
    __block MASViewAttribute* gridLeft = self.gridView.mas_left;
    __block MASViewAttribute* gridWidth = nil;
    [self.gridItems enumerateObjectsUsingBlock:^(HomeStartGridItemControl * _Nonnull gridItem, NSUInteger idx, BOOL * _Nonnull stop) {
        [gridItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(gridLeft);
            make.top.bottom.equalTo(self.gridView);
            if (gridWidth) {
                make.width.equalTo(gridWidth);
            }
            
            if (gridItem == self.gridItems.lastObject) {
                make.right.equalTo(self.gridView);
            }
        }];
        
        gridWidth = gridItem.mas_width;
        gridLeft = gridItem.mas_right;
    }];
}

- (void) onGridAction:(HomeStartGirdAction) action{
    self.gridAction = action;
}

#pragma mark - settingAndGetting

- (UIView*) gridView{
    if (!_gridView) {
        _gridView = [self.contentView addView];
    }
    return _gridView;
}

- (NSArray<HomeStartGridItemControl*>*) gridItems{
    if (!_gridItems) {
        NSMutableArray<HomeStartGridItemControl*>* gridItems = [NSMutableArray<HomeStartGridItemControl*> array];
        
        NSArray<NSString*>* gridNames = @[@"学术会议", @"医学视频", @"精品课程", @"学分专区", @"医学学科"];
        NSArray<NSString*>* gridIconNames = @[@"img_home_gird_meeting",
                                             @"img_home_gird_video",
                                             @"img_home_gird_course",
                                             @"img_home_gird_score",
                                             @"img_home_gird_subjects"];
        
        [gridNames enumerateObjectsUsingBlock:^(NSString * _Nonnull name, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString* iconName = gridIconNames[idx];
            HomeStartGridItemControl* item = [[HomeStartGridItemControl alloc] initWithImageName:iconName name:name];
            [gridItems addObject:item];
            [self.gridView addSubview:item];
            
            [item addTarget:self action:@selector(girItemClickedAction:) forControlEvents:UIControlEventTouchUpInside];
            
        }];
        _gridItems = gridItems;
    }
    return _gridItems;
}

#pragma mark grid events
- (void) girItemClickedAction:(id) sender{
    NSInteger index = [self.gridItems indexOfObject:sender];
    if (index == NSNotFound) {
        return;
    }
    
    if (self.gridAction) {
        self.gridAction(index);
    }
    
    return;
}

@end
