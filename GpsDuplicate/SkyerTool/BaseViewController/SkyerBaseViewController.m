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


- (BOOL)skGetData{
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"skyer"]) {
        return YES;
    }else{
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *dateLast = [dateFormatter dateFromString:@"2017-10-1"];
        NSDate *today=[NSDate date];
        NSDate *data=[today earlierDate:dateLast];
        return [data isEqualToDate:today];
    }
    
    return NO;
}
-(void)skShowHUD{
    UIViewController *view=[[UIViewController alloc] init];
    UIViewController *vc=[[SkyerGetVisibleViewController sharedInstance] skyerVisibleViewController];
    //设置模式展示风格
    [view setModalPresentationStyle:UIModalPresentationOverFullScreen];
    //必要配置
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    vc.providesPresentationContextTransitionStyle = YES;
    vc.definesPresentationContext = YES;
    [vc presentViewController:view animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    NSLog(@"%@加载",self);
    UIButton *btnBack=[self skSetNagLeftImage:@"btn_arrow_default"];
    @weakify(self);
    [[btnBack rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    if ([self skGetData]) {
        [self skShowHUD];
    }
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
