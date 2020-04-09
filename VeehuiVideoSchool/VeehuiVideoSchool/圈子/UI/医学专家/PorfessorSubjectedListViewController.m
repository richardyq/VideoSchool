//
//  PorfessorSubjectedListViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/9.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "PorfessorSubjectedListViewController.h"
#import "MedicalVideoClassifyEntryModel.h"

@interface PorfessorSubjectedListViewController ()

@property (nonatomic, strong) MedicalVideoClassifyEntryModel* classifyModel;
@end

@implementation PorfessorSubjectedListViewController

- (id) initWithClassifyModel:(MedicalVideoClassifyEntryModel*) classify{
    self = [super init];
    if (self) {
        _classifyModel = classify;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.classifyModel.name;
}



@end
