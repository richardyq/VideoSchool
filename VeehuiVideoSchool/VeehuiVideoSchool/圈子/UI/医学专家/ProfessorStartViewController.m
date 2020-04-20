//
//  ProfessorStartViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/3.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "ProfessorStartViewController.h"

#import "ProfessorSubjectCollectionViewController.h"
#import "ProfessorActivityTableViewCell.h"
#import "ProfessorCircleInfoTableViewCell.h"

#import "CircleInfoEntryModel.h"
#import "CircleBussiness.h"
#import "ProfessorInfoEntryModel.h"
#import "CirclePageRouter.h"

typedef NS_ENUM(NSUInteger, ProfessorStartSection) {
    Activity_Section,
    Professor_Section,
    SectionCount,
};

typedef NS_ENUM(NSUInteger, ProfessorSegmentIndex) {
    AllProfessor,           //全部专家
    FollowProfessor,        //关注的专家
    
};

@interface ProfessorStartViewController ()
<UITableViewDataSource, UITableViewDelegate,
ProfessorDeptsDelegate>
@property (nonatomic, strong) UIView* subjectHeaderView;
@property (nonatomic, strong) UIView* subjectDetView;
@property (nonatomic, strong) UIPageControl* pageControl;

@property (nonatomic, strong) ProfessorSubjectCollectionViewController* subjectViewController;

@property (nonatomic, strong) CircleInfoEntryList* activitycircleList;

@property (nonatomic, strong) SegmentView* segmentview;

@property (nonatomic, readonly) ProfessorSegmentIndex segmentIndex;
@property (nonatomic, strong) ProfessorInfoEntryList* professorCircleList;
@property (nonatomic, strong) ProfessorInfoEntryList* followedProfessorList;

@end

@implementation ProfessorStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"医学专家";
    self.tableview.backgroundColor = [UIColor commonBackgroundColor];
    self.tableview.mj_header = nil;
    [self.tableview setTableHeaderView:self.subjectHeaderView];
    [self.tableview registerClass:[ProfessorActivityTableViewCell class] forCellReuseIdentifier:[ProfessorActivityTableViewCell cellReuseIdentifier]];
    [self.tableview registerClass:[ProfessorCircleInfoTableViewCell class] forCellReuseIdentifier:[ProfessorCircleInfoTableViewCell cellReuseIdentifier]];
    [self getData];
}

- (void) updateViewConstraints{
    [super updateViewConstraints];
    
    [self.subjectDetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.subjectHeaderView).insets(UIEdgeInsetsMake(10, 12.5, 8, 12.5));
    }];
    
    [self.subjectViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.subjectDetView).insets(UIEdgeInsetsMake(0, 0, 34, 0));
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.subjectHeaderView).offset(-22);
        make.bottom.equalTo(self.subjectHeaderView);
    }];
}

#pragma mark - settingAndGetting
- (SegmentView*) segmentview{
    if (_segmentview) {
        return _segmentview;
    }
    
    _segmentview = [[SegmentView alloc] initWithNormalFont:[UIFont systemFontOfSize:13] normalColor:[UIColor commonGrayTextColor] highFont:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium] highColor:[UIColor mainThemeColor]];
    _segmentview.indicateWidth = 27.5;
    [_segmentview setSegmentTitles:@[@"全部", @"关注"]];
    
    WS(weakSelf)
    [_segmentview onSelectedIndexChanged:^(NSInteger index) {
        SAFE_WEAKSELF(weakSelf)
        //[weakSelf.tableview reloadSection:Professor_Section withRowAnimation:UITableViewRowAnimationNone];
        [weakSelf.tableview reloadData];
        switch (index) {
            case 0:{
                [weakSelf refreshCommandEnd:weakSelf.professorCircleList.pageNo totalPage:weakSelf.professorCircleList.totalPages];
                break;
            }
            case 1:{
                [weakSelf refreshCommandEnd:weakSelf.followedProfessorList.pageNo totalPage:weakSelf.followedProfessorList.totalPages];
                break;
            }
            default:
                break;
        }
    }];
    return _segmentview;
}

- (ProfessorSegmentIndex) segmentIndex{
    ProfessorSegmentIndex segmentIndex = AllProfessor;
    switch (self.segmentview.selectedIndex) {
        case 0:{
            segmentIndex = AllProfessor;
            break;
        }
        case 1:{
            segmentIndex = FollowProfessor;
            break;
        }
    }
    return segmentIndex;
}

- (UIView*) subjectHeaderView{
    if (!_subjectHeaderView) {
        CGFloat tableWidth = kScreenWidth;
        if ([UIDevice currentDevice].isPad) {
            tableWidth = kScreenWidth * 0.7;
        }
        _subjectHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableWidth, 220)];
    }
    return _subjectHeaderView;
}

- (UIView*) subjectDetView{
    if (!_subjectDetView) {
        _subjectDetView = [self.subjectHeaderView addView];
        _subjectDetView.backgroundColor = [UIColor whiteColor];
        [_subjectDetView setCornerRadius:9];
    }
    return _subjectDetView;
}

- (ProfessorSubjectCollectionViewController*) subjectViewController{
    if (!_subjectViewController) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat tableWidth = kScreenWidth;
        if ([UIDevice currentDevice].isPad) {
            tableWidth = kScreenWidth * 0.7;
        }
        CGFloat cellWidth = (tableWidth - 25) / 4.;
        layout.itemSize = CGSizeMake(cellWidth , 78);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;     //水平滑动
        // 设置最小行间距
        layout.minimumLineSpacing = 0;
        // 设置垂直间距
        layout.minimumInteritemSpacing = 0;
        
        _subjectViewController = [[ProfessorSubjectCollectionViewController alloc] initWithCollectionViewLayout:layout];
        _subjectViewController.deptDelegate = self;
        [self addChildViewController:_subjectViewController];
        [self.subjectDetView addSubview:_subjectViewController.view];
       
        [_subjectViewController.view setCornerRadius:9.];
    }
    return _subjectViewController;
}

- (UIPageControl*) pageControl{
    if (!_pageControl) {
        _pageControl = (UIPageControl*)[self.subjectHeaderView addView:[UIPageControl class]];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor mainThemeColor];
    }
    return _pageControl;
}


#pragma mark - 获取网络数据
- (void) getData{
    [self startLoadActiveProfessorCircleList];
    [self startLoadRecommandCircleList:self.professorCircleList.pageNo];
    [self startLoadFollowedProfessorList:self.followedProfessorList.pageNo];
}

- (ProfessorInfoEntryList*) professorCircleList{
    if (!_professorCircleList) {
        _professorCircleList = [[ProfessorInfoEntryList alloc] init];
        _professorCircleList.pageNo = 1;
    }
    return _professorCircleList;
}

- (ProfessorInfoEntryList*) followedProfessorList{
    if (!_followedProfessorList) {
        _followedProfessorList = [[ProfessorInfoEntryList alloc] init];
        _followedProfessorList.pageNo = 1;
    }
    return _followedProfessorList;
}

#pragma mark - 获取活跃的专家圈子列表
- (void) startLoadActiveProfessorCircleList{
    WS(weakSelf)
    [CircleBussiness startLoadActiveCircleList:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if (result && [result isKindOfClass:[CircleInfoEntryList class]]) {
            [weakSelf activityCirclesLoaded:result];
        }
    } complete:^(NSInteger code, NSString *message) {
        
    }];
}

- (void) activityCirclesLoaded:(CircleInfoEntryList*) circleList{
    self.activitycircleList = circleList;
    [self.tableview reloadData];
}


#pragma mark - 获取【全部】圈子列表
- (void) startLoadRecommandCircleList:(NSInteger) pageNo{
    WS(weakSelf)
    [CircleBussiness startLoadProfessorCircleList:pageNo result:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if (result && [result isKindOfClass:[ProfessorInfoEntryList class]]) {
            [weakSelf recommandProfessorListLoaded:result];
            [weakSelf.tableview reloadData];
        }
    } complete:^(NSInteger code, NSString *message) {
        SAFE_WEAKSELF(weakSelf)
        if (code == 0) {
            if (weakSelf.segmentIndex == AllProfessor) {
                [weakSelf refreshCommandEnd:weakSelf.professorCircleList.pageNo totalPage:weakSelf.professorCircleList.totalPages];
            }
            
        }
    }];
}

- (void) recommandProfessorListLoaded:(ProfessorInfoEntryList*) professorList{
    self.professorCircleList.pageNo = professorList.pageNo;
    self.professorCircleList.pageSize = professorList.pageSize;
    self.professorCircleList.totalPages = professorList.totalPages;
    self.professorCircleList.totalElements = professorList.totalElements;
    
    NSMutableArray<ProfessorInfoEntryModel*>* professors = [NSMutableArray<ProfessorInfoEntryModel*> arrayWithArray:self.professorCircleList.content];
    if (professorList.pageNo == 1) {
        [professors removeAllObjects];
    }
    
    [professors addObjectsFromArray:professorList.content];
    self.professorCircleList.content = professors;
}

#pragma mark - 获取【全部】圈子列表
- (void) startLoadFollowedProfessorList:(NSInteger) pageNo{
    WS(weakSelf)
    [CircleBussiness startLoadFollowedProfessorList:pageNo result:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if (result && [result isKindOfClass:[ProfessorInfoEntryList class]]) {
            [weakSelf followedProfessorListLoaded:result];
            [weakSelf.tableview reloadData];
        }
    } complete:^(NSInteger code, NSString *message) {
        SAFE_WEAKSELF(weakSelf)
        if (code == 0) {
            if (weakSelf.segmentIndex == FollowProfessor) {
                [weakSelf refreshCommandEnd:weakSelf.followedProfessorList.pageNo totalPage:weakSelf.followedProfessorList.totalPages];
            }
            
        }
    }];
}

- (void) followedProfessorListLoaded:(ProfessorInfoEntryList*) professorList{
    self.followedProfessorList.pageNo = professorList.pageNo;
    self.followedProfessorList.pageSize = professorList.pageSize;
    self.followedProfessorList.totalPages = professorList.totalPages;
    self.followedProfessorList.totalElements = professorList.totalElements;
    
    NSMutableArray<ProfessorInfoEntryModel*>* professors = [NSMutableArray<ProfessorInfoEntryModel*> arrayWithArray:self.followedProfessorList.content];
    if (professorList.pageNo == 1) {
        [professors removeAllObjects];
    }
    
    [professors addObjectsFromArray:professorList.content];
    self.followedProfessorList.content = professors;
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return NO;
}

#pragma mark - table view data source
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return SectionCount;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case Activity_Section:{
            if (self.activitycircleList) {
                return 1;
            }
            break;
        }
        case Professor_Section:{
            switch (self.segmentIndex) {
                case AllProfessor:{
                    if (self.professorCircleList) {
                        return self.professorCircleList.content.count;
                    }
                    break;
                }
                case FollowProfessor:{
                    if (self.followedProfessorList) {
                        return self.followedProfessorList.content.count;
                    }
                    break;
                }
            }
            
        }
        default:
            break;
    }
    
    return 0;
}

- (Class) tableViewCellClass:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case Activity_Section:{
            return [ProfessorActivityTableViewCell class];
            break;
        }
        case Professor_Section:{
            return [ProfessorCircleInfoTableViewCell class];
            break;
        }
        default:
            break;
    }
    return [VHTableViewCell class];
}

- (EntryModel*) entryModel:(NSIndexPath*) indexPath{
    switch (indexPath.section) {
        case Activity_Section:{
            return self.activitycircleList;
            break;
        }
        case Professor_Section:{
            if (self.segmentIndex == AllProfessor) {
                return self.professorCircleList.content[indexPath.row];
            }
            if (self.segmentIndex == FollowProfessor) {
                return self.followedProfessorList.content[indexPath.row];
            }
            break;
        }
        default:
            break;
    }
    if (self.models.count > 0 && self.models.count > indexPath.row) {
        return self.models[indexPath.row];
    }
    return nil;
}

#pragma mark - table view delegate
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [self headerviewHeight:section];
}

- (CGFloat) headerviewHeight:(NSInteger) section{
    switch (section) {
        case Professor_Section:{
            return 50.;
            break;
        }
        default:
            break;
    }
    return 0;
}


- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGFloat headerHeight = [self headerviewHeight:section];
    if (headerHeight == 0) {
        return nil;
    }
    CGFloat tableWidth = kScreenWidth;
    if ([UIDevice currentDevice].isPad) {
        tableWidth = kScreenWidth * 0.7;
    }
    UIView* headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableWidth, headerHeight)];
    
    switch (section) {
        case Professor_Section:{
            headerview.backgroundColor = [UIColor commonBackgroundColor];
            [headerview addSubview:self.segmentview];
            [self.segmentview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(headerview).insets(UIEdgeInsetsMake(0, 18, 0, 18));
            }];
            break;
        }
        default:
            break;
    }
    return headerview;
}

- (void) loadMoreDataCommand{
    switch (self.segmentIndex) {
        case AllProfessor:{
            [self startLoadRecommandCircleList:self.professorCircleList.pageNo + 1];
            break;
        }
        case FollowProfessor:{
            [self startLoadFollowedProfessorList:self.followedProfessorList.pageNo + 1];
            break;
        }
        default:
            break;
    }
}

- (void) professorDeptPages:(NSInteger) pages{
    [self.pageControl setNumberOfPages:pages];
}
- (void) professorDeptPageShown:(NSInteger) page{
    [self.pageControl setCurrentPage:page];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case Professor_Section:{
            switch (self.segmentIndex) {
                case AllProfessor:{
                    if (self.professorCircleList.content.count == 0) {
                        return;
                    }
                    ProfessorInfoEntryModel* professor = self.professorCircleList.content[indexPath.row];
                    
                    break;
                }
                case FollowProfessor:{
                    if (self.followedProfessorList.content.count == 0) {
                        return;
                    }
                    ProfessorInfoEntryModel* professor = self.followedProfessorList.content[indexPath.row];
                    
                    break;
                }
                default:
                    break;
            }
            break;
        }
    }
    
}

@end
