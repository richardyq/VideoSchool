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
@property (nonatomic, strong) UIControl* moreView;
@property (nonatomic, strong) UILabel* moreLabel;

@property (nonatomic, strong) NSMutableArray<MedicalVideoGridControl*>* groupGridControls;

@end

@implementation HomeRecommandCourseTableViewCell

- (id) initWithCourseList:(MedicalVideoGroupInfoListModel*) courseList{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeRecommandCourseTableViewCell"];
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
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(7, 8, 8, 8));
        //make.height.mas_equalTo(@(detHeight));
    }];
    
    [self.headerview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.detview);
        make.width.equalTo(self.detview).offset(-20);
        make.height.mas_equalTo(@49);
        make.top.equalTo(self.detview);
        //make.bottom.lessThanOrEqualTo(self.detview).offset(-20);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerview);
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
//            if (control == self.groupGridControls.lastObject) {
//                make.bottom.equalTo(self.moreView);
//            }
        }];
        if ((idx % 3) == 2) {
            controlLeft = self.detview.mas_left;
            controlTop = control.mas_bottom;
        }
        else{
            controlLeft = control.mas_right;
        }
        
    }];
    
    [self.moreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.detview);
        make.top.equalTo(self.groupGridControls.lastObject.mas_bottom);
    }];
    
    [self.moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.moreView).insets(UIEdgeInsetsMake(8, 16, 16, 16));
        make.height.mas_equalTo(@45);
    }];
     
}
#pragma mark - settingAndGetting
- (UIView*) detview{
    if (!_detview) {
        _detview = [self.contentView addView];
        _detview.backgroundColor = [UIColor whiteColor];
        [_detview.layer setCornerRadius:8];
        
        // 阴影颜色
        _detview.layer.shadowColor = [UIColor commonBoarderColor].CGColor;
        _detview.layer.shadowOffset = CGSizeMake(0,0);
        // 阴影透明度
        _detview.layer.shadowOpacity = 0.5;
        // 阴影半径
        _detview.layer.shadowRadius = 1;
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
        _titleLabel = [self.headerview addLabel:[UIColor colorWithHexString:@"#080808"] textSize:17 weight:UIFontWeightMedium];
        _titleLabel.text = @"精品课程";
    }
    return _titleLabel;
}

- (UIControl*) moreView{
    if (!_moreView) {
        _moreView = (UIControl*)[self.detview addView:[UIControl class]];
    }
    return _moreView;
}

- (UILabel*) moreLabel{
    if (!_moreLabel) {
        _moreLabel = [self.moreView addLabel:[UIColor mainThemeColor] textSize:15];
        _moreLabel.text = @"查看全部 >";
        _moreLabel.backgroundColor = [UIColor commonBackgroundColor];
        [_moreLabel setCornerRadius:4];
        _moreLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _moreLabel;
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
