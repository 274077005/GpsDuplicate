//
//  skSelectView.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/4.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "skSelectView.h"

@implementation skSelectView

- (instancetype)initWithFrame:(CGRect)frame andTitleArr:(NSArray *)arrTitles andSelectIndex:(NSInteger)index andSelectColor:(UIColor *)selectColor;
{
    self = [super initWithFrame:frame];
    _arrTitle=arrTitles;
    _selectIndex=index;
    _colorSelect=selectColor;
    _arrButtons=[[NSMutableArray alloc] init];
    if (self) {
        CGFloat oneWidth=self.frame.size.width/arrTitles.count;
        self.backgroundColor=[UIColor whiteColor];
        
        for (int i=0; i<arrTitles.count; ++i) {
            NSString *title=[_arrTitle objectAtIndex:i];
            //一个标题的按钮
            UIButton *btnSelect=[[UIButton alloc] initWithFrame:CGRectMake(i*oneWidth, 0, oneWidth, frame.size.height)];
            [btnSelect setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            [btnSelect setTitle:title forState:(UIControlStateNormal)];
            [btnSelect addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
            btnSelect.tag=i;
            btnSelect.titleLabel.font =[UIFont systemFontOfSize:14];
            [self addSubview:btnSelect];
            [_arrButtons addObject:btnSelect];
            //每个标题中间的一个分割线
            if (i>0) {
                UILabel *labLine=[[UILabel alloc] initWithFrame:CGRectMake(i*oneWidth, 10, 1, frame.size.height-20)];
                labLine.backgroundColor=[UIColor lightGrayColor];
                [self addSubview:labLine];
            }
            //选中的下标view
            if (i==index) {
                [btnSelect setTitleColor:_colorSelect forState:(UIControlStateNormal)];
                CGSize titleSize=[self titleSize:title labWidth:MAXFLOAT fontOfSize:14];
                _viewBottom=[[UIButton alloc] initWithFrame:CGRectMake((oneWidth-titleSize.width)/2, frame.size.height-4, titleSize.width, 4)];
                _viewBottom.backgroundColor=_colorSelect;
                [self addSubview:_viewBottom];
            }
            
        }
    }
    return self;
}
-(void)btnAction:(UIButton *)sender{
    [self skChangSelect:sender.tag];
}
//设置选中的样式
-(void)skChangSelect:(NSInteger)index{
    _selectIndex=index;
    _selectIndexBlock(index);
    CGFloat oneWidth=self.frame.size.width/_arrTitle.count;
    for (int i=0; i<_arrTitle.count; ++i) {
        UIButton *btnSelect=[_arrButtons objectAtIndex:i];
        [btnSelect setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        
        NSString *title=[_arrTitle objectAtIndex:i];
        if (i==_selectIndex) {
            [btnSelect setTitleColor:_colorSelect forState:(UIControlStateNormal)];
            CGSize titleSize=[self titleSize:title labWidth:MAXFLOAT fontOfSize:14];
            
            [UIView animateWithDuration:0.3 animations:^{
                _viewBottom.frame=CGRectMake(i*oneWidth+(oneWidth-titleSize.width)/2, self.frame.size.height-4, titleSize.width, 4);
            }];
            
            [self addSubview:_viewBottom];
        }
    }
}



-(CGSize)titleSize:(NSString *)text
            labWidth:(CGFloat)width
          fontOfSize:(CGFloat)size{
    
    CGSize titleSize = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil].size;
    
    return titleSize;
}
@end
