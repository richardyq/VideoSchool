//
//  VHHTTPFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/18.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "VHHTTPFunction.h"

@interface FunctionRet : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString* message;
@property (nonatomic, strong) id result;

- (id) initWithCode:(NSInteger) code message:(NSString*) message;
@end

@implementation FunctionRet

- (id) initWithCode:(NSInteger) code message:(NSString*) message{
    self = [super init];
    if (self) {
        _code = code;
        _message = message;
    }
    return self;
}
@end

@interface VHHTTPFunction ()

@property (nonatomic,strong) VHHTTPRequest *mcRequest;
@property (nonatomic, assign) EHTTPRequestMethod requestMethod;

@end

@implementation VHHTTPFunction

@synthesize id = _id;

- (id) init{
    self = [super init];
    if (self) {
        
        [self setErrorFilter:^BOOL(NSInteger code) {
            return (code != 1);
        }];
    }
    return self;
}

- (void) requestResult:(VHRequestResultHandler) resultHandler
              complete:(VHRequestCompleteHandler) completeHandler{
    NSString* requestUrl = [self requestUrl];
    
//    requestUrl = [self generateUrl:requestUrl];
//    requestUrl = [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"!$&'()*+,-./:;=?@_~%#[]"]];
//    requestUrl = [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSDictionary* requestDictionary = [self reqeustDictionary];
    
    BOOL isReachable = [[AFNetworkReachabilityManager sharedManager] isReachable];
    if (!isReachable) {
        //网络不通
        if (completeHandler) {
            completeHandler(-2, @"对不起，网络不给力，请稍后再试。");
        }
        return;
    }
    
    WS(weakSelf)
    switch (self.requestMethod) {
        case Request_GET:{
            SAFE_WEAKSELF(weakSelf)
            [weakSelf.mcRequest GET:requestUrl parameters:requestDictionary success:^(VHHTTPRequest * _Nullable request, id response) {
                if (!weakSelf) {
                    return ;
                }
                FunctionRet* ret = [weakSelf httpRequestHandler:response resultHandler:resultHandler];
                if (completeHandler) {
                    completeHandler(ret.code, ret.message);
                }
            } failure:^(VHHTTPRequest *request, NSError *err) {
                if (completeHandler) {
                    completeHandler(-1, @"获取数据失败。");
                }
            }];
            break;
        }
        case Request_POST:{
            SAFE_WEAKSELF(weakSelf)
            [weakSelf.mcRequest POST:requestUrl parameters:requestDictionary success:^(VHHTTPRequest * _Nullable request, id response) {
                if (!weakSelf) {
                    return ;
                }
                FunctionRet* ret = [weakSelf httpRequestHandler:response resultHandler:resultHandler];
                if (completeHandler) {
                    completeHandler(ret.code, ret.message);
                }
            } failure:^(VHHTTPRequest *request, NSError *err) {
                if (completeHandler) {
                    completeHandler(-1, @"获取数据失败。");
                }
            }];
            break;
        }
        case Request_PUT:{
            SAFE_WEAKSELF(weakSelf)
            [(weakSelf).mcRequest PUT:requestUrl parameters:requestDictionary success:^(VHHTTPRequest * _Nullable request, id response) {
                if (!weakSelf) {
                    return ;
                }
                FunctionRet* ret = [weakSelf httpRequestHandler:response resultHandler:resultHandler];
                if (completeHandler) {
                    completeHandler(ret.code, ret.message);
                }
            } failure:^(VHHTTPRequest *request, NSError *err) {
                if (completeHandler) {
                    completeHandler(-1, @"获取数据失败。");
                }
            }];
            break;
        }
        default:
            break;
    }
}




#pragma mark - settingAndGetting
- (NSString*) requestUrl{
    return nil;
}

- (NSDictionary*) reqeustDictionary{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    //NSMutableDictionary *dict= [RequestHelper commonPostParam];
    return dict;
}

- (EHTTPRequestMethod) requestMethod{
    return Request_GET;
}

- (VHHTTPRequest*)mcRequest{
    if (!_mcRequest) {
        _mcRequest=[VHHTTPRequest shareInstance];
        
        //设置HTTPHeader
        [_mcRequest setHTTPHeader:@"IOS" headerField:@"os"];
        NSString* appVersion=[NSObject appVersion];
        if (appVersion && appVersion.length > 0) {
            [_mcRequest setHTTPHeader:appVersion headerField:@"loginVersion"];
        }
    }
    return _mcRequest;
}

- (NSString*) id{
    if(!_id){
        NSString* className = NSStringFromClass(self.class);
        NSDictionary* param = [self reqeustDictionary];
        NSMutableDictionary* dict = [NSMutableDictionary dictionary];
        [dict setValue:className forKey:@"name"];
        if(param && param.count > 0){
            [dict setValue:param forKey:@"param"];
        }
        _id = [dict mj_JSONString];
        
    }
    return _id;
    
}


#pragma mark - http request handler
- (FunctionRet*) httpRequestHandler:(id) response resultHandler:(VHRequestResultHandler) resultHandler{
    NSInteger code = -1;
    NSString* message = @"获取数据失败。";
    FunctionRet* ret = [[FunctionRet alloc] initWithCode:code message:message];
    
    
    if (response && [response isKindOfClass:[NSDictionary class]]) {
        NSDictionary* respDict = (NSDictionary*) response;
        NSNumber* codeNum = [respDict valueForKey:@"code"];
        NSString* msg = [respDict valueForKey:@"message"];
        if (msg && msg.length > 0) {
            message = msg;
        }
        if (codeNum && [codeNum isKindOfClass:[NSString class]]) {
            code = codeNum.integerValue;
        }
        if (self.errorFilter(code)) {
            ret.code = code;
            ret.message = message;
            return ret;
        }
        //请求成功
        ret.code = 0;
        id result = nil;
        id resp = [respDict valueForKey:@"result"];
        
        result = [self paraserResponse:resp];
        ret.message = message;
        if (result && resultHandler) {
            
            resultHandler(result);
        }
        
    }
    
    return ret;
}

- (id) paraserResponse:(id) response{
    
    return response;
}
@end
