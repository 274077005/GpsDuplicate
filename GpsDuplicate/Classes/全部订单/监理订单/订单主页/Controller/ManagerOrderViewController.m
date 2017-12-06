//
//  ManagerOrderViewController.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/28.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "ManagerOrderViewController.h"
#import "UserSetViewController.h"
#import "TableViewForOrder.h"
#import "skSelectView.h"
#import "SkScollPageView.h"
#import "OrderListModel.h"
#import "BindingViewController.h"

@interface ManagerOrderViewController ()

@property (nonatomic,strong) skSelectView *skSelect;
@property (nonatomic,strong) SkScollPageView *aapv;
@property (nonatomic,strong) TableViewForOrder *sureWaitingView;
@property (nonatomic,strong) TableViewForOrder *signWaitingView;
@property (nonatomic,strong) TableViewForOrder *signWaitedView;
@property (nonatomic,assign) NSInteger indexSelect;

@end

@implementation ManagerOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    UIButton *btnSearch=[self skSetNagLeftImage:@"nav_btn_search_default"];
    
    [[btnSearch rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
    }];
    
    
    [self initUI];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self GetList:[NSString stringWithFormat:@"%ld",_indexSelect]];
    
}


/**
 创建UI,司机端就只有已完成和未完成
 */
-(void)initUI{
    self.view.backgroundColor=[UIColor whiteColor];
    _skSelect=[[skSelectView alloc] initWithFrame:CGRectMake(0, 64, skScreenWidth, 46) andTitleArr:@[@"待确认",@"待签认",@"已签认"]  andSelectIndex:0  andSelectColor:skBaseColor];
    
    [self.view addSubview:_skSelect];
    
    
    _sureWaitingView=[[TableViewForOrder alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, skScreenHeight-64-46) style:(UITableViewStyleGrouped) andType:@"0"];
    _signWaitingView=[[TableViewForOrder alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, skScreenHeight-64-46) style:(UITableViewStyleGrouped) andType:@"1"];
    _signWaitedView=[[TableViewForOrder alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, skScreenHeight-64-46) style:(UITableViewStyleGrouped) andType:@"2"];
    
    
    _aapv=[[SkScollPageView alloc] initWithFrame:CGRectMake(0, 64+46, skScreenWidth, skScreenHeight-64-46) andArrViews:@[_sureWaitingView,_signWaitingView,_signWaitedView] andSelecetIndex:0];
    
    [self.view addSubview:_aapv];
    
    kWeakSelf(self)
    [_aapv setIndexBlock:^(NSInteger index) {
        weakself.indexSelect=index;
        [weakself.skSelect skChangSelect:index];
        [weakself GetList:[NSString stringWithFormat:@"%ld",weakself.indexSelect]];
    }];
    [_skSelect setSelectIndexBlock:^(NSInteger index) {
        weakself.indexSelect=index;
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
    
    switch (_indexSelect) {
        case 0:
        {
            [_sureWaitingView skReloadDataWithData:arrList];
        }
            break;
        case 1:
        {
            [_signWaitingView skReloadDataWithData:arrList];
        }
            break;
        case 2:
        {
            [_signWaitedView skReloadDataWithData:arrList];
        }
            break;
            
        default:
            break;
    }
}
@end
