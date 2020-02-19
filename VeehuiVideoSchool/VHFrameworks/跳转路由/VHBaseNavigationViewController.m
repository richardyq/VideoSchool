//
//  VHBaseNavigationViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHBaseNavigationViewController.h"

@interface VHBaseNavigationViewController ()

@end

@implementation VHBaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBar setBarTintColor:[UIColor commonBackgroundColor]];
    self.navigationBar.tintColor = [UIColor commonTextColor];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor commonTextColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];
    [self.navigationBar setTranslucent:NO];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{   //拦截所有push进来的子控制器
    if(self.viewControllers.count > 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageNamed:@"ic_back_arrow" targe:self action:@selector(backUp)];
        
    }
    [super pushViewController:viewController animated:animated];
    
}

- (void)backUp
{
    [self popViewControllerAnimated:YES];
}


@end
