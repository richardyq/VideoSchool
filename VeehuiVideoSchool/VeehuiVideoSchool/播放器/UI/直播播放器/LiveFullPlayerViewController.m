//
//  LiveFullPlayerViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/7.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "LiveFullPlayerViewController.h"
#import "LiveFullPlayerView.h"

@interface LiveFullPlayerViewController ()

@end

@implementation LiveFullPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (Class) playerViewClass{
    return [LiveFullPlayerView class];
}

@end
