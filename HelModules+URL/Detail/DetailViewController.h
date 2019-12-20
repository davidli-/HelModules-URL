//
//  DetailViewController.h
//  HelModules+URL
//
//  Created by Macmafia on 2019/11/12.
//  Copyright © 2019 Macmafia. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController
@property (nonatomic, strong) UIImage *img;
@property (nonatomic, copy) DetailCallback callBack; // 回调block
@end

NS_ASSUME_NONNULL_END
