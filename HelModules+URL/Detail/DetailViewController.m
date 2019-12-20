//
//  DetailViewController.m
//  HelModules+URL
//
//  Created by Macmafia on 2019/11/12.
//  Copyright © 2019 Macmafia. All rights reserved.
//

#import "DetailViewController.h"
#import "Router.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *mIconView;
@end

@implementation DetailViewController

+ (void)load{
    // 以block的形式封装对外服务
    RouteHandler handler = ^ id (NSDictionary *parameters){
        UIImage *img = parameters[@"img"];
        DetailCallback callback = parameters[@"block"];
        DetailViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                    instantiateViewControllerWithIdentifier:@"DetailViewController"];
        vc.img = img;
        vc.callBack = callback;
        return vc;
    };
    // 将URL与Block的关系注册到路由表中
    [Router bindURL:kRouteDetaiPushWithIcon toHandler:handler];
    
    // 可注册多个Block，以便对外提供更多服务
    RouteHandler handler2 = ^ (NSDictionary *params){
        return [[DetailViewController alloc] init];
    };
    [Router bindURL:kRouteDetaiCreateIns toHandler:handler2];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _mIconView.image = _img;
}

- (IBAction)onDismissAction:(id)sender {
    self.callBack(); //回调给服务调用方
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc{
    NSLog(@"+++DetailViewController dealloced~~");
}
@end
