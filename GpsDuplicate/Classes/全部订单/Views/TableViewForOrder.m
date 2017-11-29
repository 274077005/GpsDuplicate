//
//  TableViewForOrder.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/28.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "TableViewForOrder.h"

@implementation TableViewForOrder 

-(void)skInitView{
    self.frame=CGRectMake(0, 0, kScreenWidth, kScreenHeight-114);
    _tableView=[[UITableView alloc] initWithFrame:self.bounds];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self addSubview:_tableView];
}
#pragma mark - cell的代理
#pragma mark cell 的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.0;
}
#pragma mark section下得cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}
#pragma mark 绘制一个cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    for(UIView *view in cell.contentView.subviews){
        
        [view removeFromSuperview];
        
    }
    cell.textLabel.text=@"ni shi zui shuai de ";
    return cell;
}
#pragma mark 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
