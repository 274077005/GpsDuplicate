//
//  AboutUsViewController.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/5.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "SkyerBaseViewController.h"
#import "AboutUsModel.h"

@interface AboutUsViewController : SkyerBaseViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) AboutUsModel *model;
@end
