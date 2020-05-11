//
//  HomeStartViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/19.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "HomeStartViewController.h"
#import "HomeStartNavigationView.h"
#import "HomeStartTableViewController.h"
#import "HomeStartMeetingInfoTableViewCell.h"

@interface HomeStartViewController ()
@property (nonatomic, strong) HomeStartNavigationView* navigationView;
@property (nonatomic, strong) HomeStartTableViewController* tableViewController;



@end

@implementation HomeStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage* backgroundImage = [UIImage gradientColorImageFromColors:@[[UIColor whiteColor], [UIColor commonBackgroundColor]] gradientType:GradientTypeTopToBottom imgSize:CGSizeMake(kScreenWidth, kScreenHeight/2)];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    self.view.backgroundColor = [UIColor commonBackgroundColor];
    
    UIView* halfView = [self.view addView];
    halfView.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    [halfView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(@(kScreenHeight/2));
    }];
    
    // Do any additional setup after loading the view.
    [self setFd_prefersNavigationBarHidden:YES];
    [self setFd_interactivePopDisabled:YES];
}

- (void) updateViewConstraints{
    [super updateViewConstraints];
    
    
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(@44);
        make.top.equalTo(self.view).offset(Status_Height);
    }];
    
    [self.tableViewController.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.navigationView.mas_bottom);
    }];
}


#pragma mark - settingAndGetting


- (HomeStartNavigationView*) navigationView{
    if (!_navigationView) {
        _navigationView = (HomeStartNavigationView*)[self.view addView:[HomeStartNavigationView class]];
        
    }
    return _navigationView;
}

- (HomeStartTableViewController*) tableViewController{
    if (!_tableViewController) {
        _tableViewController = [[HomeStartTableViewController alloc] initWithStyle:UITableViewStylePlain];
        [self addChildViewController:_tableViewController];
        [self.view addSubview:_tableViewController.tableView];
    }
    return _tableViewController;
}



@end
