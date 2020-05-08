//
//  MeetingPreviewListViewController.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/7.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingPreviewListViewController.h"
#import "MeetingBussiness.h"
#import "MeetingPreviewSectionModel.h"
#import "MeetingPreviewWholeTableViewController.h"
#import "MeetingPreviewSectionTableViewController.h"

@interface MeetingPreviewListViewController ()
<UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (nonatomic, strong) SegmentView* segmentView;
@property (nonatomic, strong) NSArray<MeetingPreviewSectionModel*>* perviewSections;
@property (nonatomic, strong) UIPageViewController* pageController;

@property (nonatomic, strong) NSMutableArray<UIViewController*>* controllers;
@end

@implementation MeetingPreviewListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"会议预告";
    [self startLoadMeetingPreviews];
}

- (void) updateViewConstraints{
    [super updateViewConstraints];
    
    [self.segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.height.mas_equalTo(@45);
        make.centerX.equalTo(self.view);
        if ([UIDevice currentDevice].isPad) {
            make.width.equalTo(self.view).multipliedBy(0.7);
        }
        else{
            make.width.equalTo(self.view);
        }
    }];
    
    [self.pageController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.top.equalTo(self.segmentView.mas_bottom);
        make.centerX.equalTo(self.view);
        if ([UIDevice currentDevice].isPad) {
            make.width.equalTo(self.view).multipliedBy(0.7);
        }
        else{
            make.width.equalTo(self.view);
        }
    }];
}

#pragma mark - settingAndGetting
- (SegmentView*) segmentView{
    if (!_segmentView) {
        _segmentView = [[SegmentView alloc] initWithNormalFont:[UIFont systemFontOfSize:13] normalColor:[UIColor commonGrayTextColor] highFont:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium] highColor:[UIColor mainThemeColor]];
        [self.view addSubview:_segmentView];
        _segmentView.minSegmentCellWidth = (kScreenWidth / 4.5);
        if ([UIDevice currentDevice].isPad) {
            _segmentView.minSegmentCellWidth = (kScreenWidth / 4.5 * 0.7);
        }
        _segmentView.indicateWidth = 27.5;
        WS(weakSelf)
        [_segmentView onSelectedIndexChanged:^(NSInteger index) {
            SAFE_WEAKSELF(weakSelf)
            [weakSelf segmentViewSelectedIndexChanged:index];
        }];
    }
    return _segmentView;
}

- (UIPageViewController*) pageController{
    if (!_pageController) {
        NSDictionary *options =[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin]
                                  forKey: UIPageViewControllerOptionSpineLocationKey];
        _pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                   navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                          options:options];
        _pageController.dataSource = self;
        _pageController.delegate = self;
        [self addChildViewController:_pageController];
        [self.view addSubview:_pageController.view];
    }
    return _pageController;
}

- (NSMutableArray<UIViewController*>*) controllers{
    if (!_controllers) {
        _controllers = [NSMutableArray<UIViewController*> array];
    }
    return _controllers;
}

#pragma mark - segment event
- (void) segmentViewSelectedIndexChanged:(NSInteger) index{
    NSInteger pageIndex = [self.controllers indexOfObject:self.pageController.viewControllers.firstObject];
    if (pageIndex == NSNotFound) {
        [self.pageController setViewControllers:@[self.controllers[index]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        return;
    }
    
    if (pageIndex == index) {
        return;
    }
    
    if (pageIndex > index) {
        [self.pageController setViewControllers:@[self.controllers[index]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    }
    else{
        [self.pageController setViewControllers:@[self.controllers[index]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
}

#pragma mark - 获取网络数据
- (void) startLoadMeetingPreviews{
    [MessageHubUtil showWait];
    WS(weakSelf)
    [MeetingBussiness startLoadPreviewMeetingList:^(id result) {
        SAFE_WEAKSELF(weakSelf)
        if ([result isKindOfClass:[NSArray class]]) {
            [weakSelf meetingPreviewSectionsLoaded:result];
        }
    } complete:^(NSInteger code, NSString *message) {
        [MessageHubUtil hideMessage];
        SAFE_WEAKSELF(weakSelf)
        if (code != 0) {
            [MessageHubUtil showErrorMessage:message];
        }
    }];
}

- (void) meetingPreviewSectionsLoaded:(NSArray<MeetingPreviewSectionModel*>*) sections{
    self.perviewSections = sections;
    NSMutableArray<NSString*>* segmentNames = [NSMutableArray<NSString*> array];
    [segmentNames addObjectsFromArray: [self.perviewSections valueForKey:@"name"]];
    [segmentNames insertObject:@"全部" atIndex:0];
    
    [self.segmentView setSegmentTitles:segmentNames];
    
    [self createSectionTableViewControllers];
}

- (void) createSectionTableViewControllers{
    [self.controllers removeAllObjects];
    [self.controllers addObject:[[MeetingPreviewWholeTableViewController alloc] initWithPreviewSections:self.perviewSections]];
    [self.perviewSections enumerateObjectsUsingBlock:^(MeetingPreviewSectionModel * _Nonnull section, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.controllers addObject:[[MeetingPreviewSectionTableViewController alloc] initWithPreviewSection:section]];
    }];
    
    [self.pageController setViewControllers:@[self.controllers.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

#pragma mark - page view controller data source
- (UIViewController*) pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index = [self.controllers indexOfObject:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    if (index >= self.controllers.count - 1) {
        return nil;
    }
    
    return self.controllers[index + 1];
}

- (UIViewController*) pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index = [self.controllers indexOfObject:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    if (index <= 0) {
        return nil;
    }
    
    return self.controllers[index - 1];
}

#pragma mark - page viwe delegate
- (void) pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    NSInteger index = [self.controllers indexOfObject:pageViewController.viewControllers.firstObject];
    if (index == NSNotFound) {
        return ;
    }
    
    [self.segmentView setSelectedIndex:index];
}

@end
