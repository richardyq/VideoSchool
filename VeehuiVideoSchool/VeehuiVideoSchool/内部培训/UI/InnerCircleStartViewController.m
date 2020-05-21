//
//  InnerCircleStartViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "InnerCircleStartViewController.h"
#import "InnerCircleBussiness.h"
#import "JoinedCircleEntryModel.h"
#import "InnerCircleStartInfoTableViewCell.h"
#import "InnerCircleStartGridTableViewCell.h"

typedef NS_ENUM(NSUInteger, InnerCircleStartTableSection) {
    CircleInfoSection,
    CircleGirdSection,
    SectionCount,
};

@interface InnerCircleStartViewController ()

@property (nonatomic) NSInteger circleId;

@property (nonatomic, strong) UIImageView* topImageView;

@property (nonatomic, strong) UIView* navigationView;
@property (nonatomic, strong) UIButton* backButton;

@property (nonatomic, strong) JoinedCircleEntryModel* joinedCircleModel;

@end

@implementation InnerCircleStartViewController

- (id) initWithCircleId:(NSInteger) circleId{
    self = [super init];
    if (self) {
        _circleId = circleId;
    }
    return self;
}

- (void)viewDidLoad {
    self.topImageView.image = [UIImage imageNamed:@"img_inner_circle_top_background"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setFd_interactivePopDisabled:YES];
    [self setFd_prefersNavigationBarHidden:YES];
    
    self.tableview.mj_header = nil;
    self.view.backgroundColor = [UIColor commonBackgroundColor];
    self.tableview.backgroundColor = [UIColor clearColor];
    
    [self.tableview registerClass:[InnerCircleStartInfoTableViewCell class] forCellReuseIdentifier:[InnerCircleStartInfoTableViewCell cellReuseIdentifier]];
    [self.tableview registerClass:[InnerCircleStartGridTableViewCell class] forCellReuseIdentifier:[InnerCircleStartGridTableViewCell cellReuseIdentifier]];
    
    [self changeCircleId:self.circleId];
}

- (void) updateViewConstraints{
    [super updateViewConstraints];
    
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(@(196. * ScreenSizeRate));
    }];
    
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(@(Navi_height));
    }];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.bottom.equalTo(self.navigationView).offset(-2);
        make.left.equalTo(self.navigationView).offset(12);
    }];
    
    [self.tableview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.navigationView.mas_bottom);
    }];
}

- (void) makeParamDictionary{
    //TODO:构建特定参数
    [self.paramDictionary setValue:@(self.circleId) forKey:@"circleId"];
    
}

#pragma mark - settingAndGetting
- (UIImageView*) topImageView{
    if (!_topImageView) {
        _topImageView = [self.view addImageView:@"img_inner_circle_top_background"];
    }
    return _topImageView;
}

- (UIView*) navigationView{
    if (!_navigationView) {
        _navigationView = [self.view addView];
        _navigationView.backgroundColor = [UIColor clearColor];
    }
    return _navigationView;
}

- (UIButton*) backButton{
    if (!_backButton) {
        _backButton = [self.navigationView addButton:UIButtonTypeCustom];
        [_backButton setImage:[[UIImage imageNamed:@"ic_back_arrow"] imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        WS(weakSelf)
        [_backButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            SAFE_WEAKSELF(weakSelf)
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }
    return _backButton;
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return NO;
}

#pragma mark 获取数据
- (void) changeCircleId:(NSInteger) circleId{
    _circleId = circleId;
    
    [self startLoadCircleInfo];
}

- (void) startLoadCircleInfo{
    WS(weakSelf)
    [InnerCircleBussiness startLoadInnerInfo:self.circleId result:^(id result) {
        if ([result isKindOfClass:[JoinedCircleEntryModel class]]) {
            SAFE_WEAKSELF(weakSelf)
            weakSelf.joinedCircleModel = result;
        }
    } complete:^(NSInteger code, NSString *message) {
        SAFE_WEAKSELF(weakSelf)
        if (code == 0) {
            [weakSelf.tableview reloadData];
        }
    }];
}

#pragma mark - table view data source
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return SectionCount;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case CircleInfoSection:{
            return 1;
            break;
        }
        case CircleGirdSection:{
            return 1;
            break;
        }
        default:
            break;
    }
    return 0;
}

- (Class) tableViewCellClass:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case CircleInfoSection:{
            return [InnerCircleStartInfoTableViewCell class];
            break;
        }
        case CircleGirdSection:{
            return [InnerCircleStartGridTableViewCell class];
            break;
        }
        default:
            break;
    }
    return [VHTableViewCell class];
}

- (EntryModel*) entryModel:(NSIndexPath*) indexPath{
    switch (indexPath.section) {
        case CircleInfoSection:{
            return self.joinedCircleModel;
            break;
        }
        default:
            break;
    }
    return nil;
}
@end
