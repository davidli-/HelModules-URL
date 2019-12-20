//
//  HomeViewController.m
//  HelModules+URL
//
//  Created by Macmafia on 2019/11/12.
//  Copyright © 2019 Macmafia. All rights reserved.
//

#import "HomeViewController.h"
#import "Router.h"

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)onPushAction:(id)sender {
    // 声明回调 从头像页面返回当前页面时更新标题
    DetailCallback block = ^(){
        self.title = @"Info Checked";
    };
    NSDictionary *params = @{@"img":[UIImage imageNamed:@"1"],@"block":block};
    NSString *url = [kRouteDetaiPushWithIcon stringByAppendingString:@"?num=1&orderid=10001"];
    // 调用服务
    UIViewController *vc = [Router handleURL:url complexParams:params completion:^(id result) {
        self.title = @"Updated";
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)dealloc{
    NSLog(@"+++HomeViewController dealloced~~");
}
@end
