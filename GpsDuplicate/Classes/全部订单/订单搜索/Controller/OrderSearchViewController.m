//
//  OrderSearchViewController.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/7.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "OrderSearchViewController.h"
#import "TableViewForOrder.h"

@interface OrderSearchViewController ()
@property (nonatomic,strong) TableViewForOrder *searchOrder;
@end

@implementation OrderSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_btnSearch skSetBoardRadius:3 Width:1 andBorderColor:[UIColor clearColor]];
    @weakify(self)
    [[_btnSearch rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        if (![self.textSearch.text isEqualToString:@""]) {
            [self SearchOrder];
        }
    }];
}

-(TableViewForOrder *)searchOrder{
    if (_searchOrder==nil) {
        _searchOrder=[[TableViewForOrder alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_btnSearch.frame)+20  , skScreenWidth, skScreenHeight-(CGRectGetMaxY(_btnSearch.frame)+20)) style:(UITableViewStyleGrouped) andType:0];
        [self.view addSubview:_searchOrder];
    }
    return _searchOrder;
}



/**
 获取验证码
 */
-(void)SearchOrder{
    
    NSDictionary *parameters=@{
                               @"VehicleNo":_textSearch.text,
                               @"UserType":skUser.UserType
                               };
    
    
    [SkNetwork.sharedSkNetwork SKPOST:skURLWithPort(@"SearchOrder") parameters:parameters showHUD:YES showErrMsg:YES success:^(id  _Nullable responseObject) {
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
    [self.searchOrder skReloadDataWithData:arrList];
}
@end
