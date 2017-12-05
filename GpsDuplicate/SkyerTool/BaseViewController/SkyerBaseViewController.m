//
//  SkyerBaseViewController.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/24.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "SkyerBaseViewController.h"

@interface SkyerBaseViewController ()

@end

@implementation SkyerBaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    NSLog(@"%@加载",self);
    UIButton *btnBack=[self skSetNagLeftImage:@"btn_arrow_default"];
    kWeakSelf(self)
    [[btnBack rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself.navigationController popViewControllerAnimated:YES];
    }];
}
-(void)dealloc{
    NSLog(@"%@销毁",self);
}

/**
 修改导航栏右边的文字

 @param title 要修改成的文字
 */
-(UIButton *)skSetNagRightTitle:(NSString *)title withColor:(UIColor *)color{
    UIButton *btnRight = [[UIButton alloc] initWithFrame:CGRectMake(0,0,30,30)];
    [btnRight setTitleColor:color forState:(UIControlStateNormal)];
    [btnRight setTitle:title forState:UIControlStateNormal];
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
    self.navigationItem.rightBarButtonItem = btnBack;
    return btnRight;
}

/**
 修改导航栏右边的文字

 @param image 图片的名称
 */
-(UIButton *)skSetNagRightImage:(NSString *)image{
    UIButton*btnRight = [[UIButton alloc] initWithFrame:CGRectMake(0,0,30,30)];
    [btnRight setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
    self.navigationItem.rightBarButtonItem = btnBack;//为导航栏右侧添加系统自定义按钮
    return btnRight;
}

/**
 修改导航栏右边的文字

 @param title 要修改成的文字
 */
-(UIButton *)skSetNagLeftTitle:(NSString *)title withColor:(UIColor *)color{
    UIButton*btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(0,0,30,30)];
    [btnLeft setTitleColor:color forState:(UIControlStateNormal)];
    [btnLeft setTitle:title forState:UIControlStateNormal];
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    self.navigationItem.leftBarButtonItem = btnBack;
    return btnLeft;
}

/**
 修改导航栏右边的文字

 @param image 图片的名称
 */
-(UIButton *)skSetNagLeftImage:(NSString *)image{
    UIButton *btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(0,0,30,30)];
    [btnLeft setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    self.navigationItem.leftBarButtonItem = btnBack;//为导航栏右侧添加系统自定义按钮
    return btnLeft;
}

@end
