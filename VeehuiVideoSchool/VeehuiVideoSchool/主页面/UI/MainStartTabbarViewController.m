//
//  MainStartTabbarViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/19.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MainStartTabbarViewController.h"
#import "HomeStartViewController.h"

@interface MainStartTabbarViewController ()

@end

@implementation MainStartTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeStartViewControllers];
    self.delegate = self;
}

- (void) makeStartViewControllers{
    NSMutableArray<VHBaseViewController*>* controllers = [NSMutableArray<VHBaseViewController*> array];
    [controllers addObject: [[HomeStartViewController alloc] init]];
    [controllers addObject: [[VHBaseViewController alloc] init]];
    [controllers addObject: [[VHBaseViewController alloc] init]];
    [controllers addObject: [[VHBaseViewController alloc] init]];
    [controllers addObject: [[VHBaseViewController alloc] init]];
    
    self.tabBarController.tabBar.tintColor = [UIColor mainThemeColor];
    
    NSArray<NSString*>* tabbarTitles = @[@"首页", @"我学", @"", @"消息", @"我的"];
    NSArray<NSString*>* normalTabbarImageNames = @[@"main_tabbar_home_n", @"main_tabbar_history_n", @"", @"main_tabbar_message_n", @"main_tabbar_account_n"];
    NSArray<NSString*>* highlightTabbarImageNames = @[@"main_tabbar_home_h", @"main_tabbar_history_h", @"", @"main_tabbar_message_h", @"main_tabbar_account_h"];
    NSMutableArray<VHBaseNavigationViewController*>* navigationControllers = [NSMutableArray<VHBaseNavigationViewController*> array];
    [controllers enumerateObjectsUsingBlock:^(VHBaseViewController * _Nonnull controller, NSUInteger idx, BOOL * _Nonnull stop) {
        VHBaseNavigationViewController* navigationController = [[VHBaseNavigationViewController alloc] initWithRootViewController:controller];
        navigationController.navigationBar.translucent = NO;
        [navigationControllers addObject:navigationController];
        
        UITabBarItem * item = [[UITabBarItem alloc] initWithTitle:tabbarTitles[idx] image:[[UIImage imageNamed:normalTabbarImageNames[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:highlightTabbarImageNames[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        navigationController.tabBarItem = item;
        
        [navigationController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor commonDarkGrayTextColor]} forState:UIControlStateNormal];
        [navigationController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor mainThemeColor]} forState:UIControlStateSelected];
        
    }];
    
    [self setViewControllers:navigationControllers];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    NSInteger selectedIndex = [tabBarController.viewControllers indexOfObject:viewController];
    if (selectedIndex == NSNotFound) {
        return NO;
    }
    
    if (selectedIndex == 2) {
        return NO;
    }
    return YES;
}

@end
