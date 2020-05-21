//
//  InnerCircleStartGridTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "InnerCircleStartGridTableViewCell.h"
#import "InnerCirclePageRouter.h"

typedef NS_ENUM(NSUInteger, InnerCircleStartGridIndex) {
    InnerCircleCourse,
    InnerCircleExamine,
    InnerCircleCredits,     //学分
    InnerCircleKnowledge,
    InnerCircleList,        //排行
};

@interface InnerCircleStartGridTableViewCell ()

@property (nonatomic, strong) UIView* gridview;
@property (nonatomic, strong) NSArray<VHGridItemControl*>* gridControls;

@end

@implementation InnerCircleStartGridTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.gridview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@80.);
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(9, 16, 9, 16)) ;
    }];
    
    __block MASViewAttribute* gridLeft = self.gridview.mas_left;
    __block MASViewAttribute* gridWidth = nil;
    [self.gridControls enumerateObjectsUsingBlock:^(VHGridItemControl * _Nonnull grid, NSUInteger idx, BOOL * _Nonnull stop) {
        [grid mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(gridLeft);
            //make.top.bottom.equalTo(self.gridview);
            make.top.equalTo(self.gridview).offset(6);
            make.bottom.equalTo(self.gridview);
            if (grid == self.gridControls.lastObject) {
                make.right.equalTo(self.gridview);
            }
            if (gridWidth) {
                make.width.equalTo(gridWidth);
            }
        }];
        gridWidth = grid.mas_width;
        gridLeft = grid.mas_right;
    }];
}

#pragma mark - settingAndGetting
- (UIView*) gridview{
    if (!_gridview) {
        _gridview = [self.contentView addView];
        _gridview.backgroundColor = [UIColor whiteColor];
        [_gridview.layer setCornerRadius:4];
        _gridview.layer.shadowOffset = CGSizeMake(0,-1);
        _gridview.layer.shadowOpacity = 1;
        _gridview.layer.shadowRadius = 4;
        _gridview.layer.shadowColor = [UIColor colorWithHexString:@"#3376FD"].CGColor;
    }
    return _gridview;
}

- (NSArray<VHGridItemControl*>*) gridControls{
    if (!_gridControls) {
        NSMutableArray<VHGridItemControl*>* gridsControls = [NSMutableArray<VHGridItemControl*> array];
        NSArray<NSString*>* titles = @[@"课程", @"考试", @"学分", @"知识库", @"排行榜"];
        NSArray<NSString*>* iconNames = @[@"ic_inner_circle_grid_course",
                                          @"ic_inner_circle_grid_examine",
                                          @"ic_inner_circle_grid_credits",
                                          @"ic_inner_circle_grid_knowledge",
                                          @"ic_inner_circle_grid_list"];
        [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull name, NSUInteger idx, BOOL * _Nonnull stop) {
            VHGridItemControl* gridControl = [[VHGridItemControl alloc] initWithImageName:iconNames[idx] name:name];
            [gridsControls addObject:gridControl];
            [self.gridview addSubview:gridControl];
            gridControl.tag = 0x100 + idx;
            [gridControl addTarget:self action:@selector(gridItemClicked:) forControlEvents:UIControlEventTouchUpInside];
        }];
        _gridControls = gridsControls;
    }
    return _gridControls;
}

#pragma mark - grid event
- (void) gridItemClicked:(id) sender{
    VHGridItemControl* gridControl = (VHGridItemControl*) sender;
    if (![gridControl isKindOfClass:[VHGridItemControl class]]) {
        return;
    }
    
    NSInteger index = gridControl.tag - 0x100;
    switch (index) {
        case InnerCircleCourse:{
            //培训课程列表
            [InnerCirclePageRouter entryInnerCircleCoursesPage:CourseTypeAll];
            break;
        }
        default:
            break;
    }
}
@end
