//
//  ForgetPWViewController.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/24.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "ForgetPWViewController.h"
#import "ResetPasswordViewController.h"

@interface ForgetPWViewController ()

@property (nonatomic,assign) int time;
@property (nonatomic,strong) RACSignal *signal;
@property (nonatomic,strong) RACDisposable *disposable;



@end

@implementation ForgetPWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"忘记密码";
    
    UIButton *btnBack=[self skSetNagLeftImage:@"btn_arrow_default"];
    
    kWeakSelf(self)
    [[btnBack rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
    [self initUI];
    [self racAction];
}

-(void)initUI{
    [_btnSure skSetBoardRadius:3 Width:1 andBorderColor:[UIColor clearColor]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)racAction{
    @weakify(self);
    [[_btnSure rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        if (![self.textCode.text isEqualToString:@""]&&![self.textPhoneNum.text isEqualToString:@""]) {
            [self FoundPwd];
        }
        
        
    }];
    [[_btnGetCode rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        if (![self.textPhoneNum.text isEqualToString:@""]) {
            [self GetCode];
        }else{
            [SkHUD skyerShowToast:@"请输入手机号码"];
        }
    }];
    
}
//显示⏳
- (void)timeShow {
    self.btnGetCode.hidden=YES;
    self.time=60;
    //定时每秒进来一次
    self.signal=[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]];
    
    self.disposable=[self.signal subscribeNext:^(id  _Nullable x) {//信号每秒触发一次
        self.time--;
        self.labGetCode.text=[NSString stringWithFormat:@"请等待%d秒",self.time];
        
        if (self.time==0) {
            self.btnGetCode.hidden=NO;
            [self.disposable dispose];
            self.labGetCode.text=@"获取验证码";
        }
        
    }];
}

/**
 获取验证码
 */
-(void)GetCode{
    NSDictionary *parameters=@{@"Tel":_textPhoneNum.text};
    
    [[SKNetworking sharedSKNetworking] SKPOST:skURLWithPort(@"GetCode") parameters:parameters showHUD:YES showErrMsg:YES success:^(id  _Nullable responseObject) {
        [self timeShow];
    } failure:^(NSError * _Nullable error) {
        
    }];
}
/**
 获取验证码
 */
-(void)FoundPwd{
    NSDictionary *parameters=@{@"Tel":self.textPhoneNum.text,
                               @"Code":self.textCode.text
                               };
    
    [[SKNetworking sharedSKNetworking] SKPOST:skURLWithPort(@"FoundPwd") parameters:parameters showHUD:YES showErrMsg:YES success:^(id  _Nullable responseObject) {
        
        UIStoryboard *Main=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ResetPasswordViewController *view=[Main instantiateViewControllerWithIdentifier:@"ResetPasswordViewController"];
        view.Tel=skUser.UserName;
        [self.navigationController pushViewController:view animated:YES];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
