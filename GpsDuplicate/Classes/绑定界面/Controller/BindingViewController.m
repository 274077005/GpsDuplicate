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
    [self initUI];
}

-(void)initUI{
    _labLine.backgroundColor=skLineColor;
    
    [_viewBind skSetBoardRadius:5 Width:1 andBorderColor:[UIColor clearColor]];
    [_btnBind skSetBoardRadius:3 Width:1 andBorderColor:[UIColor clearColor]];
    kWeakSelf(self)
    [[_btnBind rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (![weakself.textNum.text isEqualToString:@""]) {
            [weakself BindVehicle];
        }
        
    }];
}


-(void)BindVehicle{
    NSDictionary *parameters=@{@"No":@"BindVehicle",
                               @"UserName":skUser.UserName,
                               @"VehicleNo":_textNum.text
                               };
    
    kWeakSelf(self)
    [SkNetwork.sharedSkNetwork SKPOST:skURLString parameters:parameters showHUD:YES showErrMsg:YES success:^(id  _Nullable responseObject) {
        //绑定成功后修改绑定车牌号和是否绑定的字段//0绑定、1未绑定
        skUser.VehicleNo=_textNum.text;
        skUser.IsBindVehicle=@"0";
        weakself.bindBlock();
        [weakself dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

@end
