//
//  MedicalVideoDetailDirectoryTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/12.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalVideoDetailDirectoryTableViewCell.h"
#import "MedicalVideoGroupDetailEntryModel.h"

@interface MedicalVideoDetailDirectoryCell : UIControl

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* speakerLabel;

- (id) initWithVideoItem:(MedicalVideoEntryModel*) videoModel index:(NSInteger) index;

@end

@implementation MedicalVideoDetailDirectoryCell

- (id) initWithVideoItem:(MedicalVideoEntryModel*) videoModel index:(NSInteger) index{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#F7F8FC"];
        [self setCornerRadius:1.];
        
        NSString* videoTitle = [NSString stringWithFormat:@"%ld.%@", index, videoModel.title];
        [self.titleLabel setText:videoTitle lineSpacing:4];
        self.speakerLabel.text = videoModel.speaker;
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10.);
        make.top.equalTo(self).offset(10.);
        make.right.lessThanOrEqualTo(self).offset(-10);
    }];
    
    [self.speakerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10.);
        make.bottom.equalTo(self).offset(-10);
        make.left.greaterThanOrEqualTo(self).offset(10.);
    }];
}

#pragma mark- settingAndGetting
- (UILabel*) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [self addLabel:[UIColor commonTextColor] textSize:13];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel*) speakerLabel{
    if (!_speakerLabel) {
        _speakerLabel = [self addLabel:[UIColor commonGrayTextColor] textSize:12];
    }
    return _speakerLabel;
}

@end

@interface MedicalVideoDetailDirectoryTableViewCell ()

@property (nonatomic, strong) UILabel* titleLabel;

@property (nonatomic, strong) UIScrollView* scrollview;
@property (nonatomic, strong) NSMutableArray<MedicalVideoDetailDirectoryCell*>* directoryCells;
 
@end

@implementation MedicalVideoDetailDirectoryTableViewCell

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(22.);
    }];
    
    [self.scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15.);
        make.bottom.equalTo(self.contentView).offset(16.);
        make.height.mas_equalTo(@75);
    }];
    
}

#pragma mark - settingAndGetting
- (UILabel*) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [self.contentView addLabel:[UIColor commonTextColor] textSize:16];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
    }
    return _titleLabel;
}

- (UIScrollView*) scrollview{
    if (!_scrollview) {
        _scrollview = (UIScrollView*)[self.contentView addView:[UIScrollView class]];
    }
    return _scrollview;
}

- (NSMutableArray<MedicalVideoDetailDirectoryCell*>*) directoryCells{
    if (!_directoryCells) {
        _directoryCells = [NSMutableArray<MedicalVideoDetailDirectoryCell*> array];
    }
    return _directoryCells;
}

- (void) setEntryModel:(EntryModel *)model{
    if (!model || ![model isKindOfClass:[MedicalVideoGroupDetailEntryModel class]]) {
        return;
    }
    
    MedicalVideoGroupDetailEntryModel* groupDetal = (MedicalVideoGroupDetailEntryModel*) model;
    self.titleLabel.text = [NSString stringWithFormat:@"视频目录（共%ld讲）", groupDetal.medicalVideoItems.count];
    
    [self.scrollview removeAllSubviews];
    [self.directoryCells removeAllObjects];
    
    [groupDetal.medicalVideoItems enumerateObjectsUsingBlock:^(MedicalVideoEntryModel * _Nonnull videoModel, NSUInteger idx, BOOL * _Nonnull stop) {
        MedicalVideoDetailDirectoryCell* directoryCell = [[MedicalVideoDetailDirectoryCell alloc] initWithVideoItem:videoModel index:idx + 1];
        [self.scrollview addSubview:directoryCell];
        directoryCell.frame = CGRectMake((168 * idx), 0, 160, 75);
        [self.directoryCells addObject:directoryCell];
    }];
    
    CGFloat lastCellRight = self.directoryCells.lastObject.right;
    [self.scrollview setContentSize:CGSizeMake(lastCellRight, 75)];
}

@end
