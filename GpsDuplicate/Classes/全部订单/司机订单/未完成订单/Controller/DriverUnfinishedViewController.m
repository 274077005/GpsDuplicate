//
//  DriverUnfinishedViewController.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/27.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "DriverUnfinishedViewController.h"
#import "TableViewForOrder.h"
@interface DriverUnfinishedViewController ()
@property (nonatomic,copy) TableViewForOrder *tableViewForOrder;
@end

@implementation DriverUnfinishedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _tableViewForOrder=[[TableViewForOrder alloc] init];
    [_tableViewForOrder skInitView:typeUnfinish];
    [self.view addSubview:_tableViewForOrder];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    NSLog(@"%s",__func__);
}

@end
