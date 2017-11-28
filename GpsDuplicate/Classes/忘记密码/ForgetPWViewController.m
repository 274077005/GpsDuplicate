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
    
    [self skSetNagRightTitle:@"帅气" withColor:[UIColor redColor]];
    
    [self skSetNagLeftTitle:@"你妹" withColor:[UIColor redColor]];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
