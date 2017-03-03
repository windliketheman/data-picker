//
//  DataPickerView.m
//  eCityToHome
//
//  Created by jia on 15/11/3.
//  Copyright © 2015年 www.enn.cn. All rights reserved.
//

#import "DataPickerView.h"
#import "PureLayout.h"

@interface DataPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>
@end

@implementation DataPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title height:(CGFloat)height
{
    self.dataItemHeight = 40;
    
    CGRect frame = CGRectZero;
    frame.size.width = [[UIScreen mainScreen] bounds].size.width;
    frame.size.height = height;
    if ([self initWithFrame:frame])
    {
        [self setupSubviews];
        
        self.titleLabel.text = title;
    }
    return self;
}

- (void)setupSubviews
{
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectZero];
    cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
    [cancelButton setTitle:NSLocalizedString(@"取消", nil) forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    cancelButton.backgroundColor = [UIColor yellowColor];
    [cancelButton addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    self.cancelButton = cancelButton;
    
    UIButton *doneButton = [[UIButton alloc] initWithFrame:CGRectZero];
    doneButton.translatesAutoresizingMaskIntoConstraints = NO;
    [doneButton setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    doneButton.backgroundColor = [UIColor yellowColor];
    [doneButton addTarget:self action:@selector(doneButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    self.doneButton = doneButton;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor greenColor];
    self.titleLabel = titleLabel;
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    pickerView.dataSource = self;
    pickerView.delegate   = self;
    pickerView.backgroundColor = [UIColor blueColor];
    self.pickerView = pickerView;
    
    [self addSubview:cancelButton];
    [self addSubview:doneButton];
    [self addSubview:titleLabel];
    [self addSubview:pickerView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.cancelButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15.0];
    [self.cancelButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5.0];
    [self.cancelButton autoSetDimensionsToSize:CGSizeMake(60, 25)];
    
    [self.doneButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15.0];
    [self.doneButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5.0];
    [self.doneButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.cancelButton];
    [self.doneButton autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.cancelButton];
    
    [self.titleLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.cancelButton];
    [self.titleLabel autoSetDimension:ALDimensionHeight toSize:20.0];
    [self.titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.cancelButton withOffset:15.0];
    [self.titleLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.doneButton withOffset:-15.0];
    
    [self.pickerView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleLabel withOffset:10.0];
    [self.pickerView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0];
    [self.pickerView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0];
    [self.pickerView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0];
}

- (void)showInView:(UIView *)superView
{
    [superView addSubview:self];
    
    __block CGRect frame = self.frame;
    frame.origin.y = CGRectGetHeight(superView.frame);
    self.frame = frame;
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        frame.origin.y -= CGRectGetHeight(frame);
        self.frame = frame;
    } completion:^(BOOL finished) {
        //
    }];
}

- (void)removeDataPickerView
{
    __weak __typeof(self) wself = self;
    __block CGRect frame = self.frame;
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        frame.origin.y = CGRectGetHeight(self.superview.frame);
        wself.frame = frame;
    } completion:^(BOOL finished) {
        if (wself.superview)
        {
            [super removeFromSuperview];
        }
    }];
}

- (void)cancelButtonPressed
{
    [self removeDataPickerView];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(dataPickerDidCancel:)])
    {
        [self.delegate dataPickerDidCancel:self];
    }
}

- (void)doneButtonPressed
{
    [self removeDataPickerView];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(dataPicker:selectedRow:inDataSource:)])
    {
        [self.delegate dataPicker:self selectedRow:[self.pickerView selectedRowInComponent:0] inDataSource:self.dataSource];
    }
}

#pragma mark - Picker View
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataSource.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return self.dataItemHeight;
}

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view;
    
    if (pickerLabel == nil)
    {
        CGRect frame = CGRectZero;
        frame.size.width = CGRectGetWidth(self.pickerView.frame);
        frame.size.height = self.dataItemHeight;
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:20.0f]];
    }
    pickerLabel.text =  [self.dataSource objectAtIndex:row];
    
    return pickerLabel;
}

@end
