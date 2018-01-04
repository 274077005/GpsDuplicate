//
//  DriverDrderViewController.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/27.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "DriverOrderViewController.h"
#import "UserSetViewController.h"
#import "TableViewForOrder.h"
#import "skSelectView.h"
#import <SkPageViews.h>
#import "OrderListModel.h"
#import "BindingViewController.h"
#import "PopMenuViewController.h"
#import "skJPUSHSet.h"


@interface DriverOrderViewController ()

@property (nonatomic,strong) skSelectView *skSelect;
@property (nonatomic,strong) SkPageViews *aapv;
@property (nonatomic,strong) TableViewForOrder *finishView;
@property (nonatomic,strong) TableViewForOrder *unFinishView;
@property (nonatomic,assign) NSInteger indexSelect;
@property (nonatomic,strong) UIButton *btnLeft;

@end

@implementation DriverOrderViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    _indexSelect=1;
    // Do any additional setup after loading the view.
    self.title=@"全部运单";
    self.view.backgroundColor=skLineColor;
    UIButton *btnUser=[self skSetNagRightImage:@"nar_btn_set_default"];
    @weakify(self)
    [[btnUser rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        UIViewController *userSetView=[[UserSetViewController alloc] init];
        [self.navigationController pushViewController:userSetView animated:YES];
        
    }];
    
    [[self.btnLeft rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        
        @strongify(self)
        [SkClassMethod skAlerView:@"确定解绑车辆吗?" message:nil cancalTitle:@"取消" sureTitle:@"确定" sureBlock:^{
            [self UnBindVehicle];
        }];
        
    }];
    
    //0绑定、1未绑定
    if ([skUser.IsBindVehicle isEqualToString:@"1"]) {
        [self showBingdView];
    }else{
        [self initUI];
        [self changVehicleNo];
        [self GetList];
    }
    [self jpushRefreshList];
}
-(UIButton *)btnLeft{
    if (_btnLeft==nil) {
        _btnLeft=[[UIButton alloc] initWithFrame:CGRectMake(0,0,80,30)];
        [_btnLeft setTitleColor:skBaseColor forState:0];
        _btnLeft.titleLabel.font =[UIFont systemFontOfSize:14];
        UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithCustomView:_btnLeft];
        self.navigationItem.leftBarButtonItem = btnBack;
    }
    return _btnLeft;
}

/**
 修改车牌号码
 */
-(void)changVehicleNo{
    //0绑定、1未绑定
    if ([skUser.IsBindVehicle isEqualToString:@"1"]) {
        self.btnLeft.hidden=YES;
    }else{
        self.btnLeft.hidden=NO;
        [self.btnLeft setTitle:skUser.VehicleNo forState:0];
        [_btnLeft setBackgroundImage:[UIImage imageNamed:@"btn_license_locked_default"] forState:UIControlStateNormal];
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    if (![skUser.IsBindVehicle isEqualToString:@"1"]) {
        [self GetList];
    }
    
}

/**
 如果是司机登录就先显示绑定界面
 */
- (void)showBingdView {
    
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BindingViewController *bind=[story instantiateViewControllerWithIdentifier:@"BindingViewController"];
    
    [bind setBindBlock:^{
        [self changVehicleNo];
        [self initUI];
        [self GetList];
    }];
    
    //设置模式展示风格
    [bind setModalPresentationStyle:UIModalPresentationOverFullScreen];
    //必要配置
    self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
    
    [self presentViewController:bind animated:YES completion:nil];
}

/**
 创建UI,司机端就只有已完成和未完成
 */
-(void)initUI{
    self.view.backgroundColor=[UIColor whiteColor];
    
    _skSelect=[[skSelectView alloc] initWithFrame:CGRectMake(0, 64, skScreenWidth, 46) andTitleArr:@[@"未完成",@"已完成"]  andSelectIndex:0  andSelectColor:skBaseColor];
    
    [self.view addSubview:_skSelect];
    
    
    
    _unFinishView=[[TableViewForOrder alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, skScreenHeight-64-46) style:(UITableViewStyleGrouped) andType:@"1"];
    _finishView=[[TableViewForOrder alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, skScreenHeight-64-46) style:(UITableViewStyleGrouped) andType:@"0"];
    
    
    _aapv=[[SkPageViews alloc] initWithFrame:CGRectMake(0, 64+46, skScreenWidth, skScreenHeight-64-46) andArrViews:@[_unFinishView,_finishView] andSelecetIndex:0];
    [self.view addSubview:_aapv];
    
    kWeakSelf(self)
    [_aapv setIndexBlock:^(NSInteger index) {
        weakself.indexSelect=index?0:1;
        [weakself.skSelect skChangSelect:index];
        [weakself GetList];
    }];
    [_skSelect setSelectIndexBlock:^(NSInteger index) {
        [weakself.aapv skChangPage:index];
    }];
}

#pragma mark - 获取列表数据
-(void)jpushRefreshList{
    skJPUSHSet *jpset=[skJPUSHSet sharedskJPUSHSet];
    @weakify(self);
    [[jpset rac_signalForSelector:@selector(skReceiveJush:)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        [self GetList];
    }];
}

-(void)GetList{
    
    /*
     OrderType==>这个参数在切换的时候会自己变
     运单类型：司机登录：0已完成 1未完成
     监管人员登录：0待确认 1待签认 2已签认
     */
    NSDictionary *parameters=@{@"UserID":skUser.UserID,
                               @"OrderType":[NSString stringWithFormat:@"%ld",_indexSelect],
                               @"UserType":skUser.UserType,
                               @"No":@"GetList"
                               };
    
    
    [[SkNetwork sharedSkNetwork] SKPOST:skURLString parameters:parameters showHUD:NO showErrMsg:YES success:^(id  _Nullable responseObject) {
        
        [self getListModelArr:responseObject];
        
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

/**
 获取模型数组

 @param responseObject 这个是接口返回的数据
 */
- (void)getListModelArr:(id _Nullable)responseObject {
    NSArray *arrData=skContent(responseObject);
    
    NSMutableArray *arrList=[[NSMutableArray alloc] init];
    
    for (int i =0; i<arrData.count; ++i) {
        NSDictionary *oneDic=[arrData objectAtIndex:i];
        OrderListModel *model=[OrderListModel mj_objectWithKeyValues:oneDic];
        [arrList addObject:model];
    }
    //运单类型：司机登录：0已完成 1未完成

    if (_indexSelect==0) {
        [_finishView skReloadDataWithData:arrList];
    }else{
        [_unFinishView skReloadDataWithData:arrList];
    }
}
#pragma mark - 解除绑定
/**
 获取验证码
 */
-(void)UnBindVehicle{
    
    
    NSDictionary *parameters=@{
                               @"UserName":skUser.UserName
                               };
    
    
    [[SkNetwork sharedSkNetwork] SKPOST:skURLWithPort(@"UnBindVehicle") parameters:parameters showHUD:YES showErrMsg:YES success:^(id  _Nullable responseObject) {
        [self showBingdView];
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
