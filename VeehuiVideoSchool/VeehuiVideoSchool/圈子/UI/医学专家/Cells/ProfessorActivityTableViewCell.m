//
//  ProfessorActivityTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/8.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "ProfessorActivityTableViewCell.h"
#import "CircleInfoEntryModel.h"
#import "CirclePersonControl.h"

@interface ProfessorActivityTableViewCell ()

@property (nonatomic, strong) UIView* detview;
@property (nonatomic, strong) UIView* headerview;
@property (nonatomic, strong) UILabel* titleLabel;

@property (nonatomic, strong) UIScrollView* scrollview;

@property (nonatomic, strong) NSMutableArray<CirclePersonControl*>* circleControls;

@end

@implementation ProfessorActivityTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];

    [self.detview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(7, 12.5, 8, 12.5));
       // make.height.mas_equalTo(@205.);
    }];

    [self.headerview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.detview);
        make.width.equalTo(self.detview).offset(-20);
        make.height.mas_equalTo(@53);
        make.top.equalTo(self.detview);
        //make.bottom.lessThanOrEqualTo(self.detview).offset(-20);
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerview);
        make.centerY.equalTo(self.headerview);
    }];
    
    [self.scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerview.mas_bottom);
        make.left.right.bottom.equalTo(self.detview);
        make.height.mas_equalTo(@155.);
    }];
}

#pragma mark - settingAndGetting

- (UIView*) detview{
    if (!_detview) {
        _detview = [self.contentView addView];
        _detview.backgroundColor = [UIColor whiteColor];
        [_detview setCornerRadius:8];
    }
    return _detview;
}

- (UIView*) headerview{
    if (!_headerview) {
        _headerview = [self.detview addView];
        [_headerview showBoarder:UIViewBorderLineTypeBottom];
    }
    return _headerview;
}

- (UILabel*) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [self.headerview addLabel:[UIColor commonTextColor] textSize:17];
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.text = @"本周活跃专家";
    }
    return _titleLabel;
}

- (UIScrollView*) scrollview{
    if (!_scrollview) {
        _scrollview = (UIScrollView*)[self.detview addView:[UIScrollView class]];
    }
    return _scrollview;
}

- (NSMutableArray<CirclePersonControl*>*) circleControls{
    if (!_circleControls) {
        _circleControls = [NSMutableArray<CirclePersonControl*> array];
    }
    return _circleControls;
}

- (void) setEntryModel:(EntryModel *)model{
    if (!model || ![model isKindOfClass:[CircleInfoEntryList class]]) {
        return;
    }
    
    CircleInfoEntryList* circleList = (CircleInfoEntryList*) model;
    
    [self.scrollview removeAllSubviews];
    [self.circleControls removeAllObjects];
    
    __block CGFloat lastRight = 0;
    [circleList.content enumerateObjectsUsingBlock:^(EntryModel * _Nonnull circle, NSUInteger idx, BOOL * _Nonnull stop) {
        CirclePersonControl* control = [[CirclePersonControl alloc] initWithCircleEntryModel:(CircleInfoEntryModel*)circle];
        [self.scrollview addSubview:control];
        [self.circleControls addObject:control];
        
        [control setFrame:CGRectMake(117 * idx, 0, 117, 155)];
        
        lastRight += 117.;
    }];
    
    [self.scrollview setContentSize:CGSizeMake(lastRight, 115.)];
}
@end
