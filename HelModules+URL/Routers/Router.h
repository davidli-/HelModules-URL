//
//  Router.h
//  HelModules+URL
//
//  Created by Macmafia on 2019/11/12.
//  Copyright © 2019 Macmafia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef _Nullable id (^RouteHandler)( NSDictionary * _Nullable parameters);
typedef void (^RouteCompletion)(_Nullable id result);

@interface Router : NSObject


/// 绑定URL与Block
/// @param urlStr 对外暴露的代表某组件服务的URL
/// @param handler 服务接口，以block形式暴露给外部调用者
+ (void)bindURL:(nonnull NSString *)urlStr 
      toHandler:(nonnull RouteHandler)handler;


/// 调用服务接口
/// @param urlStr 代表目标组件服务接口的URL
/// @param complexParams URL中不方便传递的参数
/// @param completion 回调
+ (nullable id)handleURL:(nonnull NSString *)urlStr
complexParams:(nullable NSDictionary*)complexParams
              completion:(nullable RouteCompletion)completion;

/// 该URL是否有与之对应的Block
/// @param urlStr URL字符串
+ (BOOL)canHandleUrl:(NSString*)urlStr;

@end

NS_ASSUME_NONNULL_END
