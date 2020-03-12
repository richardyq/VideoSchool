//
//  VHBaseListViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHBaseListViewController.h"
#import "VHRefeshStatusHeader.h"

@interface VHBaseListViewController ()
<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, readonly) UITableViewStyle tableViewStyle;

@end

@implementation VHBaseListViewController

@synthesize tableview = _tableview;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _pageSize = 20;
    _pageNo = 1;
    
    WS(weakSelf)
    self.tableview.mj_header = [VHRefeshStatusHeader headerWithRefreshingBlock:^{
        SAFE_WEAKSELF(weakSelf)
        [weakSelf refreshDataCommand];
    }];
}

- (void) updateViewConstraints{
    [super updateViewConstraints];
    
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.view);
        make.centerX.equalTo(self.view);
        if ([UIDevice currentDevice].isPad) {
            make.width.equalTo(self.view).multipliedBy(0.7);
        }
        else{
            make.width.equalTo(self.view);
        }
    }];
}

#pragma mark - settingAndGetting
- (UITableView*) tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:self.tableViewStyle];
        [self.view addSubview:_tableview];
        _tableview.estimatedRowHeight = 45.;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableview registerClass:[VHTableViewCell class] forCellReuseIdentifier:[VHTableViewCell cellReuseIdentifier]];
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}

- (UITableViewStyle) tableViewStyle{
    return UITableViewStylePlain;
}

- (NSMutableArray<EntryModel*>*) models{
    if (!_models) {
        _models = [NSMutableArray<EntryModel*> array];
    }
    return _models;
}
#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [self tableViewCell:[self tableViewCellClass:indexPath] indexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (Class) tableViewCellClass:(NSIndexPath *)indexPath{
    return [VHTableViewCell class];
}

- (VHTableViewCell*) tableViewCell:(Class) class indexPath:(NSIndexPath*) indexPath{
    VHTableViewCell* cell = [self.tableview dequeueReusableCellWithIdentifier:[VHTableViewCell cellReuseIdentifier]];
    if ([class isSubclassOfClass:[VHTableViewCell class]] ||
        [class isKindOfClass:[VHTableViewCell class]]) {
        NSString* cellReuseIdentifier = [class cellReuseIdentifier];
        cell = [self.tableview dequeueReusableCellWithIdentifier:cellReuseIdentifier];
        [cell setEntryModel:[self entryModel:indexPath]];
    }
    
    return cell;
}

- (EntryModel*) entryModel:(NSIndexPath*) indexPath{
    if (self.models.count > 0 && self.models.count > indexPath.row) {
        return self.models[indexPath.row];
    }
    return nil;
}

#pragma mark - 分页刷新
- (void) beginRefreshData{
    
    [self.tableview.mj_header beginRefreshing];
}

//下拉刷新，获取新数据
- (void) refreshDataCommand{
    
}

- (void) loadMoreDataCommand{
    
}

- (void) refreshCommandEnd:(NSInteger) pageNo totalPage:(NSInteger) totalPage{
    [self.tableview.mj_header endRefreshing];
    
    WS(weakSelf)
    if (!self.tableview.mj_footer) {
        self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            SAFE_WEAKSELF(weakSelf)
           [weakSelf loadMoreDataCommand];
        }];
    }
    
    if (totalPage > pageNo) {
        
        [self.tableview.mj_footer endRefreshing];
    }
    else{
        [self.tableview.mj_footer endRefreshingWithNoMoreData];
    }
}

#pragma mark

- (void) scrollViewDidScroll:(UIScrollView *)scrollView{

    CGPoint contentOffset = scrollView.contentOffset;
    //CGFloat offsetY = scrollView.contentOffset.y;
    if (!self.tableview.dataSource || ![self.tableview.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        return;
    }
    NSInteger topmostSection = NSNotFound;
    NSInteger sectionCount = [self.tableview.dataSource numberOfSectionsInTableView:self.tableview];
    for (NSInteger section = 0; section < sectionCount; ++section) {
        CGRect sectionRect = [self.tableview rectForSection:section];
        if (CGRectContainsPoint(sectionRect, contentOffset)) {
            topmostSection = section;
            break;
        }
    }
    
    if (topmostSection != NSNotFound) {
        [self tableviewDidScrollToSection:topmostSection];
    }
}

- (void) tableviewDidScrollToSection:(NSInteger) section{
    
}

@end
