//
//  OrderDetailsDriverViewController.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/2.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "OrderDetailsDriverViewController.h"
#import "OrderDetailsDriverTableView.h"
#import "OrderDetailsModel.h"

@interface OrderDetailsDriverViewController ()

@end

@implementation OrderDetailsDriverViewController

- (void)bottomView {
    UIButton *btnSure=[[UIButton alloc] init];
    [btnSure setBackgroundColor:skBaseColor];
    [btnSure setTitle:@"确认运单信息" forState:0];
    btnSure.titleLabel.font=[UIFont systemFontOfSize:14];
    [btnSure setTitleColor:[UIColor whiteColor] forState:0];
    [btnSure skSetBoardRadius:3 Width:1 andBorderColor:[UIColor clearColor]];
    [self.view addSubview:btnSure];
    [btnSure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.bottom.mas_equalTo(-30);
        make.height.mas_equalTo(30);
    }];
    
    //异常上报
    UIButton *btnAbnormal=[[UIButton alloc] init];
    [btnAbnormal setTitle:@"异常上报" forState:0];
    [btnAbnormal setTitleColor:skBaseColor forState:0];
    [self.view addSubview:btnAbnormal];
    [btnAbnormal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(skScreenWidth, 30));
        make.bottom.mas_equalTo(btnSure.mas_top).offset(-15);
    }];
}

- (void)initUI {
    self.view.backgroundColor=skLineColor;
    self.title=@"运单详情";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self GetDetails];
}
-(void)GetDetails{
    
    NSDictionary *parameters=@{@"No":@"GetDetails",
                               @"UserID":self.user.UserID,
                               @"OrderID":self.OrderID,
                               @"UserType":self.user.UserType
                               };
    
    [[SKNetworking sharedSKNetworking] SKPOST:skURLString parameters:parameters showHUD:YES showErrMsg:YES success:^(id  _Nullable responseObject) {
        //确认运单信息
        [self bottomView];
        OrderDetailsModel *model=[OrderDetailsModel mj_objectWithKeyValues:skContent(responseObject)];
        
        OrderDetailsDriverTableView *odt=[[OrderDetailsDriverTableView alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, skScreenHeight-120) style:(UITableViewStyleGrouped)];
        odt.model=model;
        [self.view addSubview:odt];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

@end
