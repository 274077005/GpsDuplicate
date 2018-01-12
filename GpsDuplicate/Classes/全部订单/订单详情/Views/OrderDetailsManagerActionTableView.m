//
//  OrderDetailsManagerActionTableView.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/7.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "OrderDetailsManagerActionTableView.h"
#import "orderStateColor.h"

@implementation OrderDetailsManagerActionTableView

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
            return 180;
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
    static NSString *cellIdentifier = @"OrderDetailsManagerActionTableView";
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
                make.top.mas_equalTo(80);
            }];
            //状态按钮
            UIButton *btnState=[[UIButton alloc] init];
            [cell.contentView addSubview:btnState];
            btnState.titleLabel.font=[UIFont systemFontOfSize:15];
            [btnState setTitle:_model.StatusName forState:UIControlStateNormal];
            [btnState setBackgroundColor:[orderStateColor skOrderState:_model.OrderStatus]];
            [btnState mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(60, 26));
                make.top.mas_equalTo(27);
                make.right.mas_equalTo(-10);
            }];
            //订单编号
            UILabel *labOrder=[[UILabel alloc] init];
            labOrder.text=[NSString stringWithFormat:@"运单编号:%@",_model.OrderID];
            [labOrder setTextColor:[UIColor grayColor]];
            labOrder.font=[UIFont systemFontOfSize:15];
            [cell.contentView addSubview:labOrder];
            [labOrder mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(btnState.mas_top).offset(-15);
                make.height.mas_equalTo(btnState.mas_height);
                make.left.mas_equalTo(20);
                make.right.mas_equalTo(btnState.mas_left).offset(10);
            }];
            //运出去的时间
            UILabel *labOutTime=[[UILabel alloc] init];
            labOutTime.text=[NSString stringWithFormat:@"出场时间:%@",_model.OutTime];
            labOutTime.font=[UIFont systemFontOfSize:15];
            labOutTime.textColor=[UIColor grayColor];
            [cell.contentView addSubview:labOutTime];
            [labOutTime mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(btnState.mas_top).offset(15);
                make.height.mas_equalTo(btnState.mas_height);
                make.left.mas_equalTo(labOrder.mas_left);
                make.right.mas_equalTo(btnState.mas_left).offset(10);
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
            //废弃物种类
            UILabel *labTrashType=[[UILabel alloc] init];
            [cell.contentView addSubview:labTrashType];
            NSString *TrashTypeTitle=@"废弃物种类:";
            CGSize TrashTypeTitleSize=[TrashTypeTitle skTitleSize:TrashTypeTitle labWidth:skScreenWidth fontOfSize:15];
            labTrashType.text=TrashTypeTitle;
            labTrashType.font=[UIFont systemFontOfSize:15];
            labTrashType.textColor=[UIColor grayColor];
            
            [labTrashType mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(labOrder.mas_left);
                make.size.mas_equalTo(CGSizeMake(TrashTypeTitleSize.width+10, 20));
                make.bottom.mas_equalTo(labNum.mas_centerY).offset(-10);
            }];
            //选择废弃物种类
            UIButton *btnSelectTrashType=[[UIButton alloc] init];
            [cell.contentView addSubview:btnSelectTrashType];
            [btnSelectTrashType skSetBoardRadius:2 Width:1 andBorderColor:[UIColor lightGrayColor]];
            btnSelectTrashType.titleLabel.font=[UIFont systemFontOfSize:12];
            [btnSelectTrashType setTitleColor:[UIColor lightGrayColor] forState:0];
    
            [btnSelectTrashType setTitle:_wasteModel.WasteName forState:0];
            [btnSelectTrashType mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(100);
                make.top.mas_equalTo(labTrashType.mas_top);
                make.bottom.mas_equalTo(labTrashType.mas_bottom);
                make.left.mas_equalTo(labTrashType.mas_right);
            }];
            @weakify(self);
            [[btnSelectTrashType rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
                @strongify(self);
                [self btnWaste:btnSelectTrashType.frame];
            }];
            //装载量
            UILabel *labLoading=[[UILabel alloc] init];
            [cell.contentView addSubview:labLoading];
            labLoading.text=@"装载量:";
            labLoading.font=[UIFont systemFontOfSize:15];
            labLoading.textColor=[UIColor grayColor];
            labLoading.textAlignment=2;
            [labLoading mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(labOrder.mas_left);
                make.right.mas_equalTo(labTrashType.mas_right).offset(-10);
                make.height.mas_equalTo(20);
                make.top.mas_equalTo(labNum.mas_centerY).offset(10);
            }];
            
            //一个填写装载量的文本框
            _textLoading=[[UITextField alloc] init];
            [_textLoading skSetBoardRadius:2 Width:1 andBorderColor:[UIColor lightGrayColor]];
            [cell.contentView addSubview:_textLoading];
            _textLoading.textAlignment=1;
            _textLoading.text=_model.Loading;
            _textLoading.font=[UIFont systemFontOfSize:13];
            _textLoading.keyboardType=UIKeyboardTypeNumberPad;
            
            [_textLoading mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(btnSelectTrashType.mas_left);
                make.top.mas_equalTo(labLoading.mas_top);
                make.bottom.mas_equalTo(labLoading.mas_bottom);
                make.width.mas_equalTo(50);
            }];
            [RACObserve(self.textLoading, text) subscribeNext:^(id  _Nullable x) {
                _textLoadingCount=x;
            }];
            //继续完善
            UILabel *labLoadingwei=[[UILabel alloc] init];
            [cell.contentView addSubview:labLoadingwei];
            labLoadingwei.text=@"立方(每年/次)";
            labLoadingwei.font=[UIFont systemFontOfSize:15];
            labLoadingwei.textColor=[UIColor grayColor];
            labLoadingwei.textAlignment=0;
            [labLoadingwei mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_textLoading.mas_right).offset(5);
                make.right.mas_equalTo(-20);
                make.height.mas_equalTo(20);
                make.top.mas_equalTo(labLoading.mas_top);
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
            //终点地址选择
            UIButton *btnEndAddress=[[UIButton alloc] init];
            [cell.contentView addSubview:btnEndAddress];
            [btnEndAddress skSetBoardRadius:2 Width:1 andBorderColor:[UIColor lightGrayColor]];
            btnEndAddress.titleLabel.font=[UIFont systemFontOfSize:12];
            [btnEndAddress setTitleColor:[UIColor lightGrayColor] forState:0];
            [btnEndAddress setTitle:_receivingModel.ReceivingName forState:0];
            [btnEndAddress mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(150);
                make.top.mas_equalTo(labEnd.mas_top).offset(5);
                make.bottom.mas_equalTo(labEnd.mas_bottom).offset(-5);
                make.left.mas_equalTo(labEnd.mas_right).offset(10);
            }];
            @weakify(self);
            [[btnEndAddress rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
                @strongify(self);
                [self btnReceiving:btnEndAddress.frame];
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
-(void)btnWaste:(CGRect)frame{
    NSLog(@"设置废弃物种类");
}
-(void)btnReceiving:(CGRect)frame{
    NSLog(@"设置废弃物种类");
}
@end
