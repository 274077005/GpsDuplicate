//
//  PopMenuViewController.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/14.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopMenuViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) CGRect viewFrame;

@property (nonatomic,strong) NSArray *arrData;//需要显示的数据

@property (nonatomic,strong) UITableView *tableView;


@property (nonatomic,strong) void (^skIndexSelect)(NSInteger index);


/*
 PopMenuViewController *view=[[PopMenuViewController alloc] init];
 UIViewController *vc=[[SkyerGetVisibleViewController sharedInstance] skyerVisibleViewController];
 view.skIndexSelect = ^(NSInteger index) {
 NSLog(@"点击了哪一行%ld",index);
 };
 view.viewFrame=_btnLogin.frame;
 //设置模式展示风格
 [view setModalPresentationStyle:UIModalPresentationOverFullScreen];
 //必要配置
 vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
 vc.providesPresentationContextTransitionStyle = YES;
 vc.definesPresentationContext = YES;
 [vc presentViewController:view animated:YES completion:nil];
 */
@end
