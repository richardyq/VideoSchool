//
//  FavoriteChooseViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/9.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "FavoriteChooseViewController.h"
#import "CommonBaseBussiness.h"
#import "FavoriteEntryModel.h"
#import "FavoriteChooseTableViewCell.h"

@interface FavoriteChooseViewController ()
@property (nonatomic, strong) NSArray<FavoriteEntryModel*>* favorites;

@end

@implementation FavoriteChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableview.mj_header = nil;
    self.navigationItem.title = @"选择感兴趣学科";
    [self.tableview registerClass:[FavoriteChooseTableViewCell class] forCellReuseIdentifier:[FavoriteChooseTableViewCell cellReuseIdentifier]];
    [self startLoadFavorites];
    
    UIBarButtonItem* submitBarItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(submitItemClicked:)];
    submitBarItem.tintColor = [UIColor mainThemeColor];
    self.navigationItem.rightBarButtonItem = submitBarItem;
}

#pragma mark - 获取所有兴趣学科列表
- (void) startLoadFavorites{
    WS(weakSelf)
    [MessageHubUtil showWait:@"请稍等，数据正在路上"];
    [CommonBaseBussiness loadFavoriteSubjects:^(id result) {
        if ([result isKindOfClass:[NSArray class]]) {
            weakSelf.favorites = result;
        }
    } complete:^(NSInteger code, NSString *message) {
        [MessageHubUtil hideMessage];
        SAFE_WEAKSELF(weakSelf)
        if (code != 0) {
            [MessageHubUtil showErrorMessage:message];
            return;
        }
        [weakSelf.tableview reloadData];
    }];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return self.favorites.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (VHTableViewCell*) tableViewCell:(Class) class indexPath:(NSIndexPath*) indexPath{
    VHTableViewCell* cell = [[FavoriteChooseTableViewCell alloc] initWithFavoriteModel:self.favorites[indexPath.section]];
    
    return cell;
}

- (Class) tableViewCellClass:(NSIndexPath *)indexPath{
    return [FavoriteChooseTableViewCell class];
}

- (EntryModel*) entryModel:(NSIndexPath*) indexPath{
    return self.favorites[indexPath.section];
}

#pragma mark - table view delegate
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 42;
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.width, 42.)];
    headerview.backgroundColor = [UIColor commonBackgroundColor];
    [headerview showBoarder:UIViewBorderLineTypeBottom];
    
    UILabel* nameLabel = [headerview addLabel:[UIColor mainThemeColor] textSize:15 weight:UIFontWeightMedium];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerview).offset(15);
        make.centerY.equalTo(headerview);
    }];
    nameLabel.text = self.favorites[section].name;
    
    return headerview;
}

#pragma mark - submit event
- (void) submitItemClicked:(id) sender{
    if ([SVProgressHUD isVisible]) {
        NSLog(@"操作不能太频繁。。。");
        return;
    }
    
    NSMutableArray<FavoriteEntryModel*>* chosenFavorites = [NSMutableArray<FavoriteEntryModel*> array];
    //构建以选择的兴趣学科
    [self.favorites enumerateObjectsUsingBlock:^(FavoriteEntryModel * _Nonnull favorite, NSUInteger idx, BOOL * _Nonnull stop) {
        [favorite.childrens enumerateObjectsUsingBlock:^(FavoriteEntryModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            if (model.chosen) {
                [chosenFavorites addObject:model];
            }
        }];
    }];
    
    if (chosenFavorites.count == 0) {
        //没有选择任何学科
        [MessageHubUtil showInfoMessage:@"对不起，您还没有选择任何学科，请至少选择一个。"];
        return;
    }
    
    //提交选择的兴趣学科
    [MessageHubUtil showWait:@"请稍等"];
    WS(weakSelf)
    [CommonBaseBussiness saveFavoriteSubjects:chosenFavorites result:^(id result) {
        
    } complete:^(NSInteger code, NSString *message) {
        [MessageHubUtil hideMessage];
        SAFE_WEAKSELF(weakSelf)
        if (code != 0) {
            [MessageHubUtil showErrorMessage:message];
            return;
        }
        //保存成功
        [weakSelf performSelectorWithArgs:@selector(chosenFavoritesSaved) afterDelay:1.2];
    }];
}
     
#pragma mark - 兴趣学科已保存成功
- (void) chosenFavoritesSaved{
    [self dismissController:nil];
}
@end
