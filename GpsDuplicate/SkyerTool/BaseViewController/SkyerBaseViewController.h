//
//  SkyerBaseViewController.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/24.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SkyerBaseViewController : UIViewController
#pragma mark 导航栏右边的按钮
/**
 修改导航栏右边的按钮文字和颜色

 @param title 标题文字
 @param color 字体颜色
 */
-(UIButton *)skSetNagRightTitle:(NSString *)title withColor:(UIColor *)color;
/**
 修改导航栏右边的文字
 
 @param image 图片的名称
 */
-(UIButton *)skSetNagRightImage:(NSString *)image;
#pragma mark -导航栏左边的按钮
/**
 修改导航栏左边的按钮文字和颜色
 
 @param title 标题文字
 @param color 字体颜色
 */
-(UIButton *)skSetNagLeftTitle:(NSString *)title withColor:(UIColor *)color;
/**
 修改导航栏左边的文字
 
 @param image 图片的名称
 */
-(UIButton *)skSetNagLeftImage:(NSString *)image;
@end
