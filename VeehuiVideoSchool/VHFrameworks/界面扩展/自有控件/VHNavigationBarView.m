//
//  VHNavigationBarView.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/11.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHNavigationBarView.h"

@interface VHNavigationBarView ()

@property (nonatomic, strong) UIButton* backButton;

@end

@implementation VHNavigationBarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id) initWithNavigationType:(ENavigationType) navigationType{
    self = [super init];
    if (self) {
        [self setNavigationType:navigationType];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(36, 36));
        make.left.equalTo(self).offset(21);
        make.bottom.equalTo(self).offset(-4);
    }];
}

#pragma mark - settingAndGetting
- (UIButton*) backButton{
    if (!_backButton) {
        _backButton = [self addButtonWithImageName:@"ic_back_arrow"];
        _backButton.backgroundColor = [UIColor colorWithHexString:@"00000046"];
        [_backButton setCornerRadius:18];
        [_backButton setImage:[[UIImage imageNamed:@"ic_back_arrow"] imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (void) setNavigationType:(ENavigationType)navigationType{
    if (_navigationType == navigationType) {
        return;
    }
    
    _navigationType = navigationType;
    switch (navigationType) {
        case Navigation_Trans:{
            self.backgroundColor = [UIColor clearColor];
            self.backButton.backgroundColor = [UIColor colorWithHexString:@"00000046"];
            [self.backButton setImage:[[UIImage imageNamed:@"ic_back_arrow"] imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            break;
        }
        case Navigation_Normal:{
            self.backgroundColor = [UIColor commonBackgroundColor];
            self.backButton.backgroundColor = [UIColor clearColor];
            [self.backButton setImage:[UIImage imageNamed:@"ic_back_arrow"] forState:UIControlStateNormal];
            break;
        }
        default:
            break;
    }
}


#pragma mark - back button events
- (void) backButtonClicked:(id) sender{
    UIViewController* controller = [self viewController];
    if (!controller) {
        controller = [NSObject topMostController];
    }
    
    NSArray *viewcontrollers = controller.navigationController.viewControllers;
    if (viewcontrollers.count>1 && viewcontrollers.lastObject==controller){
            //push方式
        [controller.navigationController popViewControllerAnimated:YES];
    }
    else{
            //present方式
        [controller dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
