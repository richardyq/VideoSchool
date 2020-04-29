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

@property (nonatomic, strong) UIView* topmostView;
@property (nonatomic, strong) HomeStartNavigationView* navigationView;
@property (nonatomic, strong) HomeStartTableViewController* tableViewController;



@end

@implementation HomeStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self setFd_prefersNavigationBarHidden:YES];
    [self setFd_interactivePopDisabled:YES];
    //self.view.backgroundColor = [UIColor redColor];
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
