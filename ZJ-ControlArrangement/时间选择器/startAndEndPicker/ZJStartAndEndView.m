//
//  WXZPickDateView.m
//  自定义选择器
//
//  Created by WOSHIPM on 2017/4/28.
//  Copyright © 2017年 WOSHIPM. All rights reserved.
//

#import "ZJStartAndEndView.h"
@interface ZJStartAndEndView()<UIPickerViewDataSource, UIPickerViewDelegate>
/** 选择的年 */
@property (nonatomic, assign)NSInteger selectYear;
/** 选择的月 */
@property (nonatomic, assign)NSInteger selectMonth;
/** 选择的日 */
@property (nonatomic, assign)NSInteger selectDay;

@property (nonatomic, assign)NSInteger currentYear;
@property (nonatomic, assign)NSInteger currentMonth;
@property (nonatomic, assign)NSInteger currentDay;
@property (nonatomic, assign)NSInteger defaultYear;
@property (nonatomic, assign)NSInteger defaultMonth;
@property (nonatomic, assign)NSInteger defaultDay;

@property (nonatomic, assign)NSInteger startYear;
@property (nonatomic, assign)NSInteger endYear;
@property (nonatomic, assign)NSInteger startMonth;
@property (nonatomic, assign)NSInteger endMonth;
@property (nonatomic, assign)NSInteger startDay;
@property (nonatomic, assign)NSInteger endDay;

@property (nonatomic, assign)NSInteger minShowYear;

@property (nonatomic, assign)NSInteger yearSum;

@property (nonatomic, assign)NSInteger getYear;
@property (nonatomic, assign)NSInteger getMonth;
@property (nonatomic, assign)NSInteger getDay;


@end
@implementation ZJStartAndEndView

- (void)initPickView {
    [super initPickView];
    
//    NSString *str = @"ee";
//    _currentYear = [str integerValue];
    
//    self.startYear = 2017;
//    self.endYear = 2019;
//    
//    self.startMonth = 5;
//    self.endMonth = 10;
//    
//    self.startDay = 5;
//    self.endDay = 10;
    
    
//    _minShowYear = 1940;//最小年份
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* dt = [NSDate date];
    // 指定获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags fromDate:dt];
    
//    _yearSum = comp.year-_minShowYear+1;
//    _yearSum = 2080;
    _currentYear=comp.year;
    _currentMonth=comp.month;
    _currentDay=comp.day;
 
    _selectYear  = comp.year;
    _selectMonth = comp.month;
    _selectDay   = comp.day;
     _defaultYear = comp.year;
    _defaultMonth = comp.month;
    _defaultDay=comp.day;
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];

}

- (void)startData:(NSString *)startData andEndData:(NSString *)endData{
    if (startData && startData.length > 0) {
        NSArray *startDataArray = [startData componentsSeparatedByString:@"-"];
        self.startYear = [startDataArray[0] integerValue];
        self.startMonth = [startDataArray[1] integerValue];
        self.startDay = [startDataArray[2] integerValue];
        
        _minShowYear = self.startYear;
    }
    
    if (endData && endData.length > 0) {
        NSArray *endDataArray = [endData componentsSeparatedByString:@"-"];
        self.endYear = [endDataArray[0] integerValue];
        self.endMonth = [endDataArray[1] integerValue];
        self.endDay = [endDataArray[2] integerValue];
        
        _yearSum = self.endYear;
    }
}

- (void)setDefaultTSelectYear:(NSInteger)defaultSelectYear defaultSelectMonth:(NSInteger)defaultSelectMonth defaultSelectDay:(NSInteger)defaultSelectDay withTitle:(NSString *)title{
    if (title && title.length > 0) {
        self.titleLab.text = title;
    } else {
        self.titleLab.text = @"选择日期";
    }
    
    if (defaultSelectYear != 0) {
     _defaultYear = defaultSelectYear;
    }
    
    if (defaultSelectMonth != 0) {
        _defaultMonth = defaultSelectMonth;
    }
    
    if (defaultSelectDay != 0) {
         _defaultDay=defaultSelectDay;
    }
    
    if (defaultSelectYear == -1) {
        _defaultYear=_currentYear+1;
        _defaultMonth=1;
        _defaultDay=1;
    }
   
    [self.pickerView selectRow:(_defaultYear - _minShowYear) inComponent:0 animated:NO];

    [self.pickerView selectRow:(_defaultMonth - 1) inComponent:1 animated:NO];
        [self.pickerView reloadComponent:1];
    if (_isShowDay == YES) {
        [self.pickerView selectRow:(_defaultDay-1) inComponent:2 animated:NO];
          [self.pickerView reloadComponent:2];
    }
    [self refreshPickViewData];
    
}

- (void)setIsAddYetSelect:(BOOL)isAddYetSelect{
    _isAddYetSelect = isAddYetSelect;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (_isShowDay == YES) {
        return 3;
    } else {
        return 2;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        if (_isAddYetSelect==YES) {
            //显示至今选项的话，需要比总共要显示的年份多返回一行
            return self.yearSum+1;
            
        }else{
          
            return _endYear - _startYear + 1;
        }
    } else if(component == 1) {
//        NSInteger yearSelected = [pickerView selectedRowInComponent:0] + self.minShowYear;
//        if (yearSelected==_currentYear+1) {
//            //至今选项的时候月份信息不返回
//            return 0;
//        }else{
        
        NSInteger selectRow = [pickerView selectedRowInComponent:0];
        
        if(selectRow == 0){
            return 12 - self.startMonth + 1;
        }else if (selectRow == _endYear - _startYear){
            return self.endMonth;
        }
        
            return 12;
//        }
    } else {
//        NSInteger yearSelected = [pickerView selectedRowInComponent:0] + self.minShowYear;
//        if (yearSelected==_currentYear+1) {
//             //至今选项的时候日信息不返回
//            return 0;
//        }else{
        
//        NSInteger yearSelected = [pickerView selectedRowInComponent:0] + self.minShowYear;
        NSInteger monthSelected = [pickerView selectedRowInComponent:1] + 1;
        
        
        NSInteger selectYear = [pickerView selectedRowInComponent:0];
        NSInteger selectMonth = [pickerView selectedRowInComponent:1];
        
        
        
        
        
        if(selectYear==0){
            
            NSInteger daysOfcurrentMonth =  [self getDaysWithYear:self.startYear month:self.startMonth + selectMonth];
            if(selectMonth == 0){
                return daysOfcurrentMonth - self.startDay + 1;
            }
            return daysOfcurrentMonth;
        }else if (selectYear + self.startYear==self.endYear){
            if(selectMonth + 1 == self.endMonth){
              return self.endDay;
            }
            return [self getDaysWithYear:self.endYear month: 1 + selectMonth];
        }else{
            return [self getDaysWithYear:selectYear + self.startYear month:selectMonth + 1];
        }
        
        
//        }
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    
    NSString *text;
    if (component == 0) {
        
        if (_isAddYetSelect==YES) {
            
            //            if (row+_minShowYear == _currentYear+1) {
            //                text=@"至今";
            //
            //            }else{
            
            
            text =  [NSString stringWithFormat:@"%zd年", row + _minShowYear];
            
            //            }
            
        }else{
            
            text =  [NSString stringWithFormat:@"%zd年", row + self.startYear];
//            self.getYear = row + self.startYear;
            
        }
        
    }else if (component == 1){
        if (_isAddYetSelect == YES) {
            //            NSInteger yearSelected = [pickerView selectedRowInComponent:0] + self.minShowYear;
            //            if (yearSelected == _currentYear+1) {
            //                text =  [NSString stringWithFormat:@""];
            //            }else{
            text =  [NSString stringWithFormat:@"%zd月", row + 1];
            //            }
        } else {
            NSInteger selectRow = [pickerView selectedRowInComponent:0];
            if(selectRow == 0){
                text =  [NSString stringWithFormat:@"%zd月", self.startMonth + row];
//                self.getMonth = row + self.startMonth;
            }else{
                text =  [NSString stringWithFormat:@"%zd月", row + 1];
//                self.getMonth = row + 1;

            }
            
            
        }
        
        
    } else {
        
        NSInteger selectYear = [pickerView selectedRowInComponent:0];
        NSInteger selectMonth = [pickerView selectedRowInComponent:1];
        
        if (selectYear == 0 && selectMonth == 0){
            text = [NSString stringWithFormat:@"%zd日", row + self.startDay];
//            self.getDay = row + self.startDay;
        } else {
            text = [NSString stringWithFormat:@"%zd日", row + 1];
//            self.getDay = row + 1;
        }
        
        
    }
    
    UIView *lineViewOne = (UIView *)[pickerView.subviews objectAtIndex:1];
    UIView *lineViewTwo = (UIView *)[pickerView.subviews objectAtIndex:2];
    lineViewOne.backgroundColor = [UIColor clearColor];
    lineViewTwo.backgroundColor = [UIColor clearColor];
    [self setUPLineViewOne:lineViewOne andLineViewTwo:lineViewTwo];
    
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    label.text = text;
    
    return label;
}

- (NSInteger)getDaysWithYear:(NSInteger)year
                       month:(NSInteger)month {
    switch (month) {
        case 1:
            return 31;
            break;
        case 2:
            if (year%400==0 || (year%100!=0 && year%4 == 0)) {
                return 29;
            }else{
                return 28;
            }
            break;
        case 3:
            return 31;
            break;
        case 4:
            return 30;
            break;
        case 5:
            return 31;
            break;
        case 6:
            return 30;
            break;
        case 7:
            return 31;
            break;
        case 8:
            return 31;
            break;
        case 9:
            return 30;
            break;
        case 10:
            return 31;
            break;
        case 11:
            return 30;
            break;
        case 12:
            return 31;
            break;
        default:
            return 0;
            break;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    //每一行的高度
    return 44;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSInteger selectYear;
    NSInteger selectMonth;
    
    switch (component) {
        case 0:
    
            [pickerView reloadComponent:1];
            if (_isAddYetSelect == YES) {
                selectYear = row+_minShowYear+1;
            }else{
                selectYear = row+_minShowYear;
            }
            if (_isShowDay == YES) {
                [pickerView reloadComponent:2];
            }
            break;
        case 1:
            selectMonth = row+1;
            if (_isShowDay == YES) {
                [pickerView reloadComponent:2];
            }
        default:
            break;
    }
    [self refreshPickViewData];
}




//设置分割线实现
- (void)setUPLineViewOne:(UIView *)lineViewOne andLineViewTwo:(UIView *)lineViewTwo{
    CGFloat W = (screenHeight == 736) ? 32 : 24;
    
    UILabel *labupOne = [[UILabel alloc] initWithFrame:CGRectMake(W, 0, 72, 0.5)];//
    labupOne.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB" alpha:1];
    [lineViewOne addSubview:labupOne];

    
    UILabel *labupTwo = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width-72)/2, 0, 72, 0.5)];//WithFrame:CGRectMake(48+86+10, 0, 86, 0.5)
    labupTwo.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB" alpha:1];
    [lineViewOne addSubview:labupTwo];
    
    UILabel *labupThree = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-W-72, 0, 72, 0.5)];//
    labupThree.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB" alpha:1];
    [lineViewOne addSubview:labupThree];
    
    
    UILabel *labButtonOne = [[UILabel alloc] initWithFrame:CGRectMake(W, 0, 72, 0.5)];//
    labButtonOne.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB" alpha:1];
    [lineViewTwo addSubview:labButtonOne];
    
    UILabel *labButtonTwo = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width-72)/2, 0, 72, 0.5)];//
    labButtonTwo.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB" alpha:1];
    [lineViewTwo addSubview:labButtonTwo];
    
    UILabel *labButtonThree = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-W-72, 0, 72, 0.5)];//
    labButtonThree.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB" alpha:1];
    [lineViewTwo addSubview:labButtonThree];
}


- (void)clickConfirmButton{
    
    NSInteger oneRow = [self.pickerView selectedRowInComponent:0];
    NSInteger twoRow = [self.pickerView selectedRowInComponent:1];
    NSInteger threeRow = [self.pickerView selectedRowInComponent:2];

    self.getYear = oneRow + self.startYear;

    if(oneRow == 0){
            self.getMonth = twoRow + self.startMonth;
    } else {
        self.getMonth = twoRow + 1;
    }
    
    if (oneRow == 0 && twoRow == 0){
        self.getDay = threeRow + self.startDay;
    } else {
        self.getDay = threeRow + 1;
    }
    

    if ([self.delegate respondsToSelector:@selector(startAndEndPickerDateView:selectYear:selectMonth:selectDay:)]) {
        
        NSLog(@"%zi-%zi-%zi",self.getYear,self.getMonth-1,self.getDay);

        [self.delegate startAndEndPickerDateView:self selectYear:self.getYear selectMonth:self.getMonth-1 selectDay:self.getDay];
    
    }
    
    [super clickConfirmButton];
    
}



- (void)refreshPickViewData{
    
    self.selectYear  = [self.pickerView selectedRowInComponent:0] + self.minShowYear;
    
    self.selectMonth = [self.pickerView selectedRowInComponent:1] + 1;
    if (_isShowDay == YES) {
          self.selectDay   = [self.pickerView selectedRowInComponent:2] + 1;
    }
    
}
 
- (void)setCancelBtnStr:(NSString *)cancelBtnStr{
    _cancelBtnStr = cancelBtnStr;
    if (cancelBtnStr && cancelBtnStr.length > 0) {
        [self.cancelButton setTitle:_cancelBtnStr forState:UIControlStateNormal];
    }
}

- (void)setOkBtnStr:(NSString *)okBtnStr{
    _okBtnStr = okBtnStr;
    if (okBtnStr && okBtnStr.length > 0) {
        [self.confirmButton setTitle:_okBtnStr forState:UIControlStateNormal];
    }
}
- (void)setYearLeast:(NSInteger)yearLeast{
    _minShowYear = yearLeast;
}

- (void)setYearSum:(NSInteger)yearSum{
    _yearSum = yearSum;
}

-(void)setIsShowDay:(BOOL)isShowDay{
    _isShowDay = isShowDay;
}
#pragma mark - --- getters 属性 ---

@end
