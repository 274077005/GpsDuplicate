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
@property (nonatomic,strong) OrderDetailsDriverTableView *orderDetailsDriverTableView;
@property (nonatomic,strong) UIButton *btnSure;
@property (nonatomic,strong) UIButton *btnAbnormal;



@end

@implementation OrderDetailsDriverViewController

/*-------------------------由于操作需要重复使用,则懒加载--------------------------*/
-(OrderDetailsDriverTableView *)orderDetailsDriverTableView{
    
    if (!_orderDetailsDriverTableView) {
        _orderDetailsDriverTableView=[[OrderDetailsDriverTableView alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, skScreenHeight-120) style:(UITableViewStyleGrouped)];
        [self.view addSubview:_orderDetailsDriverTableView];
    }
    return _orderDetailsDriverTableView;
    
}
-(UIButton *)btnSure{
    if (!_btnSure) {
        _btnSure=[[UIButton alloc] init];
        [_btnSure setBackgroundColor:skBaseColor];
        _btnSure.titleLabel.font=[UIFont systemFontOfSize:14];
        [_btnSure setTitleColor:[UIColor whiteColor] forState:0];
        [_btnSure skSetBoardRadius:3 Width:1 andBorderColor:[UIColor clearColor]];
        [self.view addSubview:_btnSure];
        [_btnSure mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(50);
            make.right.mas_equalTo(-50);
            make.bottom.mas_equalTo(-30);
            make.height.mas_equalTo(30);
        }];
        //司机操作订单按钮
        kWeakSelf(self)
        [[_btnSure rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"确认并提交运单信息?" message:@"提交后不可以修改!" preferredStyle:1];
            UIAlertAction *cancal=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *sure=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakself Confirm];
            }];
            
            [alert addAction:cancal];
            [alert addAction:sure];
            [weakself presentViewController:alert animated:YES completion:nil];
        }];
    }
    return _btnSure;
}

-(UIButton *)btnAbnormal{
    if (!_btnAbnormal) {
        //异常上报
        _btnAbnormal=[[UIButton alloc] init];
        [_btnAbnormal setTitle:@"异常上报" forState:0];
        [_btnAbnormal setTitleColor:skBaseColor forState:0];
        [self.view addSubview:_btnAbnormal];
        [_btnAbnormal mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(skScreenWidth, 30));
            make.bottom.mas_equalTo(_btnSure.mas_top).offset(-15);
        }];
        kWeakSelf(self)
        [[_btnAbnormal rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            UIStoryboard *Main=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            AbnormalViewController *view=[Main instantiateViewControllerWithIdentifier:@"AbnormalViewController"];
            view.OrderID=weakself.model.OrderID;
            [weakself.navigationController pushViewController:view animated:YES];
        }];
    }
    return _btnAbnormal;
}

- (void)bottomView:(NSString *)state{
    //11待确认、12待出场、15待处置、21已完成
    NSString *stateInfo;
    [self.btnSure setHidden:NO];
    [self.btnAbnormal setHidden:NO];
    switch ([state integerValue]) {
        case 11:
            stateInfo=@"确认运单信息";
            break;
        case 12:
            
            stateInfo=@"出厂确认";
            break;
        case 15:
            stateInfo=@"确认处理";
            break;
        case 21:
        {
            stateInfo=@"已完成";
            [self.btnSure setHidden:YES];
            [self.btnAbnormal setHidden:YES];
        }
            break;
            
        default:
            break;
    }
    [self.btnSure setTitle:stateInfo forState:0];
    
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
                               @"UserID":UserLogin.sharedUserLogin.UserID,
                               @"OrderID":self.orderListModel.OrderID,
                               @"UserType":UserLogin.sharedUserLogin.UserType
                               };
    
    [[SKNetworking sharedSKNetworking] SKPOST:skURLString parameters:parameters showHUD:YES showErrMsg:YES success:^(id  _Nullable responseObject) {
        //确认运单信息
        
        _model=[OrderDetailsModel mj_objectWithKeyValues:skContent(responseObject)];
        self.orderDetailsDriverTableView.model=_model;
        [self.orderDetailsDriverTableView reloadData];
        [self bottomView:_model.OrderStatus];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

#pragma mark - 司机操作订单的接口
-(void)Confirm{
    NSDictionary *parameters=@{@"No":@"Confirm",
                               @"UserID":UserLogin.sharedUserLogin.UserID,
                               @"OrderID":self.orderListModel.OrderID,
                               @"OrderStatus":self.orderListModel.OrderStatus,
                               @"UserType":UserLogin.sharedUserLogin.UserType,
                               
                               };
    
    [[SKNetworking sharedSKNetworking] SKPOST:skURLString parameters:parameters showHUD:YES showErrMsg:YES success:^(id  _Nullable responseObject) {
        
        [self GetDetails];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}



@end
