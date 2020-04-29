//
//  MeetingReplayListViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/28.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingReplayListViewController.h"
#import "MedicalVideoListBussiness.h"
#import "MeetingBussiness.h"
#import "MeetingEntryModel.h"
#import "MeetingInfoListTableViewCell.h"

@interface MeetingReplayListViewController ()

@property (nonatomic, strong) MedicalVideoClassifyEntryModel* seniorSubject;

@property (nonatomic, strong) NSArray<MedicalVideoClassifyEntryModel*>* secondarySubjects;
@property (nonatomic, strong) NSString* selectedSubjectCode;

@property (nonatomic, strong) SegmentView* segmentView;
@end

@implementation MeetingReplayListViewController

- (id) initWithSeniorSubject:(MedicalVideoClassifyEntryModel*) seniorSubject{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _seniorSubject = seniorSubject;
        _selectedSubjectCode = seniorSubject.code;
    }
    return self;
}

- (void)viewDidLoad {
    self.segmentView.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.seniorSubject.name;
    [self.tableview registerClass:[MeetingInfoListTableViewCell class] forCellReuseIdentifier:[MeetingInfoListTableViewCell cellReuseIdentifier]];
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

#pragma mark - 获取网络数据
- (void) beginRefreshData{
    if (!self.secondarySubjects) {
        return;
    }
    
    [self.tableview.mj_header beginRefreshing];
}

- (void) refreshDataCommand{
    self.pageNo = 1;
    [self startLoadReplayMeetingList:self.selectedSubjectCode pageNo:1];
}

- (void) loadMoreDataCommand{
    //MedicalVideoClassifyEntryModel* subject = self.favorites.firstObject;
    [self startLoadReplayMeetingList:self.selectedSubjectCode pageNo:self.pageNo + 1];
}

- (void) startLoadSecondaryClassifies{
    NSString* mainCode = self.seniorSubject.code;
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
            return;
        }
        //获取分类下会议视频
        [self beginRefreshData];
        //
    }];
}

- (void) secondaryClassifiesLoaded:(NSArray<MedicalVideoClassifyEntryModel*>*) classifies{
    self.secondarySubjects = classifies;
    self.selectedSubjectCode = classifies.firstObject.code;
    if (self.secondarySubjects && self.secondarySubjects.count > 1) {
        NSArray* names = [self.secondarySubjects valueForKey:@"name"];
        [self.segmentView setSegmentTitles:names];
    }
    else{
        [self.tableview mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
}

//获取会议视频列表
- (void) startLoadReplayMeetingList:(NSString*) subjectCode pageNo:(NSInteger) pageNo{
    WS(weakSelf)
    [MeetingBussiness startLoadReplayMeetingList:subjectCode pageNo:pageNo pageSize:10 result:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if ([result isKindOfClass:[MeetingListModel class]]) {
            [weakSelf replayMeetingsLoaded:result];
        }
    } complete:^(NSInteger code, NSString *message) {
        SAFE_WEAKSELF(weakSelf)
        self.errorMessage = nil;
        if (weakSelf != 0) {
            //[MessageHubUtil showErrorMessage:message];
            weakSelf.errorMessage = message;
            
        }
        [weakSelf refreshCommandEnd:self.pageNo totalPage:self.totalPages];
    }];
}

- (void) replayMeetingsLoaded:(MeetingListModel*) meetingList{
    self.pageNo = meetingList.pageNo;
    self.totalPages = meetingList.pageSize;
    if (meetingList.pageNo == 1) {
        [self.models removeAllObjects];
    }
    
    [self.models addObjectsFromArray:meetingList.content];
}

- (EntryModel*) entryModel:(NSIndexPath*) indexPath{
    if (self.models.count > 0 && self.models.count > indexPath.row) {
        return self.models[indexPath.row];
    }
    return nil;
}

- (Class) tableViewCellClass:(NSIndexPath *)indexPath{
    return [MeetingInfoListTableViewCell class];
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

#pragma mark - 

- (void) segmentViewSelectedIndexChanged:(NSInteger) index{
    NSString* subjectCode = self.secondarySubjects[index].code;
    self.selectedSubjectCode = subjectCode;
//    [self startLoadMedicalVideoList:subjectCode];
    [self beginRefreshData];
}

@end
