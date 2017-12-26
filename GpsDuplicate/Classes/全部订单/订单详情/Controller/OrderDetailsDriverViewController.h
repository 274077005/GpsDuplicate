//
//  OrderDetailsDriverViewController.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/2.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"
#import "WasteModel.h"
#import "ReceivingModel.h"

@interface OrderDetailsDriverViewController : SkyerBaseViewController
@property (nonatomic,strong) OrderListModel *orderListModel;
@property (nonatomic,strong) WasteModel *wasteModel;
@property (nonatomic,strong) ReceivingModel *receivingModel;
@property (nonatomic,strong) NSArray *arrWasteModel;
@property (nonatomic,strong) NSArray *arrReceivingModel;



@end
