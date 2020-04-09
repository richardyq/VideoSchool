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

typedef NS_ENUM(NSUInteger, ProfessorStartSection) {
    Activity_Section,
    Professor_Section,
    SectionCount,
};

@interface ProfessorStartViewController ()
<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIView* subjectHeaderView;
@property (nonatomic, strong) ProfessorSubjectCollectionViewController* subjectViewController;

@property (nonatomic, strong) CircleInfoEntryList* activitycircleList;

@property (nonatomic, strong) SegmentView* segmentview;
@property (nonatomic, strong) NSMutableArray<CircleInfoEntryModel*>* recommandCircles;

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
    
    [self.subjectViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.subjectHeaderView).insets(UIEdgeInsetsMake(10, 12.5, 8, 12.5));
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
    return _segmentview;
}


#pragma mark - 获取网络数据
- (void) getData{
    
    //测试数据,活跃专家
    NSArray<NSString*>* names = @[@"刘学林", @"陈果", @"矛雨", @"邵钟", @"宋川", @"周仲瑜"];
    NSArray<NSString*>* portraits = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586324380203&di=a88de523cc5e541da4b709c373d9d17f&imgtype=0&src=http%3A%2F%2Fgss0.baidu.com%2F7Po3dSag_xI4khGko9WTAnF6hhy%2Fzhidao%2Fpic%2Fitem%2F267f9e2f07082838685c484ab999a9014c08f11f.jpg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586324380201&di=7f96b09d2ac5f76210875c8604b34aae&imgtype=0&src=http%3A%2F%2Fimage.biaobaiju.com%2Fuploads%2F20180802%2F03%2F1533152429-PGfdkeylXK.jpg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586324380199&di=8a12e704e15c8f92df2f22f56241c757&imgtype=0&src=http%3A%2F%2Ftupian.qqw21.com%2Farticle%2FUploadPic%2F2020-3%2F2020352216990408.jpg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586324380199&di=580f87513922ff7df2b19116db1edd4d&imgtype=0&src=http%3A%2F%2Fimage.biaobaiju.com%2Fuploads%2F20180918%2F15%2F1537255884-hlBfJcGXkb.jpg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586324380198&di=b525c7d31aa8a68acce0746b518fdddd&imgtype=0&src=http%3A%2F%2Fd.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2Fe61190ef76c6a7efd517f640fbfaaf51f3de66a6.jpg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586324380196&di=bf064daf3d486a45d9f3a71a067205d7&imgtype=0&src=http%3A%2F%2Fimg.psy525.cn%2Fupload%2F2020%2F03%2F25%2Fa615042016464f1cbd7dcebe1403ea94.png%2521200fixed"];
    NSMutableArray<CircleInfoEntryModel*>* circles = [NSMutableArray<CircleInfoEntryModel*> array];
    for (NSInteger index = 0; index < 6; ++index) {
        NSString* name = names[(arc4random() % names.count)];
        NSString* portrait = portraits[(arc4random() % portraits.count)];
        CircleInfoEntryModel* circle = [[CircleInfoEntryModel alloc] init];
        [circles addObject:circle];
        circle.name = name;
        circle.portraitUrl = portrait;
        circle.introduction = @"消化内科主任， 主任医师，教授";
        circle.id = arc4random() % 20000;
    }
    CircleInfoEntryList* activityList = [[CircleInfoEntryList alloc] init];
    activityList.content = circles;
    
    [self activityCirclesLoaded:activityList];
    
    [self startLoadRecommandCircleList];
}

- (void) activityCirclesLoaded:(CircleInfoEntryList*) circleList{
    self.activitycircleList = circleList;
    [self.tableview reloadData];
}

#pragma mark - 获取【全部】圈子列表
- (void) startLoadRecommandCircleList{
    WS(weakSelf)
    [CircleBussiness startLoadRecommandCircleList:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if (result && [result isKindOfClass:[NSArray class]]) {
            weakSelf.recommandCircles = result;
            [weakSelf.tableview reloadData];
        }
    } complete:^(NSInteger code, NSString *message) {
        SAFE_WEAKSELF(weakSelf)
    }];
}

#pragma mark - settingAndGetting
- (UIView*) subjectHeaderView{
    if (!_subjectHeaderView) {
        CGFloat tableWidth = kScreenWidth;
        if ([UIDevice currentDevice].isPad) {
            tableWidth = kScreenWidth * 0.7;
        }
        _subjectHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableWidth, 200)];
    }
    return _subjectHeaderView;
}

- (ProfessorSubjectCollectionViewController*) subjectViewController{
    if (!_subjectViewController) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat tableWidth = kScreenWidth;
        if ([UIDevice currentDevice].isPad) {
            tableWidth = kScreenWidth * 0.7;
        }
        CGFloat cellWidth = (tableWidth - 25) / 4.;
        layout.itemSize = CGSizeMake(cellWidth , 89);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;     //水平滑动
        // 设置最小行间距
        layout.minimumLineSpacing = 0;
        // 设置垂直间距
        layout.minimumInteritemSpacing = 0;
        _subjectViewController = [[ProfessorSubjectCollectionViewController alloc] initWithCollectionViewLayout:layout];
        [self addChildViewController:_subjectViewController];
        [self.subjectHeaderView addSubview:_subjectViewController.view];
       
        [_subjectViewController.view setCornerRadius:9.];
    }
    return _subjectViewController;
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
            if (YES) {
                if (self.recommandCircles) {
                    return self.recommandCircles.count;
                }
            }
            break;
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
            if (YES) {
                return self.recommandCircles[indexPath.row];
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

@end
