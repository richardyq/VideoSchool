//
//  MedicalStartVideoSegmentTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/7.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalStartVideoSegmentTableViewCell.h"
#import "MedicalVideoCategoryView.h"
#import "MedicalVideoPageRouter.h"
@interface MedicalStartVideoSegmentTableViewCell ()

@property (nonatomic, strong) MedicalVideoCategoryView* categoryView;
//@property (nonatomic, strong) SegmentView* segmentview;

@end


@implementation MedicalStartVideoSegmentTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor commonBackgroundColor];
    }
    return self;
}

- (id) initWithCategories:(NSArray<MedicalVideoClassifyEntryModel*>*) categories{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MedicalStartVideoSegmentTableViewCell"];
    if (self) {
        self.contentView.backgroundColor = [UIColor commonBackgroundColor];
        
        WS(weakSelf)
        _categoryView = [[MedicalVideoCategoryView alloc] initWithCategories:categories selectAction:^(NSInteger index) {
            SAFE_WEAKSELF(weakSelf)
            MedicalVideoClassifyEntryModel* cateModel = categories[index];
            [weakSelf segmentViewSelectedIndexChanged:cateModel];
        }];
        [self.contentView addSubview:_categoryView];
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(5, 15, 5, 15));
    }];
}

#pragma mark - settingAndGetting


- (void) segmentViewSelectedIndexChanged:(MedicalVideoClassifyEntryModel*) category{
    //跳转到分类视频列表
    [MedicalVideoPageRouter entryClassifiedMedicalVideListPage:category];
}



@end
