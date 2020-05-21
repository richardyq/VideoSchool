//
//  InnerCourceFilterMenuView.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/21.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "InnerCourseFilterMenuView.h"

@interface InnerCourseFilterMenuTableViewCell : VHTableViewCell

@property (nonatomic, strong) UILabel* nameLabel;
@property (nonatomic, strong) UIImageView* iconImageView;

@end

@implementation InnerCourseFilterMenuTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(16, 16));
        make.left.equalTo(self.contentView).offset(25.);
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(self.contentView).offset(-35);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.iconImageView.mas_right).offset(7);
        make.right.lessThanOrEqualTo(self.contentView).offset(-12);
    }];
     
}

#pragma settingAndGetting
- (UILabel*) nameLabel{
    if (!_nameLabel) {
        _nameLabel = [self.contentView addLabel:[UIColor commonTextColor] textSize:15];
    }
    return _nameLabel;
}

- (UIImageView*) iconImageView{
    if (!_iconImageView) {
        _iconImageView = [self.contentView addImageView:@"ic_checked"];
    }
    return _iconImageView;
}
 
- (void) setEntryModel:(EntryModel *)model{
    if (!model || ![model isKindOfClass:[InnerCourseFilterEntryModel class]]) {
        return;
    }
    InnerCourseFilterEntryModel* filterModele = (InnerCourseFilterEntryModel*) model;
    self.nameLabel.text = filterModele.title;
    self.iconImageView.hidden = !filterModele.isSelected;
}

@end

@interface InnerCourseFilterMenuView ()
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableview;

@end

@implementation InnerCourseFilterMenuView

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(Navi_height + 53);
        make.height.equalTo(@(self.filterEntryModels.count * 51));
    }];
}

- (void) setupParam:(id) param{
    UIControl* closeControl = (UIControl*)[self addView:[UIControl class]];
    closeControl.backgroundColor = [UIColor clearColor];
    WS(weakSelf)
    [closeControl addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        SAFE_WEAKSELF(weakSelf)
        [weakSelf close:nil];
    }];
    [closeControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    if (!param || ![param isKindOfClass:[InnerCourseFilterEntryModel class]]) {
        return;
    }
    
    InnerCourseFilterEntryModel* selectedFilterModel = (InnerCourseFilterEntryModel*) param;
    [self.filterEntryModels enumerateObjectsUsingBlock:^(InnerCourseFilterEntryModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        model.isSelected = [model.value isEqualToString:selectedFilterModel.value];
    }];
}

#pragma mark - settingAndGetting
- (UITableView*) tableview{
    if (!_tableview) {
        _tableview = (UITableView*)[self addView:[UITableView class]];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.estimatedRowHeight = 45.;
        _tableview.backgroundColor = [UIColor clearColor];
        [_tableview registerClass:[InnerCourseFilterMenuTableViewCell class] forCellReuseIdentifier:[InnerCourseFilterMenuTableViewCell cellReuseIdentifier]];
    }
    return _tableview;
}

- (NSArray<InnerCourseFilterEntryModel*>*) filterEntryModels{
    if (!_filterEntryModels) {
        _filterEntryModels = [self makeFilterEntryModels];
    }
    return _filterEntryModels;
}

- (NSArray<InnerCourseFilterEntryModel*>*) makeFilterEntryModels{
    return [NSMutableArray<InnerCourseFilterEntryModel*> array];
}

#pragma mark - table view datasource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.filterEntryModels.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InnerCourseFilterMenuTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[InnerCourseFilterMenuTableViewCell cellReuseIdentifier]];
    [cell setEntryModel:self.filterEntryModels[indexPath.row]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

#pragma mark - table view delegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self close:self.filterEntryModels[indexPath.row]];
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5;
}

- (UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
}

@end

@implementation InnerCourseStudyFilterMenuView

- (NSArray<InnerCourseFilterEntryModel*>*) makeFilterEntryModels{
    NSMutableArray<InnerCourseFilterEntryModel*>* models = [NSMutableArray<InnerCourseFilterEntryModel*> array];
    [models addObject:[[InnerCourseFilterEntryModel alloc] initWithTitle:@"学习中" value:@"01"]];
    [models addObject:[[InnerCourseFilterEntryModel alloc] initWithTitle:@"已学完" value:@"02"]];
    return models;
}

@end

@implementation InnerCourseSortFilterMenuView

- (NSArray<InnerCourseFilterEntryModel*>*) makeFilterEntryModels{
    NSMutableArray<InnerCourseFilterEntryModel*>* models = [NSMutableArray<InnerCourseFilterEntryModel*> array];
    [models addObject:[[InnerCourseFilterEntryModel alloc] initWithTitle:@"最近加入" value:@"01"]];
    [models addObject:[[InnerCourseFilterEntryModel alloc] initWithTitle:@"最新学习" value:@"02"]];
    return models;
}

@end
