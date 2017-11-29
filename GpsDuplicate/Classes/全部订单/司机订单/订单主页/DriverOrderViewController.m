//
//  DriverDrderViewController.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/27.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "DriverOrderViewController.h"
#import "DriverFinishViewController.h"
#import "DriverUnfinishedViewController.h"
#import "ZWTopSelectButton.h"
#import "ZWTopSelectVcView.h"

@interface DriverOrderViewController () <ZWTopSelectVcViewDelegate>
@property (nonatomic, weak) ZWTopSelectVcView *topSelectVcView;


@end

@implementation DriverOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}


-(void)initUI{
    self.view.backgroundColor=[UIColor whiteColor];
    //第一步：初始化ZWTopSelectVcView，把其加入当前控制器view中
    ZWTopSelectVcView *topSelectVcView=[[ZWTopSelectVcView alloc]init];
    
    topSelectVcView.frame=CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:topSelectVcView];
    self.topSelectVcView=topSelectVcView;
    //第二步：设置ZWTopSelectVcView的代理
    self.topSelectVcView.delegate=self;
    //第三步： 开始ZWTopSelectVcViewUI绘制,必须实现！
    [self.topSelectVcView setupZWTopSelectVcViewUI];
    [self.topSelectVcView setAnimationType:Push];
    self.topSelectVcView.isCloseSwipeGesture=NO;//关闭左右滑动的按钮
    self.topSelectVcView.topViewFirstbtn.selectedColor=[UIColor blueColor];
    self.topSelectVcView.topViewFirstbtn.notSelectedColor=[UIColor blackColor];
    self.topSelectVcView.topViewFirstbtn.viewLine.backgroundColor=[UIColor lightGrayColor];
}
#pragma mark - ZWTopSelectVcViewDelegate
//只要一步且必须实现：传入您的各种控制器，用可变数组封装传入，就会动态的生成，默认最多能传入九个控制器
//初始化设置
-(NSMutableArray *)totalControllerInZWTopSelectVcView:(ZWTopSelectVcView *)topSelectVcView
{
    
    NSMutableArray *controllerMutableArr=[NSMutableArray array];
    
    //完成订单
    DriverFinishViewController *DriverFinishView= [[DriverFinishViewController alloc]init];
    DriverFinishView.title=@"完成订单";
    [controllerMutableArr addObject:DriverFinishView];
    //未完成订单
    DriverUnfinishedViewController *DriverUnfinishedView= [[DriverUnfinishedViewController alloc]init];
    DriverUnfinishedView.title=@"未完成订单";
    [controllerMutableArr addObject:DriverUnfinishedView];
    
    return controllerMutableArr;
    
}

#pragma mark - ZWTopSelectVcViewDelegate
//单个设置顶部标题栏的优先级>初始化设置顶部标题栏>统一设置顶部标题栏的优先级
//统一设置 ：通过totalTopBtns修改顶部控件样式


//不修改,则为默认
-(void)totalTopZWTopSelectButton:(ZWTopSelectButton *)totalTopBtns IntopSelectVcView:(ZWTopSelectVcView *)topSelectVcView
{
    // 优先级最低
    totalTopBtns.selectedColor=[UIColor blueColor];
    totalTopBtns.notSelectedColor=[UIColor blackColor];
    
    
}
@end
