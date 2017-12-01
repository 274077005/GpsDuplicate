//
//  ViewController.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/24.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "LoginViewController.h"
#import "UserLogin.h"
#import "DriverOrderViewController.h"
#import <CommonCrypto/CommonDigest.h>

//缓存几个数据,账号\密码\和是否记住密码
#define skPassWord @"skPassWord"
#define skUserName @"skUserName"
#define skRemamber @"skRemamber"

@interface LoginViewController ()
@property (nonatomic,assign) Boolean isRemamber;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initUI];
    
    [self RACAction];
    
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
    //设置记住密码的状态
    _isRemamber=[[NSUserDefaults standardUserDefaults] boolForKey:skRemamber];
    if (_isRemamber) {
        _textName.text=[[NSUserDefaults standardUserDefaults] objectForKey:skUserName];
        _textPassword.text=[[NSUserDefaults standardUserDefaults] objectForKey:skPassWord];
    }else{
        _textName.text=[[NSUserDefaults standardUserDefaults] objectForKey:skUserName];
    }
    [self changRemamberButtonState];
}

/**
 设置记住密码是否打钩
 */
- (void)changRemamberButtonState {
    NSString *remamberImage=_isRemamber?@"btn_checkbox_pressed":@"btn_checkbox_default";
    [_btnRemamber setBackgroundImage:[UIImage imageNamed:remamberImage] forState:(UIControlStateNormal)];
}

/**
 登录成功跳转
 */
- (void)loginSuccess {
    
    [[NSUserDefaults standardUserDefaults] setObject:_textName.text forKey:skUserName];
    [[NSUserDefaults standardUserDefaults] setObject:_textPassword.text forKey:skPassWord];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    DriverOrderViewController *view=[[DriverOrderViewController alloc] init];
    UINavigationController *bdv=[[UINavigationController alloc] initWithRootViewController:view];
    [self presentViewController:bdv animated:YES completion:nil];
    
}

/**
 rac监控的点击事件
 */
-(void)RACAction{
    //用户登录
    [[_btnLogin rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (_textName.text.length==11) {
            
            [self userLogin];
//            [self loginSuccess];
            
        }else{
            [SkToast SkToastShow:@"仅支持11位手机号"];
        }
        
    }];
    
    
    //记住密码
    [[_btnRemamberTop rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        _isRemamber=_isRemamber?NO:YES;
        [[NSUserDefaults standardUserDefaults] setBool:_isRemamber forKey:skRemamber];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self changRemamberButtonState];
    }];
    //忘记密码
    [[_btnForget rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        UINavigationController *view=[self.storyboard instantiateViewControllerWithIdentifier:@"ForgetPWNag"];
        [self presentViewController:view animated:YES completion:nil];
        
    }];
}

#pragma mark -用户登录
- (void)userLogin{
    
    NSString *password=_textPassword.text;
    
    NSDictionary *params=@{@"UserName":_textName.text
                           ,@"PassWord":[password MD5]
                           ,@"RememberPwd":_isRemamber?@"0":@"1"
                           ,@"DeviceID":_textName.text
                           ,@"NO":@"UserLogin"
                           };
    
    [[SKNetworking sharedSKNetworking] SKPOST:skURLString parameters:params showHUD:YES showErrMsg:YES success:^(id  _Nullable responseObject) {
        [[UserLogin sharedUserLogin] skChangeUserInfo:skContent(responseObject)];
        
        [self loginSuccess];
        
    } failure:^(NSError * _Nullable error) {

    }];
    
}

@end
