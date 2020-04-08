//
//  MedicalStartGridTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/7.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalStartGridTableViewCell.h"

@interface MedicalVideoGridItemControl : VHGridItemControl

@end

@implementation MedicalVideoGridItemControl

- (UILabel*) buildNameLabel{
    return [self addLabel:[UIColor commonDarkGrayTextColor] textSize:12];
}

- (CGSize) iconImageSize{
    return CGSizeMake(38, 38);
}

- (CGFloat) nameTopOffset{
    return 9.;
}

@end

@interface MedicalStartGridTableViewCell ()

@property (nonatomic, strong) UIView* gridview;
@property (nonatomic, strong) NSArray<VHGridItemControl*>* gridItems;

@end

@implementation MedicalStartGridTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.gridview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 5, 0, 5));
    }];
    
    __block MASViewAttribute* gridLeft = self.gridview.mas_left;
    __block MASViewAttribute* gridTop = self.gridview.mas_top;
    
    [self.gridItems enumerateObjectsUsingBlock:^(VHGridItemControl * _Nonnull gridItem, NSUInteger idx, BOOL * _Nonnull stop) {
        [gridItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(gridLeft);
            make.top.equalTo(gridTop);
            make.width.equalTo(self.gridview).dividedBy(4);
            
            if (gridItem == self.gridItems.lastObject) {
                make.bottom.equalTo(self.gridview);
            }
        }];
        gridLeft = gridItem.mas_right;
        if ((idx % 4) == 3) {
            gridLeft = self.gridview.mas_left;
            gridTop = gridItem.mas_bottom;
        }
        
    }];
}

#pragma mark - settingAndGetting
- (UIView*) gridview{
    if (!_gridview) {
        _gridview = [self.contentView addView];
    }
    return _gridview;
}

- (NSArray<VHGridItemControl*>*) gridItems{
    if (!_gridItems) {
        NSMutableArray<VHGridItemControl*>* items = [NSMutableArray<VHGridItemControl*> array];
        [items addObject:[[MedicalVideoGridItemControl alloc] initWithImageName:@"ic_video_academic_frontier" name:@"学术前沿"]];
        [items addObject:[[MedicalVideoGridItemControl alloc] initWithImageName:@"ic_video_case_analysis" name:@"病例分析"]];
        [items addObject:[[MedicalVideoGridItemControl alloc] initWithImageName:@"ic_video_medical_skill" name:@"医疗技能"]];
        [items addObject:[[MedicalVideoGridItemControl alloc] initWithImageName:@"ic_video_surgery" name:@"手术视频"]];
        
        [items addObject:[[MedicalVideoGridItemControl alloc] initWithImageName:@"ic_video_MDT" name:@"MDT"]];
        [items addObject:[[MedicalVideoGridItemControl alloc] initWithImageName:@"ic_patient_classrom" name:@"患者课堂"]];
        [items addObject:[[MedicalVideoGridItemControl alloc] initWithImageName:@"ic_video_practice_examine" name:@"执业考试"]];
        [items addObject:[[MedicalVideoGridItemControl alloc] initWithImageName:@"ic_video_all" name:@"查看全部"]];
        
        [items enumerateObjectsUsingBlock:^(VHGridItemControl * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.gridview addSubview:item];
        }];
        _gridItems = items;
    }
    return _gridItems;
}

@end
