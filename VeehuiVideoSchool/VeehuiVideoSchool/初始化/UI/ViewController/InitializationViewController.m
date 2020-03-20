//
//  InitializationViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/17.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "InitializationViewController.h"
#import "InitializeUtil.h"

@interface InitializationViewController ()

@property (nonatomic, strong) UIImageView* logoImageView;
@property (nonatomic, strong) UIImageView* bottomImageView;

@end

@implementation InitializationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    [self.view setNeedsUpdateConstraints];
    [InitializeUtil shareInstance];
    //[[InitializeUtil shareInstance] startInitialize];
    //[self performSelector:@selector(startInitialize) afterDelay:1.2];
}

- (void) startInitialize{
    //[[InitializeUtil shareInstance] startInitialize];
}

- (void) updateViewConstraints{
    [super updateViewConstraints];
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-213);
    }];
    
    [self.bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-(44 + PhoneXBottom));
    }];
}


#pragma mark - settingAndGetting
- (UIImageView*) logoImageView{
    if (!_logoImageView) {
        _logoImageView = [self.view addImageView:@"img_init_logo"];
    }
    return _logoImageView;
}

- (UIImageView*) bottomImageView{
    if (!_bottomImageView) {
        _bottomImageView = [self.view addImageView:@"img_init_bottom"];
    }
    return _bottomImageView;
}

@end
