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
#import "OrderDetailsDriverBottomView.h"
#import "OrderDetailsManagerActionTableView.h"
#import "OrderDetailsManagerTableView.h"
#import "OrderDetailsManagerBottomView.h"

@interface OrderDetailsDriverViewController ()
@property (nonatomic,strong) OrderDetailsModel *model;

//司机
@property (nonatomic,strong) OrderDetailsDriverBottomView *orderDetailsDriverBottomView;
//管理员
@property (nonatomic,strong) OrderDetailsManagerBottomView *orderDetailsManagerBottomView;

//司机的界面
@property (nonatomic,strong) OrderDetailsDriverTableView *orderDetailsDriverTableView;
//2、施工单位管理员(只有待确认状态下)(具有修改功能)
@property (nonatomic,strong) OrderDetailsManagerActionTableView *orderDetailsManagerActionTableView;
//2、施工单位管理员 3、工地理监单位监理员 4、处置场处理员
@property (nonatomic,strong) OrderDetailsManagerTableView *orderDetailsManagerTableView;



@end

@implementation OrderDetailsDriverViewController

/*-------------------------由于操作需要重复使用,则懒加载--------------------------*/

//司机的
-(OrderDetailsDriverTableView *)orderDetailsDriverTableView{
    
    if (!_orderDetailsDriverTableView) {
        _orderDetailsDriverTableView=[[OrderDetailsDriverTableView alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, skScreenHeight-120) style:(UITableViewStyleGrouped)];
        [self.view addSubview:_orderDetailsDriverTableView];
    }
    return _orderDetailsDriverTableView;
    
}
//能修改运单信息的
-(OrderDetailsManagerActionTableView *)orderDetailsManagerActionTableView{
    if (_orderDetailsManagerActionTableView==nil) {
        _orderDetailsManagerActionTableView=[[OrderDetailsManagerActionTableView alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, skScreenHeight-120) style:(UITableViewStyleGrouped)];
        [self.view addSubview:_orderDetailsManagerActionTableView];
    }
    return _orderDetailsManagerActionTableView;
}
//不能修改运动信息的
-(OrderDetailsManagerTableView *)orderDetailsManagerTableView{
    if (_orderDetailsManagerTableView==nil) {
        //初始化这个没有操作的界面就把能操作的清除掉,反正没有用了
        if (_orderDetailsManagerActionTableView) {
            _orderDetailsManagerActionTableView=nil;
        }
        
        _orderDetailsManagerTableView=[[OrderDetailsManagerTableView alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, skScreenHeight-120) style:(UITableViewStyleGrouped)];
        [self.view addSubview:_orderDetailsManagerTableView];
    }
    return _orderDetailsManagerTableView;
}

//司机的底部
-(OrderDetailsDriverBottomView *)orderDetailsDriverBottomView{
    if (_orderDetailsDriverBottomView==nil) {
        _orderDetailsDriverBottomView=[[OrderDetailsDriverBottomView alloc] initWithFrame:CGRectMake(0, skScreenHeight-120, skScreenWidth, 120)];
        [self.view addSubview:_orderDetailsDriverBottomView];
        @weakify(self)
        [[_orderDetailsDriverBottomView rac_signalForSelector:@selector(delegateOrderDetailsDataUpdate)] subscribeNext:^(RACTuple * _Nullable x) {
            @strongify(self)
            [self GetDetails];
        }];
    }
    return _orderDetailsDriverBottomView;
}
//监理的底部
-(OrderDetailsManagerBottomView *)orderDetailsManagerBottomView{
    if (_orderDetailsManagerBottomView==nil) {
        _orderDetailsManagerBottomView=[[OrderDetailsManagerBottomView alloc] initWithFrame:CGRectMake(0, skScreenHeight-120, skScreenWidth, 120)];
        [self.view addSubview:_orderDetailsManagerBottomView];
        @weakify(self)
        [[_orderDetailsManagerBottomView rac_signalForSelector:@selector(delegateOrderDetailsDataUpdate)] subscribeNext:^(RACTuple * _Nullable x) {
            @strongify(self)
            [self GetDetails];
        }];
    }
    return _orderDetailsManagerBottomView;
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



//获取详情数据接口
-(void)GetDetails{
    NSDictionary *parameters=@{@"No":@"GetDetails",
                               @"UserID":UserLogin.sharedUserLogin.UserID,
                               @"OrderID":self.orderListModel.OrderID,
                               @"UserType":UserLogin.sharedUserLogin.UserType
                               };
    
    [[SKNetworking sharedSKNetworking] SKPOST:skURLString parameters:parameters showHUD:YES showErrMsg:YES success:^(id  _Nullable responseObject) {
        //获取数据成功.首先更新tableview.再更新bottom的界面
        _model=[OrderDetailsModel mj_objectWithKeyValues:skContent(responseObject)];
        
        //请求完数据更新UI
        [self updataUI];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
//请求完数据更新UI
- (void)updataUI {
    
    NSString *UserType=UserLogin.sharedUserLogin.UserType;
    //1、司机 2、施工单位管理员(具有修改功能) 3、工地理监单位监理员 4、处置场处理员
    /*
     OrderStatus
     (待签认-已经签认-和司机相同) (待确认 监理和处理=页面不同 )
     司机:       状态：11已激活、12待出场、15待处置、21已完成
     工地施工单位: 状态：12待确认、15待签认、14已签认
     工地监理单位: 状态：12待确认、15待签认、13已签认
     处置场处理员: 状态：15待确认、21待签认、22已签认
     */
    switch ([UserType integerValue]) {
        case 1:
        {
            self.orderDetailsDriverTableView.model=_model;
            [self.orderDetailsDriverTableView reloadData];
            self.orderDetailsDriverBottomView.model=_model;
            [self.orderDetailsDriverBottomView updateUI];
        }
            break;
        case 2:
        {
            NSString *OrderStatus=_model.OrderStatus;
            if ([OrderStatus isEqualToString:@"12"]) {//只有这个状态是可以进行修改操作的
                self.orderDetailsManagerActionTableView.model=_model;
                [self.orderDetailsManagerActionTableView reloadData];
            }else{
                self.orderDetailsManagerTableView.model=_model;
                [self.orderDetailsManagerTableView reloadData];
            }
            
            self.orderDetailsManagerBottomView.model=_model;
            [self.orderDetailsManagerBottomView updateUI];
            
        }
            break;
        case 3:case 4:
            
        {
            self.orderDetailsManagerTableView.model=_model;
            [self.orderDetailsManagerTableView reloadData];
            
            self.orderDetailsManagerBottomView.model=_model;
            [self.orderDetailsManagerBottomView updateUI];
        }
            break;
            
        default:
            break;
    }
    
    
    
}


@end
