//
//  UserSetViewController.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/1.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "UserSetViewController.h"
#import "MessageViewController.h"
#import "ResetPasswordViewController.h"
#import "AboutUsViewController.h"
#define skCellHeidth 120


@interface UserSetViewController ()

@end

@implementation UserSetViewController

- (void)initUI {
    self.title=@"设置";
    
    [self useMethodToFindBlackLineAndHind];
    
    UITableView *tableview=[[UITableView alloc] initWithFrame:self.view.bounds];
    tableview.backgroundColor=skLineColor;
    self.tableView=tableview;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    [self.view addSubview:self.tableView];
}
-(void)useMethodToFindBlackLineAndHind
{
    UIImageView* blackLineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    //隐藏黑线（在viewWillAppear时隐藏，在viewWillDisappear时显示）
    blackLineImageView.hidden = YES;
}
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0)
    {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setTranslucent:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setTranslucent:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}
#pragma mark - cell的代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section>0) {
        return 5;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, 5)];
    view.backgroundColor=skLineColor;
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, 0)];
    view.backgroundColor=skBaseColor;
    return view;
}


#pragma mark cell 的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return skCellHeidth;
            break;
            
        default:
            return 44;
            break;
    }
}
#pragma mark section下得cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count=0;
    switch (section) {
        case 0:
            count=1;
            break;
        case 1:
            count=1;
            break;
        case 2:
            count=2;
            break;
        case 3:
            count=1;
            break;
        default:
            break;
    }
    
    return count;
}
#pragma mark 绘制一个cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    static NSString *cellIdentifier = @"UserSetViewController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    for(UIView *view in cell.contentView.subviews){
        
        [view removeFromSuperview];
        
    }
    
    switch (indexPath.section) {
        case 0:
            {
                cell.backgroundColor=skBaseColor;
                
                UIImageView *imageUser=[[UIImageView alloc] initWithFrame:CGRectMake(20, 30, 60, 60)];
                imageUser.image=[UIImage imageNamed:@"icon_user"];
                [cell.contentView addSubview:imageUser];
                //用户名
                UILabel *labUser=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageUser.frame)+10, 35, 200, 20)];
                
                NSString *RealName=skUser.RealName;
                NSString *VehicleNo=skUser.VehicleNo;
                
                labUser.text=[NSString stringWithFormat:@"%@(%@)",RealName,VehicleNo];
                labUser.textColor=[UIColor whiteColor];
                [cell.contentView addSubview:labUser];
                
                
                
                //所属公司
                UILabel *labCompany=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageUser.frame)+10, 60, SCREEN_WIDTH-CGRectGetMaxX(imageUser.frame)-20, 40)];
                labCompany.numberOfLines=2;
                NSString *EnterName=skUser.EnterName;
                labCompany.text=[NSString stringWithFormat:@"所属公司:%@",EnterName];
                labCompany.textColor=[UIColor whiteColor];
                labCompany.font=[UIFont systemFontOfSize:14];
                [cell.contentView addSubview:labCompany];
                
            }
            break;
        case 1://消息提醒
        {
            cell.textLabel.text=@"消息提醒";
            cell.textLabel.font=[UIFont systemFontOfSize:14];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case 2://重置密码和关于我们
        {
            switch (indexPath.row) {
                case 0:
                {
                    cell.textLabel.text=@"重置密码";
                    cell.textLabel.font=[UIFont systemFontOfSize:14];
                    UILabel *labLine=[[UILabel alloc] initWithFrame:CGRectMake(0, 43, skScreenWidth, 1)];
                    labLine.backgroundColor=skLineColor;
                    [cell.contentView addSubview:labLine];
                }
                    break;
                case 1:
                    cell.textLabel.text=@"关于我们";
                    cell.textLabel.font=[UIFont systemFontOfSize:14];
                    break;
                    
                default:
                    break;
            }
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case 3:
        {
            UIButton *btnLoginOut=[[UIButton alloc] initWithFrame:CGRectMake(0, 2, skScreenWidth, 40)];
            [btnLoginOut setTitle:@"退出登录" forState:(UIControlStateNormal)];
            btnLoginOut.titleLabel.font=[UIFont systemFontOfSize:14];
            [btnLoginOut setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
            [btnLoginOut setTitleColor:[UIColor blackColor] forState:(UIControlStateHighlighted)];
            [cell.contentView addSubview:btnLoginOut];
            //退出账号
            @weakify(self)
            [[btnLoginOut rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
                @strongify(self)
                [skClassMethod skAlerView:@"确认退出当前账号?" message:nil cancalTitle:@"取消" sureTitle:@"确定" sureBlock:^{
                    [self LogOut];
                }];
                
            }];
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
    switch (indexPath.section) {
        case 0:
            
            break;
        case 1:
        {
            //消息提醒
            MessageViewController *view=[[MessageViewController alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    UIStoryboard *Main=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    ResetPasswordViewController *view=[Main instantiateViewControllerWithIdentifier:@"ResetPasswordViewController"];
                    view.Tel=skUser.UserName;
                    [self.navigationController pushViewController:view animated:YES];
                }
                    break;
                case 1:
                {
                    AboutUsViewController *view=[[AboutUsViewController alloc] init];
                    [self.navigationController pushViewController:view animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 3:
            
            break;
            
        default:
            break;
    }
}

#pragma mark - 退出登录
/**
 获取验证码
 */
-(void)LogOut{
    
    NSDictionary *parameters=@{
                               @"UserID":skUser.UserID
                               };
    
    
    [[SKNetworking sharedSKNetworking] SKPOST:skURLWithPort(@"LogOut") parameters:parameters showHUD:YES showErrMsg:YES success:^(id  _Nullable responseObject) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

@end
