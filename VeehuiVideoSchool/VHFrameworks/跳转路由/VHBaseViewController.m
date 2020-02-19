//
//  VHBaseViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/17.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHBaseViewController.h"

@interface VHBaseViewController ()

@property (nonatomic, strong) NSMutableDictionary* controllerDictionary;
@property (nonatomic, strong) NSMutableDictionary* paramDictionary;

@end

@implementation VHBaseViewController

@synthesize controllerId = _controllerId;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor commonBackgroundColor];
    [self.view setNeedsUpdateConstraints];
    
    
}

- (void) onDismissControllerHandler:(dismissControllerHandler) handler{
    self.dismissHandler = handler;
}

- (void) makeParamDictionary{
    //TODO:构建特定参数
}

#pragma mark - settingAndGetting
- (NSMutableDictionary*) controllerDictionary{
    if (!_controllerDictionary) {
        _controllerDictionary = [NSMutableDictionary dictionary];
        NSString* controllerName = NSStringFromClass([self class]);
        [_controllerDictionary setValue:controllerName forKey:@"classname"];
        
        if (self.paramDictionary && self.paramDictionary.count > 0) {
            [_controllerDictionary setValue:self.paramDictionary forKey:@"classparam"];
        }
    }
    return _controllerDictionary;
}

- (NSMutableDictionary*) paramDictionary{
    if (!_paramDictionary) {
        _paramDictionary = [NSMutableDictionary dictionary];
    }
    return _paramDictionary;
}

- (NSString*) controllerId{
    if (!_controllerId) {
        _controllerId = [self.controllerDictionary mj_JSONString];
    }
    return _controllerId;
}

- (void) dismissController:(_Nullable id) ret{
    if (self.dismissHandler) {
        self.dismissHandler(ret);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
