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
}

- (void) makeStartViewControllers{
    NSMutableArray<VHBaseViewController*>* controllers = [NSMutableArray<VHBaseViewController*> array];
    [controllers addObject: [[HomeStartViewController alloc] init]];
    [controllers addObject: [[VHBaseViewController alloc] init]];
    [controllers addObject: [[VHBaseViewController alloc] init]];
    [controllers addObject: [[VHBaseViewController alloc] init]];
    [controllers addObject: [[VHBaseViewController alloc] init]];
    
    NSMutableArray<VHBaseNavigationViewController*>* navigationControllers = [NSMutableArray<VHBaseNavigationViewController*> array];
    [controllers enumerateObjectsUsingBlock:^(VHBaseViewController * _Nonnull controller, NSUInteger idx, BOOL * _Nonnull stop) {
        [navigationControllers addObject:[[VHBaseNavigationViewController alloc] initWithRootViewController:controller]];
    }];
    
    [self setViewControllers:navigationControllers];
}

@end
