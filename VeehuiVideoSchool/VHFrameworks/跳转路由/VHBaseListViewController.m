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
<UITableViewDataSource, UITableViewDelegate,
DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, readonly) UITableViewStyle tableViewStyle;

@end

@implementation VHBaseListViewController

@synthesize tableview = _tableview;

- (void) dealloc{
    if (self.tableview.mj_header) {
        [self.tableview.mj_header removeObserver:self forKeyPath:@"state"];
    }
}

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
    
    [self.tableview.mj_header addObserver:self forKeyPath:@"state" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
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
        
        _tableview.emptyDataSetSource = self;
        _tableview.emptyDataSetDelegate = self;
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
    [self.tableview reloadData];
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

#pragma mark - observice
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object == self.tableview.mj_header) {
        if ([keyPath isEqualToString:@"state"]) {
            MJRefreshState refreshState = self.tableview.mj_header.state;
            [self headerRefreshStateChanged:refreshState];
        }
    }
    
    if (object == self.tableview.mj_footer) {
        if ([keyPath isEqualToString:@"state"]) {
            MJRefreshState refreshState = self.tableview.mj_header.state;
            [self footerRefreshStateChanged:refreshState];
        }
    }
}

- (void) headerRefreshStateChanged:(MJRefreshState) state{
    NSLog(@"headerRefreshStateChanged : %ld", state);
    [self.tableview reloadData];
}

- (void) footerRefreshStateChanged:(MJRefreshState) state{
    NSLog(@"footerRefreshStateChanged : %ld", state);
    [self.tableview reloadData];
}

#pragma mark - DZNEmptyDataSetDelegate
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return self.models.count == 0;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}

#pragma mark - DZNEmptyDataSetSource
- (nullable UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView{
    UIView* emptyview = [UIView new];
    
    if (self.tableview.mj_header.state == MJRefreshStateRefreshing) {
        emptyview = [self loadingEmptyView];
    }
    else{
        emptyview = [self normalEmptyView];
        if (self.errorMessage || [self.errorMessage isEmpty]) {
            emptyview = [self normalErrorEmptyView];
        }
    }
    return emptyview;
}

- (UIView*) loadingEmptyView{
    UIView* emptyview = [UIView new];
    
    UIImageView* waitingImageView = [emptyview addImageView:@"img_waiting"];
    UILabel* waitingLabel = [emptyview addLabel:[UIColor commonDarkGrayTextColor] textSize:13];
    waitingLabel.text = @"稍等片刻，马上就好";
    
    [waitingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(63, 63));
        make.top.equalTo(emptyview);
        make.centerX.equalTo(emptyview);
    }];
    
    [waitingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.lessThanOrEqualTo(emptyview);
        make.bottom.equalTo(emptyview);
        make.centerX.equalTo(emptyview);
        make.top.equalTo(waitingImageView.mas_bottom).offset(15);
    }];
                                
    return emptyview;
}

- (UIView*) normalEmptyView{
    UIView* emptyview = [UIView new];
    
    UIImageView* emptyImageView = [emptyview addImageView:@"img_empty"];
    UILabel* emptyLabel = [emptyview addLabel:[UIColor commonDarkGrayTextColor] textSize:13];
    
    emptyLabel.text = [self emptyTableText];
    
    [emptyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(145, 100));
        make.top.equalTo(emptyview);
        make.centerX.equalTo(emptyview);
    }];
    
    [emptyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.lessThanOrEqualTo(emptyview);
        make.bottom.equalTo(emptyview);
        make.centerX.equalTo(emptyview);
        make.top.equalTo(emptyImageView.mas_bottom).offset(15);
    }];
                                
    return emptyview;
}

- (UIView*) normalErrorEmptyView{
    UIView* emptyview = [UIView new];
    
    UIImageView* emptyImageView = [emptyview addImageView:@"img_empty"];
    UILabel* emptyLabel = [emptyview addLabel:[UIColor commonDarkGrayTextColor] textSize:13];
    
    emptyLabel.text = self.errorMessage;
    
    [emptyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(145, 100));
        make.top.equalTo(emptyview);
        make.centerX.equalTo(emptyview);
    }];
    
    [emptyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.lessThanOrEqualTo(emptyview);
        make.bottom.equalTo(emptyview);
        make.centerX.equalTo(emptyview);
        make.top.equalTo(emptyImageView.mas_bottom).offset(15);
    }];
                                
    return emptyview;
}

- (NSString*) emptyTableText{
    return @"无数据提示";
}
@end
