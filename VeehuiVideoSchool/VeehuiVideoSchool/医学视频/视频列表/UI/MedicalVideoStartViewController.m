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

@interface MedicalVideoStartViewController ()
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) SegmentView* segmentView;

@property (nonatomic, strong) NSArray<MedicalVideoClassifyEntryModel*>* videoClassifies;
@property (nonatomic, strong) UITableView* listTableView;
@end


@implementation MedicalVideoStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"医学视频";
    
    [self startLoadClassify];
    
    [self.listTableView registerClass:[MedicalVideoInfoTableViewCell class] forCellReuseIdentifier:[MedicalVideoInfoTableViewCell cellReuseIdentifier]];
}

- (void) updateViewConstraints{
    [super updateViewConstraints];
    
    [self.segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(@45);
    }];
    
    [self.listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.segmentView.mas_bottom);
    }];
}

//获取医学视频分类
- (void) startLoadClassify{
    [MessageHubUtil showWait];
    WS(weakSelf)
    [MedicalVideoListBussiness startLoadMediaclVideoClassify:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if (result && [result isKindOfClass:[NSArray class]]) {
            [weakSelf videoClassifiesLoaded:result];
        }
    } complete:^(NSInteger code, NSString *message) {
        [MessageHubUtil hideMessage];
        SAFE_WEAKSELF(weakSelf)
        if (code != 0) {
            [MessageHubUtil showErrorMessage:message];
            return ;
        }
        [weakSelf.listTableView reloadData];
    }];
}

- (void) videoClassifiesLoaded:(NSArray<MedicalVideoClassifyEntryModel*>*) classifies{
    _videoClassifies = classifies;
    
    NSArray<NSString*>* titles = [classifies valueForKey:@"name"];
    [self.segmentView setSegmentTitles:titles];
}

#pragma mark - settingAndGetting
- (SegmentView*) segmentView{
    if (!_segmentView) {
        _segmentView = [[SegmentView alloc] initWithNormalFont:[UIFont systemFontOfSize:13] normalColor:[UIColor commonGrayTextColor] highFont:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium] highColor:[UIColor mainThemeColor]];
        [self.view addSubview:_segmentView];
        _segmentView.minSegmentCellWidth = (kScreenWidth / 4.5);
        _segmentView.indicateWidth = 27.5;
        
        WS(weakSelf)
        [_segmentView onSelectedIndexChanged:^(NSInteger index) {
            SAFE_WEAKSELF(weakSelf)
            [weakSelf segmentViewSelectedIndexChanged:index];
        }];
    }
    return _segmentView;
}

- (UITableView*) listTableView{
    if (!_listTableView) {
        _listTableView = [[UITableView alloc] init];
        [self.view addSubview:_listTableView];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.backgroundColor = [UIColor commonBackgroundColor];
        _listTableView.estimatedRowHeight = 45.;
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _listTableView;
}

#pragma mark - table view data source
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.videoClassifies) {
        return self.videoClassifies.count;
    }
    return 0;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    MedicalVideoClassifyEntryModel* classifyModel = self.videoClassifies[section];
    return classifyModel.medicalVideos.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MedicalVideoInfoTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[MedicalVideoInfoTableViewCell cellReuseIdentifier]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MedicalVideoClassifyEntryModel* classifyModel = self.videoClassifies[indexPath.section];
    MedicalVideoGroupInfoEntryModel* groupModel = classifyModel.medicalVideos[indexPath.row];
    [cell setVideoGroupInfo:groupModel];
    
    return cell;
}

#pragma mark - table view delegate
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45.;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    headerView.backgroundColor = [UIColor commonBackgroundColor];
    MedicalVideoClassifyEntryModel* classifyModel = self.videoClassifies[section];
    UILabel* classifyNameLabel = [headerView addLabel:[UIColor commonTextColor] textSize:18];
    classifyNameLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    classifyNameLabel.text = classifyModel.name;
    
    UIButton* moreButton = [headerView addButton:UIButtonTypeCustom];
    [moreButton setTitle:@"更多 >>" forState:UIControlStateNormal];
    [moreButton setTitleColor:[UIColor commonGrayTextColor] forState:UIControlStateNormal];
    moreButton.titleLabel.font = [UIFont systemFontOfSize:12];
    
    moreButton.tag = 0x300 + section;
    [moreButton addTarget:self action:@selector(classifyMoreButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [classifyNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.left.equalTo(headerView).offset(14);
    }];
    
    [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.right.equalTo(headerView).offset(-9);
    }];
    return headerView;
}

- (UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView* footerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
    footerview.backgroundColor = [UIColor clearColor];
    return footerview;
}

#pragma mark - more button event
- (void) classifyMoreButtonClicked:(id) sender{
    UIButton* moreButton = (UIButton*) sender;
    if (![moreButton isKindOfClass:[UIButton class]]) {
        return;
    }
    
    NSInteger section = moreButton.tag - 0x300;
    if (section == 0) {
        //推荐视频，单独跳转
    }
    if (section <= 0 || section >= self.videoClassifies.count) {
        return;
    }
    
    MedicalVideoClassifyEntryModel* classifyModel = self.videoClassifies[section];
    //NSString* code = classifyModel.code;
    
    //跳转到分类视频列表
    [MedicalVideoPageRouter entryClassifiedMedicalVideListPage:classifyModel];
}

#pragma mark - 分类学科选择 event
- (void) segmentViewSelectedIndexChanged:(NSInteger) index{
    //CGRect headerRect = [self.listTableView rectForHeaderInSection:index];
    [self.listTableView scrollToRow:0 inSection:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

@end
