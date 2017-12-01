//
//  Keyboard.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/24.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "SKKeyboard.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@implementation SKKeyboard
+(void)skMangerKeyboard{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    
    keyboardManager.enable = YES; // 控制整个功能是否启用
    
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    
    keyboardManager.enableAutoToolbar = NO; // 控制是否显示键盘上的工具条
    
    keyboardManager.shouldShowToolbarPlaceholder = YES; // 是否显示占位文字
    
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
    
    //设置导航栏的颜色
    [[UINavigationBar appearance] setBarTintColor:skBaseColor];
    //取消导航栏半透明状态
//    [[UINavigationBar appearance] setTranslucent:NO];
    
    //设置导航栏标题的属性
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:17]}];
    //设置返回按钮的颜色
    [[UINavigationBar appearance] setTintColor:[UIColor clearColor]];
    
    //自定义返回按钮
    UIImage *backButtonImage = [[UIImage imageNamed:@"back"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 0, 10, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

}
@end
