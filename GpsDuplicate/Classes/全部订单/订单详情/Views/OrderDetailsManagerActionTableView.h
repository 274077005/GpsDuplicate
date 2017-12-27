//
//  OrderDetailsManagerActionTableView.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/7.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailsModel.h"
#import "WasteModel.h"
#import "ReceivingModel.h"
//这个是监理可以设置废物物种类和装载量还有终点位置的
@interface OrderDetailsManagerActionTableView : UITableView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITextField *textLoading;
@property (nonatomic,strong) WasteModel *wasteModel;
@property (nonatomic,strong) ReceivingModel *receivingModel;
@property (nonatomic,strong) OrderDetailsModel *model;


-(void)btnWaste:(CGRect)frame;
-(void)btnReceiving:(CGRect)frame;

@end
