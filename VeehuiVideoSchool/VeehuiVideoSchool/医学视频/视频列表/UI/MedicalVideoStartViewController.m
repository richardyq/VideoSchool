//
//  MedicalVideoStartViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/19.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalVideoStartViewController.h"
#import "MedicalVideoListBussiness.h"
#import "MedicalVideoClassifyEntryModel.h"

@interface MedicalVideoStartViewController ()

@property (nonatomic, strong) SegmentView* segmentView;

@property (nonatomic, strong) NSArray<MedicalVideoClassifyEntryModel*>* videoClassifies;
@end

@implementation MedicalVideoStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"医学视频";
    
    [self startLoadClassify];
}

- (void) updateViewConstraints{
    [super updateViewConstraints];
    
    [self.segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(@45);
    }];
}


//获取医学视频分类
- (void) startLoadClassify{
    WS(weakSelf)
    [MedicalVideoListBussiness startLoadMediaclVideoClassify:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if (result && [result isKindOfClass:[NSArray class]]) {
            [weakSelf videoClassifiesLoaded:result];
        }
    } complete:^(NSInteger code, NSString *message) {
        
    }];
}

- (void) videoClassifiesLoaded:(NSArray<MedicalVideoClassifyEntryModel*>*) classifies{
    _videoClassifies = classifies;
    
    NSArray<NSString*>* titles = [classifies valueForKey:@"name"];
    [self.segmentView setSegmentTitles:titles];
}

#pragma mark - settingAndGetting
- (SegmentView*) segmentView{
    if (!_segmentView) {
        _segmentView = [[SegmentView alloc] initWithNormalFont:[UIFont systemFontOfSize:13] normalColor:[UIColor commonGrayTextColor] highFont:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium] highColor:[UIColor mainThemeColor]];
        [self.view addSubview:_segmentView];
        _segmentView.minSegmentCellWidth = (kScreenWidth / 4.5);
        _segmentView.indicateWidth = 27.5;
    }
    return _segmentView;
}


@end
