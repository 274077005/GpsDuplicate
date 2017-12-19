//
//  MessageTableView.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/19.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageTableView : UITableView  <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *arrData;
@end
