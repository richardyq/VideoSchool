//
//  PorfessorSubjectedListViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/9.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "PorfessorSubjectedListViewController.h"
#import "MedicalVideoClassifyEntryModel.h"
#import "CommonBaseBussiness.h"
#import "CircleBussiness.h"
#import "ProfessorCircleInfoTableViewCell.h"
#import "ProfessorInfoEntryModel.h"

@interface PorfessorSubjectedListViewController ()
<UITableViewDelegate>
@property (nonatomic, strong) MedicalVideoClassifyEntryModel* classifyModel;
@property (nonatomic, strong) SegmentView* segmentView;
@property (nonatomic, strong) NSArray<MedicalVideoClassifyEntryModel*>* secondaryClassifyModels;
@property (nonatomic, strong) NSString* deptCode;


@end

@implementation PorfessorSubjectedListViewController

- (id) initWithClassifyModel:(MedicalVideoClassifyEntryModel*) classify{
    self = [super init];
    if (self) {
        _classifyModel = classify;
        _deptCode = classify.code;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.classifyModel.name;
    [self getData];
    self.tableview.mj_header = nil;
    
    [self.tableview registerClass:[ProfessorCircleInfoTableViewCell class] forCellReuseIdentifier:[ProfessorCircleInfoTableViewCell cellReuseIdentifier]];
}

- (void) updateViewConstraints{
    [super updateViewConstraints];
    
    CGFloat tableWidth = kScreenWidth;
    if ([UIDevice currentDevice].isPad) {
        tableWidth *= 0.7;
    }
    
    [self.segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(@(tableWidth));
        make.top.equalTo(self.view);
        make.height.mas_equalTo(@50.);
    }];
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

#pragma mark - 获取网络数据
- (void) getData{
    //获取二级分类
    [self startLoadSecondaryDepts];
}

//获取二级分类
- (void) startLoadSecondaryDepts{
    WS(weakSelf)
    [CommonBaseBussiness startLoadCircleSecondardDeptList:self.classifyModel.code result:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if (result && [result isKindOfClass:[NSArray class]]) {
            [weakSelf secondaryClassifyModelsLoaded:result];
        }
    } complete:^(NSInteger code, NSString *message) {
        SAFE_WEAKSELF(weakSelf)
        weakSelf.segmentView.hidden = (weakSelf.secondaryClassifyModels.count <= 1);
        if (weakSelf.secondaryClassifyModels.count > 1) {
            [weakSelf.tableview mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.equalTo(weakSelf.view);
                make.top.equalTo(weakSelf.segmentView.mas_bottom);
            }];
            weakSelf.deptCode = [weakSelf.secondaryClassifyModels firstObject].code;
        }
        
        //获取列表
        [weakSelf startLoadClassifiedProfessors:1];
    }];
}

- (void) secondaryClassifyModelsLoaded:(NSArray<MedicalVideoClassifyEntryModel*>*) classifyEntryModels{
    _secondaryClassifyModels = classifyEntryModels;
    NSArray<NSString*>* classifyNames = [classifyEntryModels valueForKey:@"name"];
    [self.segmentView setSegmentTitles:classifyNames];
}

- (void) startLoadClassifiedProfessors:(NSInteger) pageNo{
    WS(weakSelf)
    [CircleBussiness startLoadClassifiedProfessorList:self.deptCode pageNo:pageNo result:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if ([result isKindOfClass:[ProfessorInfoEntryList class]]) {
            [weakSelf classifiedProfessorsLoaded:result];
        }
        
    } complete:^(NSInteger code, NSString *message) {
        SAFE_WEAKSELF(weakSelf)
        [weakSelf refreshCommandEnd:weakSelf.pageNo totalPage:weakSelf.totalPages];
    }];
}

- (void) classifiedProfessorsLoaded:(ProfessorInfoEntryList*) listModel{
    if (!listModel || ![listModel isKindOfClass:[ProfessorInfoEntryList class]]) {
        return;
    }
    if (listModel.pageNo <= 1) {
        [self.models removeAllObjects];
    }
    self.pageNo = listModel.pageNo;
    self.pageSize = listModel.pageSize;
    self.totalPages = listModel.totalPages;
    
    [self.models addObjectsFromArray:listModel.content];
}

- (void) loadMoreDataCommand{
    [self startLoadClassifiedProfessors:self.pageNo + 1];
}

#pragma mark -
- (void) segmentViewSelectedIndexChanged:(NSInteger) index{
    MedicalVideoClassifyEntryModel* classifyModel = self.secondaryClassifyModels[index];
    self.deptCode = classifyModel.code;
    [self startLoadClassifiedProfessors:1];
}

- (Class) tableViewCellClass:(NSIndexPath *)indexPath{
    return [ProfessorCircleInfoTableViewCell class];
}

#pragma mark - table view delegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProfessorInfoEntryModel* professor = self.models[indexPath.row];
    //TODO:跳转到专家圈子首页
}

@end
