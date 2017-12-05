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
#import "SkScollPageView.h"
#import "OrderListModel.h"
#import "BindingViewController.h"


@interface DriverOrderViewController ()

@property (nonatomic,strong) skSelectView *skSelect;
@property (nonatomic,strong) SkScollPageView *aapv;
@property (nonatomic,strong) TableViewForOrder *finishView;
@property (nonatomic,strong) TableViewForOrder *unFinishView;
@property (nonatomic,assign) NSInteger indexSelect;

@end

@implementation DriverOrderViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"全部运单";
    self.view.backgroundColor=skLineColor;
    UIButton *btnUser=[self skSetNagRightImage:@"nar_btn_set_default"];
    kWeakSelf(self)
    [[btnUser rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        UIViewController *userSetView=[[UserSetViewController alloc] init];
        [weakself.navigationController pushViewController:userSetView animated:YES];
        
    }];
    
    //0绑定、1未绑定
    if (![UserLogin.sharedUserLogin.IsBindVehicle isEqualToString:@"1"]) {
        [self showBingdView];
    }else{
        [self initUI];
        [self GetList:[NSString stringWithFormat:@"%ld",_indexSelect]];
    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    if (![UserLogin.sharedUserLogin.IsBindVehicle isEqualToString:@"1"]) {
        [self GetList:[NSString stringWithFormat:@"%ld",_indexSelect]];
    }
    
}

/**
 如果是司机登录就先显示绑定界面
 */
- (void)showBingdView {
    
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BindingViewController *bind=[story instantiateViewControllerWithIdentifier:@"BindingViewController"];
    [bind setBindBlock:^{
        [self initUI];
        [self GetList:[NSString stringWithFormat:@"%ld",_indexSelect]];
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
    _skSelect=[[skSelectView alloc] initWithFrame:CGRectMake(0, 64, skScreenWidth, 46) andTitleArr:@[@"已完成",@"未完成"]  andSelectIndex:0  andSelectColor:skBaseColor];
    
    [self.view addSubview:_skSelect];
    
    
    _finishView=[[TableViewForOrder alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, skScreenHeight-64-46) style:(UITableViewStyleGrouped) andType:@"0"];
    _unFinishView=[[TableViewForOrder alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, skScreenHeight-64-46) style:(UITableViewStyleGrouped) andType:@"1"];
    
    
    _aapv=[[SkScollPageView alloc] initWithFrame:CGRectMake(0, 64+46, skScreenWidth, skScreenHeight-64-46) andArrViews:@[_finishView,_unFinishView] andSelecetIndex:0];
    [self.view addSubview:_aapv];
    
    kWeakSelf(self)
    [_aapv setIndexBlock:^(NSInteger index) {
        _indexSelect=index;
        [weakself.skSelect skChangSelect:index];
        [weakself GetList:[NSString stringWithFormat:@"%ld",index]];
    }];
    [_skSelect setSelectIndexBlock:^(NSInteger index) {
        _indexSelect=index;
        [weakself.aapv skChangPage:index];
    }];
}

#pragma mark - 获取列表数据


-(void)GetList:(NSString *)OrderType{
    
    NSDictionary *parameters=@{@"UserID":UserLogin.sharedUserLogin.UserID,
                               @"OrderType":OrderType,
                               @"UserType":UserLogin.sharedUserLogin.UserType,
                               @"No":@"GetList"
                               };
    
    
    [[SKNetworking sharedSKNetworking] SKPOST:skURLString parameters:parameters showHUD:NO showErrMsg:YES success:^(id  _Nullable responseObject) {
        
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

@end
