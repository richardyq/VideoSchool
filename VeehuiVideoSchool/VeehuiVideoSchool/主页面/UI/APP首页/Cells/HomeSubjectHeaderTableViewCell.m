//
//  HomeSubjectHeaderTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/1.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "HomeSubjectHeaderTableViewCell.h"
#import "HomeSubjectEntry.h"
#import "MedicalVideoGridControl.h"
#import "MedicalVideoPageRouter.h"
#import "MedicalVideoGroupInfoEntryModel.h"
#import "MedicalVideoClassifyEntryModel.h"

@interface HomeSubjectHeaderTableViewCell ()

@property (nonatomic, strong) UIView* detview;

@property (nonatomic, strong) UIView* headerview;
@property (nonatomic, strong) UILabel* titleLabel;

@property (nonatomic, strong) NSMutableArray<MedicalVideoGridControl*>* groupGridControls;

@property (nonatomic, strong) UIControl* moreView;
@property (nonatomic, strong) UILabel* moreLabel;
@end

@implementation HomeSubjectHeaderTableViewCell

- (id) initWithSubjectEntry:(HomeSubjectEntry*) subjectEntry{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeSubjectHeaderTableViewCell"];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        [self setEntryModel:subjectEntry];
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
        }];
        controlLeft = control.mas_right;
        
    }];
    
    [self.moreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.detview);
        make.top.equalTo(self.groupGridControls.lastObject.mas_bottom).offset(4);
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
        _titleLabel = [self.headerview addLabel:[UIColor commonTextColor] textSize:17 weight:UIFontWeightMedium];
    }
    return _titleLabel;
}

- (NSMutableArray<MedicalVideoGridControl*>*) groupGridControls{
    if (!_groupGridControls) {
        _groupGridControls = [NSMutableArray<MedicalVideoGridControl*> array];
    }
    return _groupGridControls;
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

- (void) setEntryModel:(EntryModel *)model{
    if (!model || ![model isKindOfClass:[HomeSubjectEntry class]]) {
        return;
    }
    
    HomeSubjectEntry* subjectModel = (HomeSubjectEntry*) model;
    self.titleLabel.text = subjectModel.subject.name;
    
    /*
    [self.moreButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        MedicalVideoClassifyEntryModel* classifyModel = [MedicalVideoClassifyEntryModel new];
        classifyModel.code = subjectModel.subject.subjectCode;
        classifyModel.name = subjectModel.subject.name;
        [MedicalVideoPageRouter entryClassifiedMedicalVideListPage:classifyModel];
    }];
     */
    [self.moreView addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        MedicalVideoClassifyEntryModel* classifyModel = [MedicalVideoClassifyEntryModel new];
        classifyModel.code = subjectModel.subject.subjectCode;
        classifyModel.name = subjectModel.subject.name;
        [MedicalVideoPageRouter entryClassifiedMedicalVideListPage:classifyModel];
    }];
    
    [subjectModel.transverseMedicalVideos enumerateObjectsUsingBlock:^(EntryModel * _Nonnull group, NSUInteger idx, BOOL * _Nonnull stop) {
        MedicalVideoGroupInfoEntryModel* videoGroup = (MedicalVideoGroupInfoEntryModel*) group;
        MedicalVideoGridControl* control = [[MedicalVideoGridControl alloc] initWithVideoGroup:videoGroup];
        [self.groupGridControls addObject:control];
        [self.detview addSubview:control];
        [control addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [MedicalVideoPageRouter entryMedicalVideoDetailPage:group.id];
        }];
        *stop = (idx >= 2);
    }];
    [self.contentView setNeedsUpdateConstraints];
}
@end
