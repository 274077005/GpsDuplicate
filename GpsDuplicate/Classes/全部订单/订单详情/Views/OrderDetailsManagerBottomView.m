//
//  OrderDetailsManagerBottomView.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/8.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "OrderDetailsManagerBottomView.h"

@implementation OrderDetailsManagerBottomView

-(UIButton *)btnAbnormal{
    if (!_btnAbnormal) {
        //异常上报
        _btnAbnormal=[[UIButton alloc] init];
        [_btnAbnormal setTitleColor:skBaseColor forState:0];
        _btnAbnormal.titleLabel.font=[UIFont systemFontOfSize:15];
        [self.btnAbnormal setTitle:@"非弃土确认" forState:0];
        [self addSubview:_btnAbnormal];
        [_btnAbnormal mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(skScreenWidth, 30));
            make.bottom.mas_equalTo(_btnSure.mas_top).offset(-15);
        }];
        
        @weakify(self);
        [[_btnAbnormal rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self NoSpoil];
        }];
    }
    return _btnAbnormal;
}
-(UIButton *)btnSure{
    if (!_btnSure) {
        _btnSure=[[UIButton alloc] init];
        [_btnSure setBackgroundColor:skBaseColor];
        _btnSure.titleLabel.font=[UIFont systemFontOfSize:14];
        [_btnSure setTitleColor:[UIColor whiteColor] forState:0];
        [_btnSure skSetBoardRadius:3 Width:1 andBorderColor:[UIColor clearColor]];
        [self addSubview:_btnSure];
        [_btnSure mas_makeConstraints:^(MASConstraintMaker *make) {
            
            if ([skUser.UserType integerValue]==2&&[_model.OrderStatus integerValue]==12) {
                make.left.mas_equalTo(50);
                make.right.mas_equalTo(-50);
                make.bottom.mas_equalTo(-30);
                make.height.mas_equalTo(35);
            }else{
                make.left.mas_equalTo(50);
                make.right.mas_equalTo(-50);
                make.bottom.mas_equalTo(-40);
                make.height.mas_equalTo(35);
            }
            
        }];
        //司机操作订单按钮
        @weakify(self)
        [[_btnSure rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self userActionAlert];
        }];
    }
    return _btnSure;
}

/**
 出厂提示
 */
-(void)userActionAlert{
    /*
     1、司机 2、施工单位管理员(具有修改功能) 3、工地理监单位监理员 4、处置场处理员
     OrderStatus
     (待签认-已经签认-和司机相同) (待确认 监理和处理=页面不同 )
     司机:       状态：11已激活、12待出场、15待处置、21已完成
     工地施工单位: 状态：12待确认、15待签认、14已签认
     工地监理单位: 状态：12待确认、15待签认、13已签认
     处置场处理员: 状态：15待确认、21待签认、22已签认
     */
    kWeakSelf(self)
    switch ([skUser.UserType integerValue]) {
        case 2:
        {
            //工地施工单位: 状态：12待确认、15待签认、14已签认
            switch ([_model.OrderStatus integerValue]) {
                case 12:
                {
                    [skClassMethod skAlerView:@"确认并提交运单信息" message:@"提交后不可修改" cancalTitle:@"取消" sureTitle:@"确认" sureBlock:^{
                        [weakself Confirm];
                    }];
                }
                    break;
                case 15:
                {
                    NSString *title=[NSString stringWithFormat:@"车牌号(%@)车辆是否确认出厂",self.model.VehicleNo];
                    [skClassMethod skAlerView:title message:nil cancalTitle:@"取消" sureTitle:@"确定" sureBlock:^{
                        [weakself Confirm];
                    }];
                }
                    break;
                case 14:
                {
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 3:
        {
            //工地监理单位: 状态：12待确认、15待签认、13已签认
            switch ([_model.OrderStatus integerValue]) {
                case 12:
                {
                    [skClassMethod skAlerView:@"确认并提交运单信息" message:@"提交后不可修改" cancalTitle:@"取消" sureTitle:@"确认" sureBlock:^{
                        [weakself Confirm];
                    }];
                }
                    break;
                case 15:
                {
                    NSString *title=[NSString stringWithFormat:@"车牌号(%@)车辆是否确认出厂",self.model.VehicleNo];
                    [skClassMethod skAlerView:title message:nil cancalTitle:@"取消" sureTitle:@"确定" sureBlock:^{
                        [weakself Confirm];
                    }];
                }
                    break;
                case 13:
                {
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 4:
        {
            //处置场处理员: 状态：15待确认、21待签认、22已签认
            switch ([_model.OrderStatus integerValue]) {
                case 15:
                {
                    [skClassMethod skAlerView:@"确认并提交运单信息" message:@"提交后不可修改" cancalTitle:@"取消" sureTitle:@"确认" sureBlock:^{
                        [weakself Confirm];
                    }];
                }
                    break;
                case 21:
                {
                    NSString *title=[NSString stringWithFormat:@"车牌号(%@)车辆是否确认入厂",self.model.VehicleNo];
                    [skClassMethod skAlerView:title message:nil cancalTitle:@"取消" sureTitle:@"确定" sureBlock:^{
                        [weakself Confirm];
                    }];
                }
                    break;
                case 22:
                {
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    
}
#pragma mark - 司机操作订单的接口
-(void)Confirm{
    NSDictionary *parameters=@{@"No":@"Confirm",
                               @"UserID":skUser.UserID,
                               @"OrderID":self.model.OrderID,
                               @"OrderStatus":self.model.OrderStatus,
                               @"UserType":skUser.UserType,
                               };
    
    [[SKNetworking sharedSKNetworking] SKPOST:skURLString parameters:parameters showHUD:YES showErrMsg:YES success:^(id  _Nullable responseObject) {
        
        [self delegateOrderDetailsDataUpdate];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
-(void)delegateOrderDetailsDataUpdate{
    NSLog(@"代理请求更新详情数据");
}
//这个是司机的底部按钮的文字描述
- (void)DriveBtnTitle{
    /*
     1、司机 2、施工单位管理员(具有修改功能) 3、工地理监单位监理员 4、处置场处理员
     OrderStatus
     (待签认-已经签认-和司机相同) (待确认 监理和处理=页面不同 )
     司机:       状态：11已激活、12待出场、15待处置、21已完成
     工地施工单位: 状态：12待确认、15待签认、14已签认
     工地监理单位: 状态：12待确认、15待签认、13已签认
     处置场处理员: 状态：15待确认、21待签认、22已签认
     */
    NSString *stateTitle;
    [self.btnSure setHidden:NO];
    [self.btnAbnormal setHidden:YES];
    
    switch ([skUser.UserType integerValue]) {
        case 2:
        {
            //工地施工单位: 状态：12待确认、15待签认、14已签认
            switch ([_model.OrderStatus integerValue]) {
                case 12:
                {
                    stateTitle=@"提交运单信息";
                    [self.btnAbnormal setHidden:NO];
                }
                    break;
                case 15:
                {
                    stateTitle=@"出厂确认";
                }
                    break;
                case 14:
                {
                    [self.btnSure setHidden:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 3:
        {
            //工地监理单位: 状态：12待确认、15待签认、13已签认
            switch ([_model.OrderStatus integerValue]) {
                case 12:
                {
                    stateTitle=@"提交运单信息";
                }
                    break;
                case 15:
                {
                    stateTitle=@"出厂确认";
                }
                    break;
                case 13:
                {
                    [self.btnSure setHidden:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 4:
        {
            //处置场处理员: 状态：15待确认、21待签认、22已签认
            switch ([_model.OrderStatus integerValue]) {
                case 15:
                {
                    stateTitle=@"确认运单信息";
                }
                    break;
                case 21:
                {
                    stateTitle=@"入厂确认";
                }
                    break;
                case 22:
                {
                    [self.btnSure setHidden:YES];
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    
    [self.btnSure setTitle:stateTitle forState:0];
}


-(void)updateUI{
    //1、司机 2、施工单位管理员(具有修改功能) 3、工地理监单位监理员 4、处置场处理员
    [self DriveBtnTitle];
    
}

#pragma mark - 非弃土运单接口
-(void)NoSpoil{
    
    NSDictionary *parameters=@{
                               @"OrderID":_model.OrderID,
                               @"UserID":skUser.UserID
                               };
    
    
    [[SKNetworking sharedSKNetworking] SKPOST:skURLWithPort(@"NoSpoil") parameters:parameters showHUD:YES showErrMsg:YES success:^(id  _Nullable responseObject) {
        
        UIViewController *view=[[SkyerGetVisibleViewController sharedSkyerGetVisibleViewController] skyerVisibleViewController];
        [view.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
