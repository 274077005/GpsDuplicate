//
//  BindingViewController.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/24.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "BindingViewController.h"
#import "DriverOrderViewController.h"

@interface BindingViewController ()

@end

@implementation BindingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[[UIColor grayColor] colorWithAlphaComponent:0.8];
    UserLogin *user=[UserLogin sharedUserLogin];
    NSLog(@"%@",user.UserName);
    [self initUI];
}

-(void)initUI{
    _labLine.backgroundColor=skLineColor;
    
    [_viewBind skSetBoardRadius:5 Width:1 andBorderColor:[UIColor clearColor]];
    [_btnBind skSetBoardRadius:3 Width:1 andBorderColor:[UIColor clearColor]];
    [[_btnBind rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

@end
