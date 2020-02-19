//
//  VHCountDownUtil.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHCountDownUtil.h"

NSString* const kCountDownNotifitionName = @"CountDownNotifititionName";

@interface  VHCountDownListener : NSObject

@property (nonatomic, weak) id sender;

- (id) initWithListener:(id) sender;
@end

@implementation  VHCountDownListener

- (id) initWithListener:(id) sender{
    self = [super init];
    if (self) {
        _sender = sender;
    }
    return self;
}

@end

@interface VHCountDownUtil ()

@property (nonatomic, strong) NSTimer* timer;
@property (nonatomic, strong) NSMutableArray<VHCountDownListener*>* items;

@end

@implementation VHCountDownUtil

+ (instancetype)shareInstance{
    static id instatnce = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instatnce=[[[self class] alloc] init];
    });
    return instatnce;
}

- (void) startCountDown:(id) sender{
    if (!sender) {
        return;
    }
    
    if ([self listenHasBeenExisted:sender]) {
        return;
    }
    
    //开始倒计时
    if (self.items.count == 0) {
        
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    
    [self.items addObject:[[VHCountDownListener alloc] initWithListener:sender]];
}

- (void) stopCountDown:(id) sender{
    if (!sender) {
        return;
    }
    
    NSMutableArray<VHCountDownListener*>* emptyListeners = [NSMutableArray<VHCountDownListener*> array];
    [self.items enumerateObjectsUsingBlock:^(VHCountDownListener * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        id obj = item.sender;
        if (!obj) {
            [emptyListeners addObject:item];
        }
    }];
    
    [emptyListeners enumerateObjectsUsingBlock:^(VHCountDownListener * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.items removeObject:obj];
    }];
    
    __block VHCountDownListener* listener = nil;
    [self.items enumerateObjectsUsingBlock:^(VHCountDownListener * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        id obj = item.sender;
        if (!obj) {
            [self.items removeObject:item];
        }
        else if (obj == sender || [sender isEqual:obj]) {
            listener = item;
            *stop = YES;
        }
    }];
    
    if (listener) {
        [self.items removeObject:listener];
    }
    
    
    if (self.items.count == 0) {
        //停止
        [self.timer invalidate];
        _timer = nil;
    }
}

#pragma mark - settingAndGetting
- (NSMutableArray<VHCountDownListener*>*) items{
    if (!_items) {
        _items = [NSMutableArray<VHCountDownListener*> array];
    }
    return _items;
}

- (NSTimer*) timer{
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (BOOL) listenHasBeenExisted:(id) sender{
    if (!sender) {
        return NO;
    }
    
    __block BOOL existed = NO;
    [self.items enumerateObjectsUsingBlock:^(VHCountDownListener*  _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        existed = (item.sender == sender);
        *stop = existed;
    }];
    
    return existed;
}

- (void) timerRun{
    [[NSNotificationCenter defaultCenter] postNotificationName:kCountDownNotifitionName object:nil];
}

@end
