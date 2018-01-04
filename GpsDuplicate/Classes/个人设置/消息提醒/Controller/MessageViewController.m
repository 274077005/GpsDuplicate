//
//  MessageViewController.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/5.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageModel.h"
#import "MessageTableView.h"

@interface MessageViewController ()
@property (nonatomic,strong) MessageTableView *tableView;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"消息提醒";
    [self GetMessage];
}


-(UITableView *)tableView{
    if (nil==_tableView) {
        _tableView =[[MessageTableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

/**
 获取验证码
 */
-(void)GetMessage{
    
    NSDictionary *parameters=@{
                               @"UserID":skUser.UserID
                               };
    
    
    [[SkNetwork sharedSkNetwork] SKPOST:skURLWithPort(@"GetMessage") parameters:parameters showHUD:YES showErrMsg:YES success:^(id  _Nullable responseObject) {
        [self GetMessageModel:responseObject];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

-(void)GetMessageModel:(id)response{
    NSArray *arrData=skContent(response);
    
    NSMutableArray *arrList=[[NSMutableArray alloc] init];
    
    for (int i =0; i<arrData.count; ++i) {
        NSDictionary *oneDic=[arrData objectAtIndex:i];
        MessageModel *model=[MessageModel mj_objectWithKeyValues:oneDic];
        [arrList addObject:model];
    }
    if (arrList.count>0) {
        self.tableView.arrData=arrList;
        [self.tableView reloadData];
    }
}


@end
