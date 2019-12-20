//
//  Router.m
//  HelModules+URL
//
//  Created by Macmafia on 2019/11/12.
//  Copyright © 2019 Macmafia. All rights reserved.
//

#import "Router.h"

static Router *mInstance = nil;

@implementation Router

+ (instancetype)sharedInstance{
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mInstance = [super allocWithZone:zone];
    });
    return mInstance;
}

// MARK: Getter&Setter

+ (NSMutableDictionary*)routes {
    @synchronized (self) {
        static NSMutableDictionary *_routes = nil;
        if (!_routes) {
            _routes = [NSMutableDictionary dictionary];
        }
        return _routes;
    }
}

// MARK: 绑定URL-Block
+(void)bindURL:(NSString *)urlStr toHandler:(RouteHandler)handler{
    [self.routes setValue:handler forKey:urlStr];
}

// MARK: 根据URL调用服务
+ (nullable id)handleURL:(nonnull NSString *)urlStr
complexParams:(nullable NSDictionary*)complexParams
   completion:(nullable RouteCompletion)completion {
    
    // 重新获取参数之前的URL.host和URL.path，如“//detail/push”
    NSString *URLKey = [self getKeyFromURL:urlStr];
    
    // 查找url对应的block
    RouteHandler handler = [self handlerForURL:URLKey];
    
    //拼接参数
    NSDictionary *paramsInURL = [self.class parametersInURL:urlStr];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:complexParams];
    [params addEntriesFromDictionary:paramsInURL];
    
    id obj = handler(params);
    
    return obj;
}

// MARK: 获取URL中?号之后的参数
+ (nullable NSDictionary*)parametersInURL:(nonnull NSString*)urlStr {
    NSURL *URL = [NSURL URLWithString:urlStr];
    NSMutableDictionary *params = nil;
    NSString *query = URL.query;
    if(query.length > 0) {
        params = [NSMutableDictionary dictionary];
        NSArray *list = [query componentsSeparatedByString:@"&"];
        for (NSString *param in list) {
            NSArray *elts = [param componentsSeparatedByString:@"="];
            if([elts count] < 2) continue;
            NSString *decodedStr = [[elts lastObject] stringByRemovingPercentEncoding];
            [params setObject:decodedStr forKey:[elts firstObject]];
        }
    }
    return params;
}

// MARK:根据URL获取对应的Block
+ (nullable RouteHandler)handlerForURL:(nonnull NSString *)urlStr {
    return [self.routes valueForKey:urlStr];
}

// MARK:URL是否有与之对应的Block
+ (BOOL)canHandleUrl:(NSString*)urlStr{
    return [self getKeyFromURL:urlStr].length != 0;
}

//  重新获取参数之前的URL.host和URL.path，如“//detail/push”
+ (NSString*)getKeyFromURL:(NSString*)urlStr{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSString *host = url.host;
    NSString *path = url.path;
    NSString *URLKey = [NSString stringWithFormat:@"//%@%@",host,path];
    
    return URLKey;
}
@end
