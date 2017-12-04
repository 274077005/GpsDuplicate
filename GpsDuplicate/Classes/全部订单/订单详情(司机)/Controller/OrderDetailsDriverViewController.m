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
#import "AbnormalViewController.h"

@interface OrderDetailsDriverViewController ()
@property (nonatomic,strong) OrderDetailsModel *model;
@end

@implementation OrderDetailsDriverViewController

- (void)bottomView:(NSString *)state{
    //11待确认、12待出场、15待处置、21已完成
    NSString *stateInfo;
    switch ([state integerValue]) {
        case 11:
            stateInfo=@"出厂确认";
            break;
        case 12:
            stateInfo=@"确认处理";
            break;
        case 15:
            stateInfo=@"确认运单信息";
            break;
        case 21:
            stateInfo=@"已完成";
            break;
            
        default:
            break;
    }
    
    
    UIButton *btnSure=[[UIButton alloc] init];
    [btnSure setBackgroundColor:skBaseColor];
    [btnSure setTitle:stateInfo forState:0];
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
    [[btnSure rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
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
    [[btnAbnormal rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        UIStoryboard *Main=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        AbnormalViewController *view=[Main instantiateViewControllerWithIdentifier:@"AbnormalViewController"];
        view.OrderID=_model.OrderID;
        [self.navigationController pushViewController:view animated:YES];
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
        
        _model=[OrderDetailsModel mj_objectWithKeyValues:skContent(responseObject)];
        //21是已经完成
        if ([_model.OrderStatus integerValue]!=21) {
            [self bottomView:_model.OrderStatus];
        }
        
        OrderDetailsDriverTableView *odt=[[OrderDetailsDriverTableView alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, skScreenHeight-120) style:(UITableViewStyleGrouped)];
        odt.model=_model;
        [self.view addSubview:odt];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

@end
