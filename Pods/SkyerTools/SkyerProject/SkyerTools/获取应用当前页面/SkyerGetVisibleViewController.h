//
//  GetVisibleViewController.h
//  odierBike2015
//
//  Created by odier on 2016/11/15.
//  Copyright © 2016年 odier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SkyerGetVisibleViewController : NSObject

+ (instancetype)sharedInstance;

/**
 获取当前页面

 @return 返回的是app显示的页面
 */
- (UIViewController *)skyerVisibleViewController;//获取当前显示的页面

/**
 返回当前页的顶层页面

 @param rootViewController 需要判断的界面
 @return 返回系统显示的页面
 */
- (UIViewController*)skyerTopViewControllerWithRootViewController:(UIViewController*)rootViewController;
@end
