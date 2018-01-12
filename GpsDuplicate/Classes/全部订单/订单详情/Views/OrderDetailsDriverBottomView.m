//
//  OrderDetailsDriverBottomView.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/7.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "OrderDetailsDriverBottomView.h"
#import "AbnormalViewController.h"

@implementation OrderDetailsDriverBottomView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


-(UIButton *)btnAbnormal{
    if (!_btnAbnormal) {
        //异常上报
        _btnAbnormal=[[UIButton alloc] init];
        [_btnAbnormal setTitleColor:skBaseColor forState:0];
        _btnAbnormal.titleLabel.font=[UIFont systemFontOfSize:15];
        [self addSubview:_btnAbnormal];
        [_btnAbnormal mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(skScreenWidth, 30));
            make.bottom.mas_equalTo(_btnSure.mas_top).offset(-15);
        }];
        
        [[_btnAbnormal rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            UIStoryboard *Main=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            AbnormalViewController *view=[Main instantiateViewControllerWithIdentifier:@"AbnormalViewController"];
            view.OrderID=_model.OrderID;
            
            [skVSView.navigationController pushViewController:view animated:YES];
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
            make.left.mas_equalTo(50);
            make.right.mas_equalTo(-50);
            make.bottom.mas_equalTo(-30);
            make.height.mas_equalTo(35);
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
 出场提示
 */
-(void)userActionAlert{
    /*
     1、司机 2、施工单位管理员(具有修改功能) 3、工地理监单位监理员 4、处置场处理员
     OrderStatus
     (待签认-已经签认-和司机相同) (待确认 监理和处理=页面不同 )
     司机:       状态：11已激活、12待出场、15待处置、21已完成
     工地施工单位: 状态：12待确认、17待签认、14已签认
     工地监理单位: 状态：12待确认、17待签认、13已签认
     处置场处理员: 状态：15待确认、17待签认、22已签认
     */
    kWeakSelf(self)
    switch ([_model.OrderStatus integerValue]) {
        case 11:
        {
            [SkClassMethod skAlerView:@"确认并提交运单" message:@"提交后不可修改" cancalTitle:@"取消" sureTitle:@"确定" sureBlock:^{
                [weakself delegateBtnSure];
            }];
            
        }
            break;
        case 12:
            
        {
            NSString *title=[NSString stringWithFormat:@"车牌号(%@)车辆是否确认出场",self.model.VehicleNo];
            
            [SkClassMethod skAlerView:title message:nil cancalTitle:@"取消" sureTitle:@"确定" sureBlock:^{
                [weakself delegateBtnSure];
            }];
        }
            break;
        case 15:
        {
            NSString *title=[NSString stringWithFormat:@"确认车辆是(%@)已进入处置场",self.model.VehicleNo];
            
            [SkClassMethod skAlerView:title message:nil cancalTitle:@"取消" sureTitle:@"确定" sureBlock:^{
                [weakself delegateBtnSure];
            }];
        }
            break;
        case 21:
        {
        }
            break;
            
        default:
            break;
    }
    
}
#pragma mark - 司机操作订单的接口

-(void)delegateBtnSure{
    NSLog(@"详情操作点击事件");
}
//这个是司机的底部按钮的文字描述
- (void)DriveBtnTitle{
    //11待确认、12待出场、15待处置、21已完成
    NSString *stateInfo;
    [self.btnSure setHidden:NO];
    [self.btnAbnormal setHidden:NO];
    [self.btnAbnormal setTitle:@"异常处理" forState:0];
    switch ([_model.OrderStatus integerValue]) {
        case 11:
        {
            stateInfo=@"确认运单信息";
        }
            break;
        case 12:
            
        {
            stateInfo=@"出场确认";
        }
            break;
        case 15:
        {
            stateInfo=@"确认处理";
        }
            break;
        case 21:
        {
            stateInfo=@"已完成";
            [self.btnSure setHidden:YES];
            [self.btnAbnormal setHidden:YES];
        }
            break;
            
        default:
            break;
    }
    [self.btnSure setTitle:stateInfo forState:0];
}


-(void)updateUI{
    //1、司机 2、施工单位管理员(具有修改功能) 3、工地理监单位监理员 4、处置场处理员
    [self DriveBtnTitle];
    
}

@end
