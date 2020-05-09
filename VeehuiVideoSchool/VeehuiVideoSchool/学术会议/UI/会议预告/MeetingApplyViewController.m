//
//  MeetingApplyViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/8.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingApplyViewController.h"
#import "MeetingDetailModel.h"
#import "UserModuleUtil.h"
#import "MeetingApplyStayTableViewCell.h"

typedef NS_ENUM(NSUInteger, MeetingApplySection) {
    TitleSection,
    PersonSection,
    StaySection,
    SectionCount,
};

typedef NS_ENUM(NSUInteger, ApplyPersonInfoIndex) {
    Name_Index,
    Mobile_Index,
    Gender_Index,
    Title_Index,        //职称
    Duty_Index,
    Orginaztion_Index,
    Department_Index,
    Mail_Index,
    PersonInfoIndexCount,
};

typedef NS_ENUM(NSUInteger, ApplyStayInfoIndex) {
    StayIndex,
    StayDateIndex,
    StayInfoIndexCount,
};

@interface MeetingApplyViewController ()
<UITableViewDelegate>
@property (nonatomic, strong) MeetingDetailModel* meetingDetail;

@end

@implementation MeetingApplyViewController

- (id) initWithMeetingDetail:(MeetingDetailModel*) detail{
    self = [super init];
    if (self) {
        _meetingDetail = detail;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"参会报名";
    self.tableview.backgroundColor = [UIColor commonBackgroundColor];
    self.tableview.mj_header = nil;
    [self.tableview registerClass:[CommonInfoTableViewCell class] forCellReuseIdentifier:[CommonInfoTableViewCell cellReuseIdentifier]];
    [self.tableview registerClass:[CommonEditTableViewCell class] forCellReuseIdentifier:[CommonEditTableViewCell cellReuseIdentifier]];
    [self.tableview registerClass:[MeetingApplyStayTableViewCell class] forCellReuseIdentifier:[MeetingApplyStayTableViewCell cellReuseIdentifier]];
    
    UIBarButtonItem* commitBarItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(commitButtonClicked:)];
    commitBarItem.tintColor = [UIColor mainThemeColor];
    
    [self.navigationItem setRightBarButtonItem:commitBarItem];
}

- (void) makeParamDictionary{
    //TODO:构建特定参数
    [self.paramDictionary setValue:@(self.meetingDetail.id) forKey:@"meetingId"];
}

#pragma mark - DZNEmptyDataSetDelegate
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return NO;
}

#pragma mark - table view data source
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return SectionCount;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case TitleSection:{
            return 1;
            break;
        }
        case PersonSection:{
            return PersonInfoIndexCount;
            break;
        }
        case StaySection:{
            return StayInfoIndexCount;
            break;
        }
        default:
            break;
    }
    return 0;
}

- (Class) tableViewCellClass:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case StaySection:
            switch (indexPath.row) {
                case StayIndex:
                    return [MeetingApplyStayTableViewCell class];
                    break;
                    
                default:
                    break;
            }
            return [CommonEditTableViewCell class];
            break;
            
        default:
            break;
    }
    return [CommonInfoTableViewCell class];
}

- (EntryModel*) entryModel:(NSIndexPath*) indexPath{
    CommonInfoModel* infoModel = [CommonInfoModel new];
    infoModel.placeholder = @"请输入";
    switch (indexPath.section) {
        case TitleSection:{
            infoModel.name = @"会议名称";
            infoModel.value = self.meetingDetail.title;
            break;
        }
        case PersonSection:{
            [self makePersonInfoModel:infoModel infoIndex:indexPath.row];
            break;
        }
        case StaySection:{
            //入住信息
            [self makeStayInfoModel:infoModel stayIndex:indexPath.row];
            break;
        }
        default:
            break;
    }
    return infoModel;
}

- (void) makePersonInfoModel:(CommonInfoModel*) infoModel infoIndex:(ApplyPersonInfoIndex) infoIndex{
    UserInfoModel* userInfo = [UserModuleUtil shareInstance].loginedUserModel;
    infoModel.value = @"无";
    switch (infoIndex) {
        case Name_Index:{
            infoModel.name = @"姓名";
            infoModel.value = userInfo.name;
            break;
        }
        case Mobile_Index:{
            infoModel.name = @"手机号";
            infoModel.value = userInfo.mobile;
            break;
        }
        case Gender_Index:{
            infoModel.name = @"性别";
            infoModel.value = @"未知";
            if (userInfo.sex == 1) {
                infoModel.value = @"男";
            }
            if (userInfo.sex == 2) {
                infoModel.value = @"女";
            }
            break;
        }
        case Title_Index:{
            infoModel.name = @"职称";
            infoModel.value = userInfo.professional;
            break;
        }
        case Duty_Index:{
            infoModel.name = @"职务";
            //infoModel.value = userInfo.mobile;
            break;
        }
        case Orginaztion_Index:{
            infoModel.name = @"单位";
            infoModel.value = userInfo.organization;
            break;
        }
        case Department_Index:{
            infoModel.name = @"科室";
            infoModel.value = userInfo.department;
            break;
        }
        case Mail_Index:{
            infoModel.name = @"邮箱";
            //infoModel.value = userInfo.mobile;
               break;
        }
        default:
            break;
    }
    
    if (!infoModel.value || [infoModel.value isEmpty]) {
        infoModel.value = @"无";
    }
}

- (void) makeStayInfoModel:(CommonInfoModel*) infoModel stayIndex:(ApplyStayInfoIndex) stayIndex{
    switch (stayIndex) {
        case StayIndex:{
            infoModel.name = @"是否住宿";
            break;
        }
        case StayDateIndex:{
            infoModel.name = @"入住时间";
            infoModel.placeholder = @"请选择入住时间";
            break;
        }
        default:
            break;
    }
}

#pragma mark - table view delegate
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case PersonSection:
        case StaySection:{
            return 45.;
            break;
        }
        default:
            break;
    }
    return 0;
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* headerview = nil;
    switch (section) {
        case PersonSection:{
            headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.width, 45.)];
            headerview.backgroundColor = [UIColor commonBackgroundColor];
            [headerview showBoarder:UIViewBorderLineTypeBottom];
            
            UILabel* headerLabel = [headerview addLabel:[UIColor commonTextColor] textSize:16 weight:UIFontWeightMedium];
            headerLabel.text = @"个人信息";
            [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(headerview);
                make.left.equalTo(headerview).offset(12.5);
            }];
            
            UIButton* editButton = [headerview addButton:UIButtonTypeCustom];
            [editButton setTitle:@"编辑" forState:UIControlStateNormal];
            [editButton setTitleColor:[UIColor mainThemeColor] forState:UIControlStateNormal];
            [editButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
            
            [editButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(headerview);
                make.right.equalTo(headerview).offset(-12.5);
            }];
            break;
        }
        case StaySection:{
            headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.width, 45.)];
            headerview.backgroundColor = [UIColor commonBackgroundColor];
            [headerview showBoarder:UIViewBorderLineTypeBottom];
            
            UILabel* headerLabel = [headerview addLabel:[UIColor commonTextColor] textSize:16 weight:UIFontWeightMedium];
            headerLabel.text = @"入住信息";
            [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(headerview);
                make.left.equalTo(headerview).offset(12.5);
            }];
        }
        default:
            break;
    }
    return headerview;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    switch (section) {
        case StaySection:
            return 15.;
            break;
            
        default:
            break;
    }
    return 0;
}

- (UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView* footerview = nil;
    switch (section) {
        case StaySection:{
            footerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.width, 15.)];
            footerview.backgroundColor = [UIColor commonBackgroundColor];
            break;
        }
        default:
            break;
    }
    return footerview;
}

- (void) commitButtonClicked:(id) sender{
    
}
@end
