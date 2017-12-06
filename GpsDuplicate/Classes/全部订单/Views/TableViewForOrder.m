//
//  TableViewForOrder.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/28.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "TableViewForOrder.h"
#import "OrderDetailsDriverViewController.h"
#import "OrderListModel.h"

#define skCellHigth  170

@implementation TableViewForOrder 

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style andType:(NSString *)type{
    self=[super initWithFrame:frame style:style];
    if (self) {
        self.delegate=self;
        self.dataSource=self;
    }
    return self;
}

#pragma mark - cell的代理
#pragma mark cell 的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return skCellHigth;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _arrCellData.count;
}
#pragma mark section下得cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, 0)];
    view.backgroundColor=skLineColor;
    return view;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, 10)];
    view.backgroundColor=skLineColor;
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

#pragma mark 绘制一个cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    static NSString *cellIdentifier = @"TableViewForOrder";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }

    OrderListModel *model=[_arrCellData objectAtIndex:indexPath.section];
    
    cell.backgroundColor=skLineColor;
    //添加一个view
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(8, 0, skScreenWidth-16, skCellHigth)];
    [view skSetBoardRadius:2 Width:1 andBorderColor:[UIColor clearColor]];
    view.backgroundColor=[UIColor whiteColor];
    
    //添加订单编号
    UILabel *labOrder=[[UILabel alloc] initWithFrame:CGRectMake(8, 0, view.frame.size.width-16, 44)];
    
    labOrder.text=[NSString stringWithFormat:@"运单编号:%@",model.OrderID];
    labOrder.font=[UIFont systemFontOfSize:16];
    labOrder.textColor=[UIColor blackColor];
    [view addSubview:labOrder];
    //订单状态
    UILabel *labState=[[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width-70, 10, 60, 25)];
    labState.textColor=[UIColor whiteColor];
    labState.backgroundColor=[UIColor orangeColor];
    labState.font=[UIFont systemFontOfSize:15];
    labState.textAlignment=1;
    labState.text=model.StatusName;
    [view addSubview:labState];
    //分割线
    UILabel *labLine=[[UILabel alloc] initWithFrame:CGRectMake(8, 45, view.frame.size.width-16, 1)];
    labLine.backgroundColor=skLineColor;
    [view addSubview:labLine];
    CGFloat labLineY=CGRectGetMaxY(labLine.frame);
    
    
    //连接起点终点的线条
    UILabel *labseLine=[[UILabel alloc] initWithFrame:CGRectMake(23, labLineY+30, 4, 50)];
    labseLine.backgroundColor=[UIColor lightGrayColor];
    [view addSubview:labseLine];
    
    
    
    //起点
    UILabel *labStart=[[UILabel alloc] initWithFrame:CGRectMake(10, labLineY+20, 30, 30)];
    labStart.backgroundColor=skBaseColor;
    labStart.text=@"起";
    labStart.font=[UIFont systemFontOfSize:20];
    labStart.textColor=[UIColor whiteColor];
    labStart.textAlignment=1;
    [labStart skSetBoardRadius:15 Width:1 andBorderColor:[UIColor clearColor]];
    [view addSubview:labStart];
    CGFloat labStartY=CGRectGetMaxY(labStart.frame);
    
    //终点
    UILabel *labEnd=[[UILabel alloc] initWithFrame:CGRectMake(10, labStartY+25, 30, 30)];
    labEnd.backgroundColor=skUIColorFromRGB(0x529DE2);
    labEnd.text=@"终";
    labEnd.font=[UIFont systemFontOfSize:20];
    labEnd.textColor=[UIColor whiteColor];
    labEnd.textAlignment=1;
    [labEnd skSetBoardRadius:15 Width:1 andBorderColor:[UIColor clearColor]];
    [view addSubview:labEnd];
    
    //起点地址
    UILabel *labStAddress=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(labStart.frame)+10, CGRectGetMinY(labStart.frame)-5, skScreenWidth-150, 40)];
    labStAddress.text=model.ProjectAddress;
    labStAddress.font=[UIFont systemFontOfSize:14];
    labStAddress.textColor=[UIColor grayColor];
    labStAddress.numberOfLines=2;
    [view addSubview:labStAddress];
    
    //终点地址
    UILabel *labEndAddress=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(labEnd.frame)+10, CGRectGetMinY(labEnd.frame)-5, skScreenWidth-150, 40)];
    labEndAddress.text=model.ReceivingName;
    labEndAddress.font=[UIFont systemFontOfSize:14];
    labEndAddress.textColor=[UIColor grayColor];
    labEndAddress.numberOfLines=2;
    [view addSubview:labEndAddress];
    
    //车牌号码
    UILabel *labNum=[[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width-80, (CGRectGetMaxY(labEnd.frame)-CGRectGetMinY(labStart.frame))+10, 80, 30)];
    labNum.text=model.VehicleNo;
    labNum.font=[UIFont systemFontOfSize:15 weight:20];
    labNum.textColor=skUIColorFromRGB(0x529DE2);
    labNum.textAlignment=1;
    [view addSubview:labNum];
    
    
    [cell.contentView addSubview:view];
    return cell;
}
#pragma mark 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    OrderListModel *model=[_arrCellData objectAtIndex:indexPath.section];
    OrderDetailsDriverViewController *view=[[OrderDetailsDriverViewController alloc] init];
    view.orderListModel=model;
    
    
    
    UIViewController *visibleView=[[SkyerGetVisibleViewController sharedInstance] skyerVisibleViewController];
    [visibleView.navigationController pushViewController:view animated:YES];
    
    
}
-(void)skReloadDataWithData:(NSArray *)data{
    _arrCellData=data;
    [self reloadData];
}




@end
