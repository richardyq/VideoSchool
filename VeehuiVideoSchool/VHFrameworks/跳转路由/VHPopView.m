//
//  VHPopView.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/24.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHPopView.h"

@implementation VHPopView

+ (void) showWith:(id) param action:(PopViewAction) action{
    VHPopView* popView = [[[self class] alloc]initWithParam:param action:action];
    [[NSObject rootWindow] addSubview:popView];
    
    [popView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo([NSObject rootWindow]);
    }];
}

- (id) initWithParam:(id) param action:(PopViewAction) action{
    self = [super init];
    if (self) {
        [self setupParam:param];
        _action = action;
        self.backgroundColor = [UIColor commonTransColor];
    }
    return self;
}

- (void) setupParam:(id) param{
    
}

- (void) close:(id) ret{
    if (self.action) {
        self.action(ret);
    }
    [self removeFromSuperview];
}

@end
