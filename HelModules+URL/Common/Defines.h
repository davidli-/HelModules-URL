//
//  UrlsHeader.h
//  HelModules+URL
//
//  Created by Macmafia on 2019/11/12.
//  Copyright © 2019 Macmafia. All rights reserved.
//

#ifndef UrlsHeader_h
#define UrlsHeader_h

#import <UIKit/UIKit.h>

typedef void(^DetailCallback)(void);

// 简单的创建详情实例
static NSString *const kRouteDetaiCreateIns = @"//detail/create";
// 创建详情实例并设置图片
static NSString *const kRouteDetaiPushWithIcon = @"//detail/push";
// 跳转主页
static NSString *const kRouteHome = @"//home";
#endif /* UrlsHeader_h */
