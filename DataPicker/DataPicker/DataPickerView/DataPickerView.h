//
//  DataPickerView.h
//  eCityToHome
//
//  Created by jia on 15/11/3.
//  Copyright © 2015年 www.enn.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataPickerView;
@protocol DataPickerViewDelegate <NSObject>

- (void)dataPickerDidCancel:(DataPickerView *)dataPicker;
- (void)dataPicker:(DataPickerView *)dataPicker selectedRow:(NSInteger)row inDataSource:(NSArray *)dataSource;

@end

@interface DataPickerView : UIView

@property (nonatomic, strong) UIButton     *cancelButton;
@property (nonatomic, strong) UIButton     *doneButton;
@property (nonatomic, strong) UILabel      *titleLabel;
@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, assign) CGFloat       dataItemHeight;

@property (nonatomic, strong) NSArray      *dataSource;
@property (nonatomic, weak) id<DataPickerViewDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title height:(CGFloat)height;

- (void)showInView:(UIView *)superView;

@end
