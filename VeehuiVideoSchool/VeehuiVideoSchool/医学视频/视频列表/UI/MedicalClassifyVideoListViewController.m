//
//  MedicalClassifyVideoListViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalClassifyVideoListViewController.h"
#import "MedicalVideoListBussiness.h"
#import "MedicalVideoInfoTableViewCell.h"
#import "MedicalVideoPageRouter.h"

@interface MedicalClassifyVideoListViewController ()
<UITableViewDelegate>
@property (nonatomic, readonly) MedicalVideoClassifyEntryModel* classifyModel;
//二级学科分类
@property (nonatomic, strong) NSArray<MedicalVideoClassifyEntryModel*>* secondClassifies;

@property (nonatomic, readonly) MedicalVideoClassifyEntryModel* selectedSubjectModel;

@property (nonatomic, strong) SegmentView* segmentView;

@end

@implementation MedicalClassifyVideoListViewController

- (id) initWithClassifyModel:(MedicalVideoClassifyEntryModel*) classifyEntryModel{
    self = [super init];
    if (self) {
        _classifyModel = classifyEntryModel;
    }
    return self;
}

- (void) makeParamDictionary{
    //TODO:构建特定参数
    if (self.classifyModel && self.classifyModel.code
        && ![self.classifyModel.code isEmpty]) {
        [self.paramDictionary setValue:self.classifyModel.code forKey:@"code"];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.classifyModel.name;
    self.tableview.backgroundColor = [UIColor commonBackgroundColor];
    [self.tableview registerClass:[MedicalVideoInfoTableViewCell class] forCellReuseIdentifier:[MedicalVideoInfoTableViewCell cellReuseIdentifier]];
    [self startLoadSecondaryClassifies];
}

- (void) updateViewConstraints{
    [super updateViewConstraints];
    
    [self.segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.height.mas_equalTo(@45);
        make.centerX.equalTo(self.view);
        if ([UIDevice currentDevice].isPad) {
            make.width.equalTo(self.view).multipliedBy(0.7);
        }
        else{
            make.width.equalTo(self.view);
        }
    }];
    
    [self.tableview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.top.equalTo(self.segmentView.mas_bottom);
        make.centerX.equalTo(self.view);
        if ([UIDevice currentDevice].isPad) {
            make.width.equalTo(self.view).multipliedBy(0.7);
        }
        else{
            make.width.equalTo(self.view);
        }
    }];
}

- (Class) tableViewCellClass{
    return [MedicalVideoInfoTableViewCell class];
}

#pragma mark - 获取数据
- (void) refreshDataCommand{
    NSString* subjectCode = self.selectedSubjectModel.code;
    [self startLoadMedicalVideoList:subjectCode];
}

- (void) loadMoreDataCommand{
    NSString* subjectCode = self.selectedSubjectModel.code;
    [self startLoadMedicalVideoList:subjectCode pageSize:self.pageNo + 1];
}

- (void) startLoadSecondaryClassifies{
    NSString* mainCode = self.classifyModel.code;
    if (!mainCode || [mainCode isEmpty]) {
        return;
    }
    if ([mainCode isEqualToString:@"00"]) {
        return;
    }
    [MessageHubUtil showWait];
    WS(weakSelf)
    [MedicalVideoListBussiness startLoadMedicalVideoSecondaryClassify:mainCode result:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if (result && [result isKindOfClass:[NSArray class]]) {
            [weakSelf secondaryClassifiesLoaded:result];
        }
    } complete:^(NSInteger code, NSString *message) {
        SAFE_WEAKSELF(weakSelf)
        [MessageHubUtil hideMessage];
        if (code != 0) {
            [MessageHubUtil showErrorMessage:message];
        }
    }];
}

- (void) secondaryClassifiesLoaded:(NSArray<MedicalVideoClassifyEntryModel*>*) classifies{
    _secondClassifies = classifies;
    
    NSArray<NSString*>* titles = [classifies valueForKey:@"name"];
    [self.segmentView setSegmentTitles:titles];
    
    NSString* subjectCode = self.selectedSubjectModel.code;
    [MessageHubUtil showWait];
    [self startLoadMedicalVideoList:subjectCode];
}

//获取分类学科下的视频列表
- (void) startLoadMedicalVideoList:(NSString*) subjectCode{
    [self startLoadMedicalVideoList:subjectCode pageSize:1];
    
}

- (void) startLoadMedicalVideoList:(NSString*) subjectCode pageSize:(NSInteger) pageNo{
    if (pageNo <= 1) {
        [self.models removeAllObjects];
        self.pageNo = 1;
    }
    
    WS(weakSelf)
    [MedicalVideoListBussiness startLoadClassifiedMedicalVideos:subjectCode pageNo:pageNo pageSize:self.pageSize result:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if ([result isKindOfClass:[ListModel class]]) {
            [weakSelf medicalVideoListLoaded:result];
        }
        
    } complete:^(NSInteger code, NSString *message) {
        [MessageHubUtil hideMessage];
        SAFE_WEAKSELF(weakSelf)
        [weakSelf refreshCommandEnd:self.pageNo totalPage:self.totalPages];
        if (code != 0) {
            [MessageHubUtil showErrorMessage:message];
            return ;
        }
    }];
}

- (void) medicalVideoListLoaded:(ListModel*) listModel{
    self.pageNo = listModel.pageNo;
    self.totalPages = listModel.totalPages;
    
    [self.models addObjectsFromArray:listModel.content];
    [self.tableview reloadData];
}

#pragma mark - settingAndGetting
- (SegmentView*) segmentView{
    if (!_segmentView) {
        _segmentView = [[SegmentView alloc] initWithNormalFont:[UIFont systemFontOfSize:13] normalColor:[UIColor commonGrayTextColor] highFont:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium] highColor:[UIColor mainThemeColor]];
        [self.view addSubview:_segmentView];
        _segmentView.minSegmentCellWidth = (kScreenWidth / 4.5);
        if ([UIDevice currentDevice].isPad) {
            _segmentView.minSegmentCellWidth = (kScreenWidth / 4.5 * 0.7);
        }
        _segmentView.indicateWidth = 27.5;
        WS(weakSelf)
        [_segmentView onSelectedIndexChanged:^(NSInteger index) {
            SAFE_WEAKSELF(weakSelf)
            [weakSelf segmentViewSelectedIndexChanged:index];
        }];
    }
    return _segmentView;
}

- (MedicalVideoClassifyEntryModel*) selectedSubjectModel{
    MedicalVideoClassifyEntryModel* selectedSubjectModel = nil;
    if (self.secondClassifies && self.secondClassifies.count > 0) {
        NSInteger selectedIndex = self.segmentView.selectedIndex;
        selectedSubjectModel = self.secondClassifies[selectedIndex];
    }
    
    return selectedSubjectModel ;
}

#pragma mark
- (void) segmentViewSelectedIndexChanged:(NSInteger) index{
//    NSString* subjectCode = self.selectedSubjectModel.code;
//    [self startLoadMedicalVideoList:subjectCode];
    [self beginRefreshData];
}

- (void) tableviewDidScrollToSection:(NSInteger) section{
    //[self.segmentView setSelectedIndex:section];
}

#pragma mark - table view delegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MedicalVideoGroupInfoEntryModel* groupEntry = (MedicalVideoGroupInfoEntryModel*)self.models[indexPath.row];
    //跳转到视频详情页面
    [MedicalVideoPageRouter entryMedicalVideoDetailPage:groupEntry.id];
    
}
@end
