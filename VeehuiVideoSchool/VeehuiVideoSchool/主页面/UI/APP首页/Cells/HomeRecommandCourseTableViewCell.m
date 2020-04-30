//
//  HomeRecommandCourseTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/31.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "HomeRecommandCourseTableViewCell.h"
#import "MedicalVideoGridControl.h"
#import "MedicalVideoGroupInfoEntryModel.h"
#import "MedicalVideoPageRouter.h"

@interface HomeRecommandCourseTableViewCell ()

@property (nonatomic, strong) UIView* detview;
@property (nonatomic, strong) UIView* headerview;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UIButton* moreButton;

@property (nonatomic, strong) NSMutableArray<MedicalVideoGridControl*>* groupGridControls;

@end

@implementation HomeRecommandCourseTableViewCell

- (id) initWithCourseList:(MedicalVideoGroupInfoListModel*) courseList{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeJoinedCircleTableViewCell"];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        [self setEntryModel:courseList];
    }
    return self;
}

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
        //make.height.mas_equalTo(@(detHeight));
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
    
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.headerview);
        make.centerY.equalTo(self.headerview);
    }];
    
    __block MASViewAttribute* controlLeft = self.detview.mas_left;
    __block MASViewAttribute* controlTop = self.headerview.mas_bottom;
    
    [self.groupGridControls enumerateObjectsUsingBlock:^(MedicalVideoGridControl * _Nonnull control, NSUInteger idx, BOOL * _Nonnull stop) {
        [control mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(controlLeft);
            make.top.equalTo(controlTop);
            make.width.equalTo(self.detview).dividedBy(3.);
            //make.height.mas_equalTo(@(controlHeight));
            if (control == self.groupGridControls.lastObject) {
                make.bottom.equalTo(self.detview).offset(-12.5);
            }
        }];
        if ((idx % 3) == 2) {
            controlLeft = self.detview.mas_left;
            controlTop = control.mas_bottom;
        }
        else{
            controlLeft = control.mas_right;
        }
        
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
        _titleLabel.text = @"精品课程";
    }
    return _titleLabel;
}

- (UIButton*) moreButton{
    if (!_moreButton) {
        _moreButton = [self.headerview addButton:UIButtonTypeCustom];
        [_moreButton setTitle:@"更多" forState:UIControlStateNormal];
        [_moreButton setTitleColor:[UIColor mainThemeColor] forState:UIControlStateNormal];
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [_moreButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            //跳转到【精品课程】列表
            [MedicalVideoPageRouter entryMedicalCourseListPage];
        }];
    }
    return _moreButton;
}

- (NSMutableArray<MedicalVideoGridControl*>*) groupGridControls{
    if (!_groupGridControls) {
        _groupGridControls = [NSMutableArray<MedicalVideoGridControl*> array];
    }
    return _groupGridControls;
}

- (void) setEntryModel:(EntryModel *)model{
    if (!model || ![model isKindOfClass:[MedicalVideoGroupInfoListModel class]]) {
        return;
    }
    
    MedicalVideoGroupInfoListModel* listModel = (MedicalVideoGroupInfoListModel*) model;
    [listModel.content enumerateObjectsUsingBlock:^(EntryModel * _Nonnull group, NSUInteger idx, BOOL * _Nonnull stop) {
        MedicalVideoGroupInfoEntryModel* videoGroup = (MedicalVideoGroupInfoEntryModel*) group;
        MedicalVideoGridControl* control = [[MedicalVideoGridControl alloc] initWithVideoGroup:videoGroup];
        
        [control addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [MedicalVideoPageRouter entryMedicalVideoDetailPage:group.id];
        }];
        
        [self.groupGridControls addObject:control];
        [self.detview addSubview:control];
        *stop = (idx >= 5);
    }];
    [self.contentView setNeedsUpdateConstraints];
}

@end
