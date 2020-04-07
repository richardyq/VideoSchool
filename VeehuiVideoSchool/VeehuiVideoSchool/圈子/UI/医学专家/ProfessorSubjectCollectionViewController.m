//
//  ProfessorSubjectCollectionViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/4/3.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "ProfessorSubjectCollectionViewController.h"
#import "CommonBaseBussiness.h"
#import "MedicalVideoClassifyEntryModel.h"
#import "ProfessorSubjectCollectionViewCell.h"

@interface ProfessorSubjectCollectionViewController ()

@property (nonatomic, strong) NSArray<MedicalVideoClassifyEntryModel*>* seniorSubjects;

@property (nonatomic, strong) NSMutableArray<NSMutableArray<MedicalVideoClassifyEntryModel*>*>* sections;
@end

@implementation ProfessorSubjectCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[ProfessorSubjectCollectionViewCell class] forCellWithReuseIdentifier:[ProfessorSubjectCollectionViewCell cellReuseIdentifier]];
    _sections = [NSMutableArray<NSArray<MedicalVideoClassifyEntryModel*>*> array];
    // Do any additional setup after loading the view.
    [self startLoadSeniorSubjects];
}

#pragma mark - 获取学科列表
- (void) startLoadSeniorSubjects{
    WS(weakSelf)
    [CommonBaseBussiness startSeniorSubjects:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if ([result isKindOfClass:[NSArray class]]) {
            [weakSelf seniorSubjectLoaded:result];
        }
    } complete:^(NSInteger code, NSString *message) {
        
    }];
}

- (void) seniorSubjectLoaded:(NSArray<MedicalVideoClassifyEntryModel*>*) subjects{
    self.seniorSubjects = subjects;
    [subjects enumerateObjectsUsingBlock:^(MedicalVideoClassifyEntryModel * _Nonnull subject, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray<MedicalVideoClassifyEntryModel*>* section = nil;
        NSInteger index = idx / 8;
        if(self.sections.count > index){
            section = self.sections[idx / 8];
        }
        if ((idx % 8) == 0) {
            section = [NSMutableArray<MedicalVideoClassifyEntryModel*> array];
            [self.sections addObject:section];
            for (NSInteger index = 0; index < 8; ++index) {
                [section addObject:[MedicalVideoClassifyEntryModel new]];
            }
        }
        
        [section replaceObjectAtIndex:(idx % 8) withObject:subject];
    }];
    
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.sections.count;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of items
    
    return self.sections[section].count;
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProfessorSubjectCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ProfessorSubjectCollectionViewCell cellReuseIdentifier] forIndexPath:indexPath];
    // Configure the cell
    NSArray<MedicalVideoClassifyEntryModel*>* section = self.sections[indexPath.section];
    NSInteger row = indexPath.row / 2;
    NSInteger col = indexPath.row % 2;
    
    NSInteger index = col * 4 + row;
    
    [cell setEntryModel:section[index]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
