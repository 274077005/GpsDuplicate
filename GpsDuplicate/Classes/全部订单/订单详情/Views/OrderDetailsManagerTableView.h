//
//  OrderDetailsManagerTableView.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/7.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailsModel.h"
//监理界面
@interface OrderDetailsManagerTableView : UITableView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) OrderDetailsModel *model;

@end
