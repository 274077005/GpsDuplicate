//
//  ForgetPWViewController.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/24.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "ForgetPWViewController.h"

@interface ForgetPWViewController ()

@end

@implementation ForgetPWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"忘记密码";
    
    UIButton *btnBack=[self skSetNagLeftImage:@"btn_arrow_default"];
    [[btnBack rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
    [self initUI];
}

-(void)initUI{
    [_btnSure skSetBoardRadius:3 Width:1 andBorderColor:[UIColor clearColor]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
