//
//  OrderDetailsManagerActionTableView.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/7.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailsModel.h"
//这个是监理可以设置废物物种类和装载量还有终点位置的
@interface OrderDetailsManagerActionTableView : UITableView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) OrderDetailsModel *model;

@end
