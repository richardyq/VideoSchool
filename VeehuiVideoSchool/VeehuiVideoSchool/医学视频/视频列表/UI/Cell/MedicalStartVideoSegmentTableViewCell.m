//
//  MedicalStartVideoSegmentTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/7.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalStartVideoSegmentTableViewCell.h"

@interface MedicalStartVideoSegmentTableViewCell ()

@property (nonatomic, strong) SegmentView* segmentview;

@end


@implementation MedicalStartVideoSegmentTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.segmentview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(@45);
        make.edges.equalTo(self.contentView);
    }];
}

#pragma mark - settingAndGetting
- (SegmentView*) segmentview{
    if (!_segmentview) {
        _segmentview = [[SegmentView alloc] initWithNormalFont:[UIFont systemFontOfSize:13] normalColor:[UIColor commonGrayTextColor] highFont:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium] highColor:[UIColor mainThemeColor]];
        [self.contentView addSubview:_segmentview];
        _segmentview.minSegmentCellWidth = (kScreenWidth / 4.5);
        if ([UIDevice currentDevice].isPad) {
            _segmentview.minSegmentCellWidth = (kScreenWidth / 4.5 * 0.7);
        }
        _segmentview.indicateWidth = 27.5;
        WS(weakSelf)
        [_segmentview onSelectedIndexChanged:^(NSInteger index) {
            SAFE_WEAKSELF(weakSelf)
            [weakSelf segmentViewSelectedIndexChanged:index];
        }];
    }
    return _segmentview;
}

- (void) segmentViewSelectedIndexChanged:(NSInteger) index{
    
}

- (void) setSubjectNames:(NSArray<NSString*>*) names{
    [self.segmentview setSegmentTitles:names];
}

@end
