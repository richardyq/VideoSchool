//
//  MedicalVideoStartViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/19.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalVideoStartViewController.h"
#import "MedicalVideoListBussiness.h"
#import "MedicalVideoClassifyEntryModel.h"
#import "MedicalVideoInfoTableViewCell.h"
#import "MedicalVideoPageRouter.h"
#import "AdvertiseEntryModel.h"
#import "MedicalStartGridTableViewCell.h"
#import "CommonBaseBussiness.h"
#import "MedicalVideoClassifyEntryModel.h"
#import "MedicalStartVideoSegmentTableViewCell.h"
#import "MedicalVideoStartRecommadCourseTableViewCell.h"
#import "MedicalVideoCategoryView.h"

typedef NS_ENUM(NSUInteger, MedicalVideoStartTableSection) {
    Grid_Section,
    Subjects_Section,
    Course_Section,
    SectionCount,
};

@interface MedicalVideoStartViewController ()
<UITableViewDelegate, UITableViewDataSource,
SDCycleScrollViewDelegate>

@property (nonatomic, strong) UIView* tableviewHeaderView;
@property (nonatomic, strong) SDCycleScrollView* advertiseView;

@property (nonatomic, strong) NSArray<AdvertiseEntryModel*>* advertiseModels;
@property (nonatomic, strong) NSArray<MedicalVideoClassifyEntryModel*>* seniorSubjects;

@property (nonatomic, strong) MedicalVideoCategoryView* categoryView;
@property (nonatomic, strong) MedicalVideoGroupInfoListModel* recommandCourseList;

@end


@implementation MedicalVideoStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"医学视频";
    [self.tableview setTableHeaderView:self.tableviewHeaderView];
    self.tableview.backgroundColor = [UIColor commonBackgroundColor];
    
    [self.tableview registerClass:[MedicalStartGridTableViewCell class] forCellReuseIdentifier:[MedicalStartGridTableViewCell cellReuseIdentifier]];
    [self.tableview registerClass:[MedicalStartVideoSegmentTableViewCell class] forCellReuseIdentifier:[MedicalStartVideoSegmentTableViewCell cellReuseIdentifier]];
    
    [self.tableview registerClass:[MedicalVideoInfoTableViewCell class] forCellReuseIdentifier:[MedicalVideoInfoTableViewCell cellReuseIdentifier]];
    [self.tableview registerClass:[MedicalVideoStartRecommadCourseTableViewCell class] forCellReuseIdentifier:[MedicalVideoStartRecommadCourseTableViewCell cellReuseIdentifier]];
    [self startLoadAdvertiseList];
    [self startLoadClassify];
    //获取推荐精品课程
    [self startLoadRecommandCourses];
}

- (void) updateViewConstraints{
    [super updateViewConstraints];
    
    
}

//获取医学视频分类
- (void) startLoadClassify{
    //[MessageHubUtil showWait];
    WS(weakSelf)
    [MedicalVideoListBussiness startLoadMediaclVideoClassify:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if (result && [result isKindOfClass:[NSArray class]]) {
            [weakSelf videoClassifiesLoaded:result];
        }
    } complete:^(NSInteger code, NSString *message) {
        //[MessageHubUtil hideMessage];
        SAFE_WEAKSELF(weakSelf)
        if (code != 0) {
            [MessageHubUtil showErrorMessage:message];
            return ;
        }
        //[weakSelf.listTableView reloadData];
    }];
}

- (void) videoClassifiesLoaded:(NSArray<MedicalVideoClassifyEntryModel*>*) classifies{
    self.seniorSubjects = classifies;
    [self.tableview reloadData];
}

#pragma mark - settingAndGetting
- (UIView*) tableviewHeaderView{
    if (!_tableviewHeaderView) {
        CGFloat width = kScreenWidth;
        if ([UIDevice currentDevice].isPad) {
            width = kScreenWidth * 0.7;
        }
        CGFloat rate = width / 375;
        CGFloat height = 128. * rate + 20.;
        _tableviewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    }
    return _tableviewHeaderView;
}

- (SDCycleScrollView*) advertiseView{
    if (!_advertiseView) {
        CGFloat width = kScreenWidth;
        if ([UIDevice currentDevice].isPad) {
            width = kScreenWidth * 0.7;
        }
        CGFloat rate = width/375.;
        width -= 26.;
        CGFloat height = 128. * rate;
        _advertiseView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, width, height) delegate:self placeholderImage:[UIImage imageNamed:@"img_default_main"]];
        [self.tableviewHeaderView addSubview:_advertiseView];
        [_advertiseView setCornerRadius:8];
        [_advertiseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.tableviewHeaderView).insets(UIEdgeInsetsMake(9, 13, 9, 13));
        }];
        _advertiseView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _advertiseView.currentPageDotColor = [UIColor grayColor];
        _advertiseView.autoScrollTimeInterval = 5;
        _advertiseView.currentPageDotColor = [UIColor whiteColor];
    }
    return _advertiseView;
}

#pragma mark - table view data source
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger sectionCount = SectionCount;
    if (self.seniorSubjects && self.seniorSubjects.count > 0) {
        sectionCount += self.seniorSubjects.count;
    }
    return sectionCount;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case Grid_Section:
            return 1;
            break;
        case Subjects_Section:{
            if (self.seniorSubjects && self.seniorSubjects.count > 0) {
                return 1;
            }
            break;
        }
        case Course_Section:{
            if (self.recommandCourseList && self.recommandCourseList.content.count > 0) {
                return 1;
            }
            break;
        }
        default:{
            if (section >= SectionCount) {
                NSInteger index = (section - SectionCount);
                MedicalVideoClassifyEntryModel* cateModel = self.seniorSubjects[index];
                return cateModel.medicalVideos.count;
            }
            break;
        }
    }
    return 0;
}

- (VHTableViewCell*) tableViewCell:(Class) class indexPath:(NSIndexPath*) indexPath{
    VHTableViewCell* cell = [self.tableview dequeueReusableCellWithIdentifier:[VHTableViewCell cellReuseIdentifier]];
    switch (indexPath.section) {
        case Grid_Section:{
            cell = [self.tableview dequeueReusableCellWithIdentifier:[MedicalStartGridTableViewCell cellReuseIdentifier]];
            break;
        }
        case Subjects_Section:{
            MedicalStartVideoSegmentTableViewCell* subjectcell = [[MedicalStartVideoSegmentTableViewCell alloc] initWithCategories:self.seniorSubjects];
            cell = subjectcell;
            break;
        }
        case Course_Section:{
            cell = [[MedicalVideoStartRecommadCourseTableViewCell alloc] initWithCourseList:self.recommandCourseList];
            break;
        }
        default:{
            NSInteger section = indexPath.section;
            if (section >= SectionCount) {
                NSInteger index = (section - SectionCount);
                MedicalVideoClassifyEntryModel* cateModel = self.seniorSubjects[index];
                cell = [self.tableview dequeueReusableCellWithIdentifier:[MedicalVideoInfoTableViewCell cellReuseIdentifier]];
                [cell setEntryModel:cateModel.medicalVideos[indexPath.row]];
                //return cateModel.medicalVideos.count;
            }
            break;
        }
    }
    
    return cell;
}

#pragma mark - table view delegate
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section >= SectionCount){
        return 49;
    }
    return 0.01;
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section < SectionCount) {
        return nil;
    }
    
    NSInteger index = (section - SectionCount);
    MedicalVideoClassifyEntryModel* cateModel = self.seniorSubjects[index];
    CGFloat width = kScreenWidth;
    if ([UIDevice currentDevice].isPad) {
        width = kScreenWidth * 0.7;
    }
    UIView* headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 49.)];
    headerview.backgroundColor = [UIColor whiteColor];
    UILabel* nameLabel = [headerview addLabel:[UIColor commonTextColor] textSize:17];
    nameLabel.text = cateModel.name;
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerview).offset(10);
        make.centerY.equalTo(headerview);
    }];
    return headerview;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

#pragma mark - 获取广告里表
- (void) startLoadAdvertiseList{
    WS(weakSelf)
    [MedicalVideoListBussiness loadMedicalVideoAdvertiseList:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if ([result isKindOfClass:[NSArray class]]) {
            [weakSelf advertiseListLoaded:result];
        }
    } complete:^(NSInteger code, NSString *message) {
        
    }];
}

- (void) advertiseListLoaded:(NSArray<AdvertiseEntryModel*>*) advertises{
    self.advertiseModels = advertises;
    NSArray<NSString*>* imageUrls = [advertises valueForKey:@"pictureUrl"];
    [self.advertiseView setImageURLStringsGroup:imageUrls];
}

#pragma mark - 获取学科列表
- (void) startLoadSeniorSubjects{
    WS(weakSelf)
    [CommonBaseBussiness startSeniorSubjects:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if ([result isKindOfClass:[NSArray class]]) {
            [weakSelf seniorSubjectLoaded:result];
        }
    } complete:^(NSInteger code, NSString *message) {
        
    }];
}

- (void) seniorSubjectLoaded:(NSArray<MedicalVideoClassifyEntryModel*>*) subjects{
    self.seniorSubjects = subjects;
    [self.tableview reloadData];
}

#pragma mark - 获取首页推荐课程
- (void) startLoadRecommandCourses{
    WS(weakSelf)
    [MedicalVideoListBussiness startLoadHomeRecommandCoursesVideos:^(id result) {
        WS(weakSelf)
        if (!result || ![result isKindOfClass:[MedicalVideoGroupInfoListModel class]]) {
            return ;
        }
        weakSelf.recommandCourseList = result;
        [weakSelf.tableview reloadData];
    } complete:^(NSInteger code, NSString *message) {
        SAFE_WEAKSELF(weakSelf)
        
        if (code == 0) {
            
        }
    }];
}


@end
