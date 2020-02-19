//
//  VHHTTPFunctionManager.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHHTTPFunctionManager.h"

@interface FunctionObservice : NSObject

@property (nonatomic, copy) VHRequestResultHandler result;
@property (nonatomic, copy) VHRequestCompleteHandler complete;

- (id) initWithResult:(VHRequestResultHandler) result
             complete:(VHRequestCompleteHandler) complete;

@end

@implementation FunctionObservice


- (id) initWithResult:(VHRequestResultHandler) result
             complete:(VHRequestCompleteHandler) complete{
    self = [super init];
    if (self) {
        _result = result;
        _complete = complete;
    }
    return self;
}

@end

@interface VHHTTPFunctionManager ()

@property (nonatomic, strong) NSMutableDictionary* functions;
@property (nonatomic, strong) NSMutableDictionary* observices;

@end

@implementation VHHTTPFunctionManager

+ (instancetype)shareInstance{
    static VHHTTPFunctionManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager=[[VHHTTPFunctionManager alloc] init];
    });
    return _manager;
}

- (void) createFunction:(VHHTTPFunction*) function
                 result:(VHRequestResultHandler) result
               complete:(VHRequestCompleteHandler) complete{
    if (!function) {
        return;
    }
    
    FunctionObservice* observice = [[FunctionObservice alloc] initWithResult:result complete:complete];
    VHHTTPFunction* f = [self.functions valueForKey:function.id];
    if (!f) {
        [self.functions setValue:function forKey:function.id];
    }
    NSMutableArray<FunctionObservice*>* observices = [self.observices valueForKey:function.id];
    if (!observices || ![observices isKindOfClass:[NSMutableArray<FunctionObservice*> class]]) {
        observices = [NSMutableArray<FunctionObservice*> array];
    }
    [observices addObject:observice];
    [self.observices setValue:observices forKey:function.id];
    
    WS(weakSelf)
    [function requestResult:^(id  _Nonnull result) {
        SAFE_WEAKSELF(weakSelf)
        NSMutableArray<FunctionObservice*>* observices = [weakSelf.observices valueForKey:function.id];
        [observices enumerateObjectsUsingBlock:^(FunctionObservice * _Nonnull observice, NSUInteger idx, BOOL * _Nonnull stop) {
            if (observice.result) {
                observice.result(result);
            }
        }];
    } complete:^(NSInteger code, NSString * _Nonnull message) {
        if (!weakSelf) {
            return ;
        }
        
        
        NSMutableArray<FunctionObservice*>* observices = [weakSelf.observices valueForKey:function.id];
        [observices enumerateObjectsUsingBlock:^(FunctionObservice * _Nonnull observice, NSUInteger idx, BOOL * _Nonnull stop) {
            if (observice.complete) {
                observice.complete(code, message);
            }
        }];
        
        [weakSelf functionCompleted:function];
    }];
}

- (void) functionCompleted:(VHHTTPFunction*) function{
    [self.functions removeObjectForKey:function.id];
    [self.observices removeObjectForKey:function.id];
}

#pragma mark - settingAndGetting
- (NSMutableDictionary*) functions{
    if (!_functions) {
        _functions = [NSMutableDictionary dictionary];
        
    }
    return _functions;
}
- (NSMutableDictionary*) observices{
    if (!_observices) {
        _observices = [NSMutableDictionary dictionary];
        
    }
    return _observices;
}

@end
