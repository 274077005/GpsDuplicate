//
//  skSelectView.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/4.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface skSelectView : UIView

@property (nonatomic,strong) NSMutableArray *arrButtons;
@property (nonatomic,strong) NSArray *arrTitle;
@property (nonatomic,strong) UIView *viewBottom;
@property (nonatomic,assign) NSInteger selectIndex;
@property (nonatomic,strong) UIColor *colorSelect;

//这个get方法的回调必须要调,不调用就拿不到东西,也会闪退.类似代理的必须
@property (nonatomic,copy)   void (^selectIndexBlock)(NSInteger index);


/**
 初始化

 @param frame frame
 @param arrTitles 标题的数组
 @param index 首次选中的下标
 @param selectColor 选中的颜色
 @return 自己
 */
- (instancetype)initWithFrame:(CGRect)frame andTitleArr:(NSArray *)arrTitles andSelectIndex:(NSInteger)index andSelectColor:(UIColor *)selectColor;

/**
 主动修改显示的选项

 @param index 需要修改的下标
 */
-(void)skChangSelect:(NSInteger)index;
@end
