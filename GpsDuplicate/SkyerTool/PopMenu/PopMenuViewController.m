//
//  PopMenuViewController.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/14.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "PopMenuViewController.h"

@interface PopMenuViewController ()
@end

@implementation PopMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    
    [self.view addSubview:self.pickerView];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIPickerView *)pickerView{
    if (nil==_pickerView) {
        _pickerView=[[UIPickerView alloc] initWithFrame:CGRectMake(0, skScreenHeight-120, skScreenWidth, 120)];
        _pickerView.delegate=self;
        _pickerView.dataSource=self;
        _pickerView.backgroundColor=[UIColor whiteColor];
    }
    return _pickerView;
}

//UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件包含的列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1; // 返回1表明该控件只包含1列
}

//UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // 由于该控件只包含一列，因此无须理会列序号参数component
    // 该方法返回teams.count，表明teams包含多少个元素，该控件就包含多少行
    return _arrData.count;
}


// UIPickerViewDelegate中定义的方法，该方法返回的NSString将作为UIPickerView
// 中指定列和列表项的标题文本
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    // 由于该控件只包含一列，因此无须理会列序号参数component
    // 该方法根据row参数返回teams中的元素，row参数代表列表项的编号，
    // 因此该方法表示第几个列表项，就使用teams中的第几个元素
    
    return [_arrData objectAtIndex:row];
}

// 当用户选中UIPickerViewDataSource中指定列和列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component
{
    if (_skIndexSelect) {
        _skIndexSelect(row);
    }
}

@end
