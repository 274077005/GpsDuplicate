//
//  AboutUsViewController.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/5.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "AboutUsViewController.h"


@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self AboutUs];
}

#pragma mark - cell的代理
#pragma mark cell 的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
#pragma mark section下得cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 2;
            break;
            
        default:
            break;
    }
    return 1;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, 0)];
    view.backgroundColor=skLineColor;
    return view;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, 10)];
    view.backgroundColor=skLineColor;
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

#pragma mark 绘制一个cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    static NSString *cellIdentifier = @"AboutUsViewController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    UILabel *labTitle=[[UILabel alloc] init];
    [cell.contentView addSubview:labTitle];
    labTitle.font=[UIFont systemFontOfSize:14];
    [labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 44));
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(0);
    }];
    
    UILabel *labDes=[[UILabel alloc] init];
    [cell.contentView addSubview:labDes];
    labDes.textAlignment=2;
    labDes.numberOfLines=2;
    labDes.textColor=[UIColor grayColor];
    labDes.font=[UIFont systemFontOfSize:14];
    [labDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(labTitle.mas_right);
        make.bottom.mas_equalTo(0);
    }];
    
    switch (indexPath.section) {
        case 0:
        {
            labTitle.text=@"当前版本";
            labDes.text=[NSString stringWithFormat:@"V%@",kAppVersion];
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                
                case 0:
                {
                    labTitle.text=@"官网";
                    labDes.text=_model.Website;
                }
                    break;
                case 1:
                {
                    labTitle.text=@"服务电话";
                    labDes.text=_model.Tel;
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                    
                case 0:
                {
                    labTitle.text=@"公司";
                    labDes.text=_model.Company;
                }
                    break;
                case 1:
                {
                    labTitle.text=@"地址";
                    labDes.text=_model.Address;
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    return cell;
}
#pragma mark 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)AboutUs{
    NSDictionary *parameters=@{
                               @"No":@"AboutUs"
                               };
    
    
    [SkNetwork.sharedSkNetwork SKPOST:skURLString parameters:parameters showHUD:YES showErrMsg:YES success:^(id  _Nullable responseObject) {
        _model=[AboutUsModel mj_objectWithKeyValues:skContent(responseObject)];
        _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [self.view addSubview:_tableView];
    } failure:^(NSError * _Nullable error) {
        
    }];
}


@end
