//
//  MedicalClassifyVideoListViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalClassifyVideoListViewController.h"

@interface MedicalClassifyVideoListViewController ()

@property (nonatomic, readonly) MedicalVideoClassifyEntryModel* classifyModel;

@end

@implementation MedicalClassifyVideoListViewController

- (id) initWithClassifyModel:(MedicalVideoClassifyEntryModel*) classifyEntryModel{
    self = [super init];
    if (self) {
        _classifyModel = classifyEntryModel;
    }
    return self;
}

- (void) makeParamDictionary{
    //TODO:构建特定参数
    if (self.classifyModel && self.classifyModel.code
        && ![self.classifyModel.code isEmpty]) {
        [self.paramDictionary setValue:self.classifyModel.code forKey:@"code"];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.classifyModel.name;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
