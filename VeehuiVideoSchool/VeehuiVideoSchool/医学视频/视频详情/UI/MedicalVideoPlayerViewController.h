//
//  MedicalVideoPlayerViewController.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHBaseListViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MedicalVideoPlayerViewController : VHBaseListViewController

@property (nonatomic, strong) VideoPlayerModel* playerModel;

@property (nonatomic, strong) VideoPlayerView* playerView;

@end

NS_ASSUME_NONNULL_END
