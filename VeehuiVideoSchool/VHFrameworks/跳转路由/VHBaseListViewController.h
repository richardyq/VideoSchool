//
//  VHBaseListViewController.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface VHBaseListViewController : VHBaseViewController

@property (nonatomic) NSInteger pageNo;
@property (nonatomic) NSInteger pageSize;
@property (nonatomic) NSInteger totalPages;

@property (nonatomic, strong) NSMutableArray<EntryModel*>* models;

@property (nonatomic, readonly) UITableView* tableview;

- (void) beginRefreshData;
- (void) refreshDataCommand;

- (void) refreshCommandEnd:(NSInteger) pageNo totalPage:(NSInteger) totalPage;

@end

NS_ASSUME_NONNULL_END
