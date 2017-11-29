//
//  DriverFinishViewController.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/27.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "DriverFinishViewController.h"
#import "TableViewForOrder.h"

@interface DriverFinishViewController ()
@property (nonatomic,copy) TableViewForOrder *tableViewForOrder;
@end

@implementation DriverFinishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _tableViewForOrder=[[TableViewForOrder alloc] init];
    [_tableViewForOrder skInitView];
    [self.view addSubview:_tableViewForOrder];
    
}
-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"%s",__func__);
}
@end
