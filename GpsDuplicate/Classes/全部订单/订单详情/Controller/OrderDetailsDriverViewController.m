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
#import "PopMenuViewController.h"

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

@property (nonatomic,assign) NSInteger wasIndex;
@property (nonatomic,assign) NSInteger recIndex;

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
        
        //废弃物的点击事件
        @weakify(self)
        [[_orderDetailsManagerActionTableView rac_signalForSelector:@selector(btnWaste:)] subscribeNext:^(RACTuple * _Nullable x) {
            @strongify(self);
            if (_arrWasteModel.count>1) {
                RACTupleUnpack(NSString *string)=x;
                CGRect frame = CGRectFromString([NSString stringWithFormat:@"%@",string]);
                [self selectWaste:frame];
            }
            
        }];
        //终点
        [[_orderDetailsManagerActionTableView rac_signalForSelector:@selector(btnReceiving:)] subscribeNext:^(RACTuple * _Nullable x) {
            @strongify(self);
            if (_arrReceivingModel.count>1) {
                RACTupleUnpack(NSString *string)=x;
                CGRect frame = CGRectFromString([NSString stringWithFormat:@"%@",string]);
                [self selectReceiving:frame];
            }
            
        }];
        
    }
    return _orderDetailsManagerActionTableView;
}

/**
 设置那个废弃物的

 @param frame 显示的frame
 */
-(void)selectWaste:(CGRect)frame{
    PopMenuViewController *pop=[[PopMenuViewController alloc] init];
    NSMutableArray *arrTitle=[[NSMutableArray alloc] init];
    for (int i=0; i<_arrWasteModel.count; ++i) {
        WasteModel *rmodel=[_arrWasteModel objectAtIndex:i];
        [arrTitle addObject:rmodel.WasteName];
    }
    
    pop.arrData=arrTitle;
    //设置模式展示风格
    UIViewController *vc=[[SkyerGetVisibleViewController sharedSkyerGetVisibleViewController] skyerVisibleViewController];
    [pop setModalPresentationStyle:UIModalPresentationOverFullScreen];
    //必要配置
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    vc.providesPresentationContextTransitionStyle = YES;
    vc.definesPresentationContext = YES;
    [self presentViewController:pop animated:YES completion:nil];
    pop.skIndexSelect = ^(NSInteger index) {
        _wasIndex=index;
        [self updataUI];
    };
    
    
}

/**
 设置终点

 @param frame 显示的frame
 */
-(void)selectReceiving:(CGRect)frame{
    PopMenuViewController *pop=[[PopMenuViewController alloc] init];
    
    NSMutableArray *arrTitle=[[NSMutableArray alloc] init];
    for (int i=0; i<_arrReceivingModel.count; ++i) {
        ReceivingModel *rmodel=[_arrReceivingModel objectAtIndex:i];
        [arrTitle addObject:rmodel.ReceivingName];
    }
    
    pop.arrData=arrTitle;
    //设置模式展示风格
    UIViewController *vc=[[SkyerGetVisibleViewController sharedSkyerGetVisibleViewController] skyerVisibleViewController];
    [pop setModalPresentationStyle:UIModalPresentationOverFullScreen];
    //必要配置
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    vc.providesPresentationContextTransitionStyle = YES;
    vc.definesPresentationContext = YES;
    [self presentViewController:pop animated:YES completion:nil];
    pop.skIndexSelect = ^(NSInteger index) {
        _recIndex=index;
        [self updataUI];
    };
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
        [[_orderDetailsDriverBottomView rac_signalForSelector:@selector(delegateBtnSure)] subscribeNext:^(RACTuple * _Nullable x) {
            @strongify(self)
            [self Confirm];
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
        [[_orderDetailsManagerBottomView rac_signalForSelector:@selector(delegateBtnSure)] subscribeNext:^(RACTuple * _Nullable x) {
            @strongify(self)
            
            if ([self isOrderAction]) {
                [self SaveOrderDetails];
            }else{
                [self Confirm];
            }
            
        }];
    }
    return _orderDetailsManagerBottomView;
}


- (void)initUI {
    self.view.backgroundColor=skLineColor;
    self.title=@"运单详情";
}

/**
 获取订单详情
 */
- (void)getOrderDetails {
    if ([self isOrderAction]) {
        [self EditOrderDetails];
    }else{
        [self GetDetails];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self getOrderDetails];
    NSLog(@"%@\n%@",skUser.UserType,self.orderListModel.OrderStatus);
    
}

#pragma mark - 获取不能修改的订单详情
//获取详情数据接口
-(void)GetDetails{
    NSDictionary *parameters=@{@"No":@"GetDetails",
                               @"UserID":skUser.UserID,
                               @"OrderID":self.orderListModel.OrderID,
                               @"UserType":skUser.UserType
                               };
    
    [[SKNetworking sharedSKNetworking] SKPOST:skURLString parameters:parameters showHUD:YES showErrMsg:YES success:^(id  _Nullable responseObject) {
        //获取数据成功.首先更新tableview.再更新bottom的界面
        NSLog(@"%@",responseObject);
        _model=[OrderDetailsModel mj_objectWithKeyValues:skContent(responseObject)];
        
        //请求完数据更新UI
        [self updataUI];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

#pragma mark - 获取修改的订单详情
/**
 获取修改的订单详情
 */
-(void)EditOrderDetails{
    NSDictionary *parameters=@{@"OrderID":self.orderListModel.OrderID};
    
    
    [[SKNetworking sharedSKNetworking] SKPOST:skURLWithPort(@"EditOrderDetails") parameters:parameters showHUD:YES showErrMsg:YES success:^(id  _Nullable responseObject) {
        
        NSLog(@"%@",[responseObject objectForKey:@"Receiving"]);
        
        
        _model=[OrderDetailsModel mj_objectWithKeyValues:skContent(responseObject)];
        _arrWasteModel=[WasteModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"Waste"]];
        
        
        _arrReceivingModel=[ReceivingModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"Receiving"]];
        
        //请求完数据更新UI
        [self updataUI];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}





/**
 提交订单详情
 */
-(void)Confirm{
    NSDictionary *parameters=@{@"No":@"Confirm",
                               @"UserID":skUser.UserID,
                               @"OrderID":self.model.OrderID,
                               @"OrderStatus":self.model.OrderStatus,
                               @"UserType":skUser.UserType,
                               };
    kWeakSelf(self);
    [[SKNetworking sharedSKNetworking] SKPOST:skURLString parameters:parameters showHUD:YES showErrMsg:YES success:^(id  _Nullable responseObject) {
        [weakself getOrderDetails];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

/**
 获取验证码
 */
-(void)SaveOrderDetails{
    NSDictionary *parameters=@{
                               @"OrderID":_model.OrderID,
                               @"WasteType":self.orderDetailsManagerActionTableView.wasteModel.WasteName,
                               @"Loading":self.orderDetailsManagerActionTableView.textLoading.text,
                               @"ReceivingID":self.orderDetailsManagerActionTableView.receivingModel.ReceivingName,
                               @"UserID":skUser.UserID
                               };
    
    kWeakSelf(self);
    [[SKNetworking sharedSKNetworking] SKPOST:skURLWithPort(@"SaveOrderDetails") parameters:parameters showHUD:YES showErrMsg:YES success:^(id  _Nullable responseObject) {
        [weakself getOrderDetails];
    } failure:^(NSError * _Nullable error) {
        
    }];
}


//请求完数据更新UI
- (void)updataUI{
    
    NSString *UserType=skUser.UserType;
    //1、司机 2、施工单位管理员(具有修改功能) 3、工地理监单位监理员 4、处置场处理员
    /*
     OrderStatus
     (待签认-已经签认-和司机相同) (待确认 监理和处理=页面不同 )
     司机:       状态：11已激活、12待出场、15待处置、21已完成
     工地施工单位: 状态：12待确认、17待签认、14已签认
     工地监理单位: 状态：12待确认、17待签认、13已签认
     处置场处理员: 状态：15待确认、17待签认、22已签认
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
            if ([self isOrderAction]) {
                self.orderDetailsManagerActionTableView.model=_model;
                self.orderDetailsManagerActionTableView.wasteModel=[_arrWasteModel objectAtIndex:_wasIndex];
                self.orderDetailsManagerActionTableView.receivingModel=[_arrReceivingModel objectAtIndex:_recIndex];
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

/**
 判断是否有修改订单的功能

 @return yes就有,no就没有
 */
-(Boolean)isOrderAction{
    
    if ([skUser.UserType integerValue]==2&&[_orderListModel.OrderStatus integerValue]==12) {
        return true;
    }
    return false;
}

@end
