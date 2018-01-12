//
//  OrderDetailsDriverTableView.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/2.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "OrderDetailsDriverTableView.h"
#import "orderStateColor.h"


@implementation OrderDetailsDriverTableView



-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self=[super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor=skLineColor;
        self.delegate=self;
        self.dataSource=self;
    }
    return self;
}



#pragma mark - cell的代理
#pragma mark cell 的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 150;
            break;
        case 1:
            return 150;
            break;
        case 2:
            return 180;
            break;
        default:
            break;
    }
    return 100;
    
}
#pragma mark section下得cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 8;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, 8)];
    view.backgroundColor=skLineColor;
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

#pragma mark 绘制一个cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    static NSString *cellIdentifier = @"OrderDetailsDriverTableView";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    for(UIView *view in cell.contentView.subviews){
        
        [view removeFromSuperview];
        
    }
    switch (indexPath.section) {
        case 0:
            {
                //一条分割线
                UILabel *labLine=[UILabel new];
                labLine.backgroundColor=skLineColor;
                [cell.contentView addSubview:labLine];
                [labLine mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(skScreenWidth, 1));
                    make.top.mas_equalTo(50);
                }];
                //状态按钮
                UIButton *btnState=[[UIButton alloc] init];
                [cell.contentView addSubview:btnState];
                btnState.titleLabel.font=[UIFont systemFontOfSize:15];
                [btnState setTitle:_model.StatusName forState:UIControlStateNormal];
                [btnState setBackgroundColor:[orderStateColor skOrderState:_model.OrderStatus]];
                [btnState mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(60, 26));
                    make.top.mas_equalTo(12);
                    make.right.mas_equalTo(-10);
                }];
                //订单编号
                UILabel *labOrder=[[UILabel alloc] init];
                labOrder.text=[NSString stringWithFormat:@"运单编号:%@",_model.OrderID];
                [labOrder setTextColor:[UIColor grayColor]];
                labOrder.font=[UIFont systemFontOfSize:14];
                [cell.contentView addSubview:labOrder];
                [labOrder mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(btnState.mas_top);
                    make.height.mas_equalTo(btnState.mas_height);
                    make.left.mas_equalTo(20);
                    make.right.mas_equalTo(btnState.mas_left).offset(10);
                }];
                
                //运出去的时间
                UILabel *labOutTime=[[UILabel alloc] init];
                [cell.contentView addSubview:labOutTime];
                labOutTime.text=[NSString stringWithFormat:@"出场时间:%@",_model.OutTime];
                labOutTime.font=[UIFont systemFontOfSize:15];
                labOutTime.textColor=[UIColor grayColor];
                [labOutTime mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(skScreenWidth-50, 30));
                    make.top.mas_equalTo(labLine.mas_top).offset(15);
                    make.left.mas_equalTo(labOrder.mas_left);
                }];
                
                //装载量
                UILabel *labAmount=[[UILabel alloc] init] ;
                [cell.contentView addSubview:labAmount];
                
                labAmount.text=[NSString stringWithFormat:@"装载量:%@立方/次",_model.Loading];
                labAmount.font=[UIFont systemFontOfSize:15];
                labAmount.textColor=[UIColor grayColor];
                [labAmount mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(skScreenWidth-150, 30));
                    make.left.mas_equalTo(labOutTime.mas_left);
                    make.top.mas_equalTo(labOutTime.mas_top).offset(40);
                }];
                
                //车牌号
                UILabel *labNum=[[UILabel alloc] init];
                labNum.text=_model.VehicleNo;
                labNum.textAlignment=2;
                labNum.font=[UIFont systemFontOfSize:17 weight:20];
                labNum.textColor=skUIColorFromRGB(0x529DE2);
                [cell.contentView addSubview:labNum];
                [labNum mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(100);
                    make.top.mas_equalTo(labLine.mas_bottom).offset(20);
                    make.bottom.mas_equalTo(-20);
                    make.right.mas_equalTo(-10);
                }];
                
            }
            break;
        case 1:
        {
            //路线
            UILabel *labRoute=[[UILabel alloc] init];
            [cell.contentView addSubview:labRoute];
            labRoute.font=[UIFont systemFontOfSize:16];
            labRoute.text=@"运输路线";
            [labRoute mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(200, 20));
                make.top.left.mas_equalTo(10);
                
            }];
            
            //一条分割线
            UILabel *labLine=[[UILabel alloc] init];
            [cell.contentView addSubview:labLine];
            labLine.backgroundColor=skLineColor;
            [labLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(skScreenWidth, 1));
                make.top.mas_equalTo(labRoute.mas_bottom).offset(10);
            }];
            //起点
            UILabel *labStart=[[UILabel alloc] init];
            [cell.contentView addSubview:labStart];
            labStart.text=@"起";
            labStart.backgroundColor=skBaseColor;
            [labStart skSetBoardRadius:15 Width:1 andBorderColor:[UIColor clearColor]];
            labStart.textAlignment=1;
            labStart.textColor=[UIColor whiteColor];
            [labStart mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(30, 30));
                make.top.mas_equalTo(labLine.mas_bottom).offset(15);
                make.left.mas_equalTo(20);
            }];
            
            //终点
            UILabel *labEnd=[[UILabel alloc] init];
            [cell.contentView addSubview:labEnd];
            labEnd.text=@"终";
            labEnd.backgroundColor=skUIColorFromRGB(0x529DE2);
            [labEnd skSetBoardRadius:15 Width:1 andBorderColor:[UIColor clearColor]];
            labEnd.textAlignment=1;
            labEnd.textColor=[UIColor whiteColor];
            [labEnd mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(30, 30));
                make.left.mas_equalTo(20);
                make.bottom.mas_equalTo(-15);
            }];
            //连接线
            
            UILabel *labLinese=[[UILabel alloc] init];
            [cell.contentView addSubview:labLinese];
            [labLinese setBackgroundColor:[UIColor lightGrayColor]];
            [labLinese mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(labStart.mas_centerX);
                make.width.mas_equalTo(4);
                make.top.mas_equalTo(labStart.mas_bottom);
                make.bottom.mas_equalTo(labEnd.mas_top);
            }];
            //起点地址
            UILabel *labStartAddress=[[UILabel alloc] init];
            [cell.contentView addSubview:labStartAddress];
            labStartAddress.text=_model.ProjectAddress;
            labStartAddress.numberOfLines=2;
            labStartAddress.font=[UIFont systemFontOfSize:13];
            labStartAddress.textColor=[UIColor grayColor];
            [labStartAddress mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(labStart.mas_height);
                make.left.mas_equalTo(labStart.mas_right).offset(10);
                make.top.mas_equalTo(labStart.mas_top);
                make.right.mas_equalTo(-10);
            }];
            //终点地址
            UILabel *labEndAddress=[[UILabel alloc] init];
            [cell.contentView addSubview:labEndAddress];
            labEndAddress.text=_model.ReceivingName;
            labEndAddress.numberOfLines=2;
            labEndAddress.font=[UIFont systemFontOfSize:13];
            labEndAddress.textColor=[UIColor grayColor];
            [labEndAddress mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(labEnd.mas_height);
                make.left.mas_equalTo(labEnd.mas_right).offset(10);
                make.top.mas_equalTo(labEnd.mas_top);
                make.right.mas_equalTo(-10);
            }];
            
            
        }
            break;
        case 2:
        {
            //路线
            UILabel *labRoute=[[UILabel alloc] init];
            [cell.contentView addSubview:labRoute];
            labRoute.font=[UIFont systemFontOfSize:16];
            labRoute.text=@"工程信息";
            [labRoute mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(200, 20));
                make.top.left.mas_equalTo(10);
                
            }];
            //一条分割线
            UILabel *labLine=[[UILabel alloc] init];
            [cell.contentView addSubview:labLine];
            labLine.backgroundColor=skLineColor;
            [labLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(skScreenWidth, 1));
                make.top.mas_equalTo(labRoute.mas_bottom).offset(10);
            }];
            
            NSString *ProjectName=[NSString stringWithFormat:@"工程名称:%@",_model.ProjectName];
            NSString *ProjectAddress=[NSString stringWithFormat:@"工程地址:%@",_model.ProjectAddress];
            NSString *BuildUnit=[NSString stringWithFormat:@"建设单位:%@",_model.BuildUnit];
            NSString *SupervisorUnit=[NSString stringWithFormat:@"监理单位;%@",_model.SupervisorUnit];
            NSString *ConstructionUnit=[NSString stringWithFormat:@"施工单位:%@",_model.ConstructionUnit];
            NSArray *arrName=@[ProjectName,ProjectAddress,BuildUnit,SupervisorUnit,ConstructionUnit,ConstructionUnit];
            
            
            for (int i =0; i<5; ++i) {
                UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(20, 50+(i*25), skScreenWidth-40, 20)];
                lab.text=[arrName objectAtIndex:i];
                lab.textColor=[UIColor grayColor];
                lab.font=[UIFont systemFontOfSize:14];
                [cell.contentView addSubview:lab];
            }
            
            
        }
            break;
        case 3:{
            cell.contentView.backgroundColor=skLineColor;
            
            //异常上报
            UIButton *btnAbnormal=[[UIButton alloc] init];
            [btnAbnormal setTitle:@"异常上报" forState:0];
            [btnAbnormal setTitleColor:skBaseColor forState:0];
            [cell.contentView addSubview:btnAbnormal];
            [btnAbnormal mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(skScreenWidth, 30));
                make.top.mas_equalTo(10);
            }];
            
            //确认运单信息
            UIButton *btnSure=[[UIButton alloc] init];
            [btnSure setBackgroundColor:skBaseColor];
            [btnSure setTitle:@"确认运单信息" forState:0];
            btnSure.titleLabel.font=[UIFont systemFontOfSize:14];
            [btnSure setTitleColor:[UIColor whiteColor] forState:0];
            [btnSure skSetBoardRadius:3 Width:1 andBorderColor:[UIColor clearColor]];
            [cell.contentView addSubview:btnSure];
            [btnSure mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(50);
                make.right.mas_equalTo(-50);
                make.top.mas_equalTo(btnAbnormal.mas_bottom).offset(10);
                make.height.mas_equalTo(30);
                
            }];
            
        }
            
        default:
            break;
    }
    
    
    
    
    return cell;
}
#pragma mark 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
