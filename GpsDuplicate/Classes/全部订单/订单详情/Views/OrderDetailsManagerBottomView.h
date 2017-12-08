//
//  OrderDetailsManagerBottomView.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/8.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailsModel.h"

@interface OrderDetailsManagerBottomView : UIView
@property (nonatomic,strong) OrderDetailsModel *model;
@property (nonatomic,strong) UIButton *btnSure;
@property (nonatomic,strong) UIButton *btnAbnormal;

//一个代理给详情界面,表示已经对订单进行了操作
-(void)delegateOrderDetailsDataUpdate;

-(void)updateUI;
@end
