//
//  ResetPasswordViewController.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/5.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "ResetPasswordViewController.h"

@interface ResetPasswordViewController ()

@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"重置密码";
    [self initUI];
    kWeakSelf(self);
    [[_btnSure rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        if ([weakself.textPassword.text isEqualToString:weakself.textPasswordAgain.text]) {
            
            if ([weakself.textPassword.text length]>=6&&[weakself.textPassword.text length]<=16) {
                [weakself ResetPwd];
            }else{
                [SkHUD skyerShowToast:@"密码限制为6-16位"];
            }
            
        }else{
            [SkHUD skyerShowToast:@"确认密码与新密码不一致"];
        }
    }];
}

-(void)initUI{
    [_btnSure skSetBoardRadius:3 Width:1 andBorderColor:[UIColor clearColor]];
}


-(void)ResetPwd{
    
    
    
    NSDictionary *parameters=@{
                               @"Tel":_Tel,
                               @"PassWord":[_textPassword.text MD5]
                               };
    
    
    [[SkNetwork sharedSkNetwork] SKPOST:skURLWithPort(@"ResetPwd") parameters:parameters showHUD:YES showErrMsg:YES success:^(id  _Nullable responseObject) {
        [SkHUD skyerShowToast:@"修改密码成功"];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

@end
