//
//  OrderDetailsDriverTableView.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/2.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailsModel.h"
//这个是司机端的订单详情

@interface OrderDetailsDriverTableView : UITableView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) OrderDetailsModel *model;


@end
