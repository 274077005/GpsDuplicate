//
//  TableViewForOrder.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/28.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TableViewForOrder : UITableView <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) id cellData;

typedef enum : NSUInteger {
    typeFinish = 0,                   //已完成
    typeUnfinish,                     //未完成
    typeSignAlread,                   //已经签认
    typeSureWaiting,                  //等待确认
    typeSignWaiting,                  //等待签认
    
} orderType;
@property (nonatomic,assign) orderType orderType;
/**
 初始化界面元素
 */
-(void)skInitView:(orderType)type;
@end
