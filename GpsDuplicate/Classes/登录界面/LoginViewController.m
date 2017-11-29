//
//  ViewController.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/24.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "LoginViewController.h"
#import "BindingViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initUI];
    
    [self RACAction];
    
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"key"]);
}

/**
 初始化UI
 */
-(void)initUI{
    [_viewName skSetBoardRadius:3 Width:1 andBorderColor:[UIColor whiteColor]];
    [_viewPassword skSetBoardRadius:3 Width:1 andBorderColor:[UIColor whiteColor]];
    [_btnLogin skSetBoardRadius:3 Width:1 andBorderColor:[UIColor clearColor]];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary]; // 创建属性字典
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:14]; // 设置font
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor]; // 设置颜色
    NSAttributedString *attName = [[NSAttributedString alloc] initWithString:@"请输入账号" attributes:attrs]; // 初始化富文本占位字符串
    _textName.attributedPlaceholder = attName;
    NSAttributedString *attPassword = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:attrs]; // 初始化富文本占位字符串
    _textPassword.attributedPlaceholder = attPassword;
    
}

/**
 rac监控的点击事件
 */
-(void)RACAction{
    //用户登录
    [[_btnLogin rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        
        
        UINavigationController *bdv=[self.storyboard instantiateViewControllerWithIdentifier:@"MainNavigation"];
        [self presentViewController:bdv animated:YES completion:nil];
    }];
}

#pragma mark -用户登录
- (void)userLogin{
    
    [[SKNetworking sharedSKNetworking] SKPOST:skURLString parameters:nil showHUD:YES showErrMsg:YES success:^(id  _Nullable responseObject) {
        
    } failure:^(NSError * _Nullable error) {
        
    }];
    
}

@end
