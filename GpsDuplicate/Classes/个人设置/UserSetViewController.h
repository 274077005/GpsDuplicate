//
//  UserSetViewController.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/1.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserSetViewController : SkyerBaseViewController <UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@end
