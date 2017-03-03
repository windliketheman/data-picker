//
//  ViewController.m
//  DataPicker
//
//  Created by jia on 2017/3/3.
//  Copyright © 2017年 orange. All rights reserved.
//

#import "ViewController.h"
#import "DataPickerView.h"

@interface ViewController () <DataPickerViewDelegate>

@property (nonatomic, strong) DataPickerView *datePickerView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self  setupSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Subviews
- (void)setupSubviews
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Picker" style:UIBarButtonItemStylePlain target:self action:@selector(pickerButtonPressed)];
    
    self.navigationItem.rightBarButtonItem = item;
}

- (void)pickerButtonPressed
{
    DataPickerView *datePicker = [[DataPickerView alloc] initWithTitle:@"请选择日期" height:CGRectGetHeight(self.view.frame)*0.4];
    datePicker.backgroundColor = [UIColor redColor];
    datePicker.delegate = self;
    datePicker.dataSource = [self datePickerDataSource];
    datePicker.tag = 1;
    self.datePickerView = datePicker;
    [datePicker showInView:self.view];
}

- (NSArray *)datePickerDataSource
{
    NSArray *array = @[@"不限", @"周五  11月20日", @"周六  11月21日", @"周日  11月22日", @"周一  11月23日", @"周二  11月24日", @"周三  11月25日", @"周四  11月26日",];
    return array;
}

@end
