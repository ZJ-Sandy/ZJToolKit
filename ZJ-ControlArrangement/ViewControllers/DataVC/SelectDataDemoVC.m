//
//  SelectDataDemoVC.m
//  ZJ-ControlArrangement
//
//  Created by 志杰 on 2019/7/29.
//  Copyright © 2019 志杰. All rights reserved.
//

#import "SelectDataDemoVC.h"
#import "LYSDatePickerController.h"

@interface SelectDataDemoVC ()<LYSDatePickerSelectDelegate>

@end

@implementation SelectDataDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"时间选择demo";
    [self setupUI];
    
}
- (void)setupUI{
    [self setupSignleTableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [UITableViewCell mk_cellWithDefaultStyleTableView:tableView];
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"类: 年/月/日/时/分";
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"类: 年/月/日";
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"类: 时/分";
        }
            break;
        case 3:
        {
            cell.textLabel.text = @"实例: 年/月/日/时/分";
        }
            break;
        case 4:
        {
            cell.textLabel.text = @"实例: 年/月/日";
        }
            break;
        case 5:
        {
            cell.textLabel.text = @"实例: 时/分";
        }
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            [LYSDatePickerController alertDatePickerInWindowRootVC];
            [LYSDatePickerController customPickerDelegate:self];
            [LYSDatePickerController customdidSelectDatePicker:^(NSDate *date) {
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy/MM/dd/HH/mm"];
                NSString *currentDate = [dateFormat stringFromDate:date];
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                cell.detailTextLabel.text = currentDate;
            }];
        }
            break;
        case 1:
        {
            [LYSDatePickerController alertDatePickerWithController:self type:(LYSDatePickerTypeDay)];
            [LYSDatePickerController customPickerDelegate:self];
            [LYSDatePickerController customdidSelectDatePicker:^(NSDate *date) {
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy/MM/dd/HH/mm"];
                NSString *currentDate = [dateFormat stringFromDate:date];
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                cell.detailTextLabel.text = currentDate;
            }];
        }
            break;
        case 2:
        {
            NSDate *date = [NSDate dateWithTimeIntervalSinceNow:1000000];
            [LYSDatePickerController alertDatePickerWithController:self type:(LYSDatePickerTypeDayAndTime) selectDate:date];
            [LYSDatePickerController customPickerDelegate:self];
            [LYSDatePickerController customdidSelectDatePicker:^(NSDate *date) {
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy/MM/dd/HH/mm"];
                NSString *currentDate = [dateFormat stringFromDate:date];
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                cell.detailTextLabel.text = currentDate;
            }];
        }
            break;
        case 3:
        {
            LYSDatePickerController *datePicker = [[LYSDatePickerController alloc] init];
            datePicker.headerView.backgroundColor = [UIColor colorWithRed:84/255.0 green:150/255.0 blue:242/255.0 alpha:1];
            datePicker.indicatorHeight = 1;
            datePicker.delegate = self;
            datePicker.headerView.centerItem.textColor = [UIColor whiteColor];
            datePicker.headerView.leftItem.textColor = [UIColor whiteColor];
            datePicker.headerView.rightItem.textColor = [UIColor whiteColor];
            datePicker.pickHeaderHeight = 40;
            datePicker.pickType = LYSDatePickerTypeDayAndTime;
            datePicker.minuteLoop = YES;
            datePicker.headerView.showTimeLabel = YES;
            datePicker.weakDayType = LYSDatePickerWeakDayTypeUSShort;
            datePicker.showWeakDay = YES;
            [datePicker setDidSelectDatePicker:^(NSDate *date) {
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy/MM/dd/HH/mm"];
                NSString *currentDate = [dateFormat stringFromDate:date];
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                cell.detailTextLabel.text = currentDate;
            }];
            [datePicker showDatePickerWithController:self];
        }
            break;
        case 4:
        {
            LYSDatePickerController *datePicker = [[LYSDatePickerController alloc] init];
            datePicker.headerView.backgroundColor = [UIColor colorWithRed:84/255.0 green:150/255.0 blue:242/255.0 alpha:1];
            datePicker.indicatorHeight = 1;
            datePicker.delegate = self;
            datePicker.headerView.centerItem.textColor = [UIColor whiteColor];
            datePicker.headerView.leftItem.textColor = [UIColor whiteColor];
            datePicker.headerView.rightItem.textColor = [UIColor whiteColor];
            datePicker.pickHeaderHeight = 40;
            datePicker.pickType = LYSDatePickerTypeDay;
            datePicker.minuteLoop = YES;
            datePicker.headerView.showTimeLabel = NO;
            datePicker.weakDayType = LYSDatePickerWeakDayTypeCNShort;
            datePicker.showWeakDay = YES;
            [datePicker setDidSelectDatePicker:^(NSDate *date) {
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy/MM/dd/HH/mm"];
                NSString *currentDate = [dateFormat stringFromDate:date];
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                cell.detailTextLabel.text = currentDate;
            }];
            [datePicker showDatePickerWithController:self];
        }
            break;
        case 5:
        {
            LYSDatePickerController *datePicker = [[LYSDatePickerController alloc] init];
            datePicker.headerView.backgroundColor = [UIColor colorWithRed:84/255.0 green:150/255.0 blue:242/255.0 alpha:1];
            datePicker.indicatorHeight = 5;
            datePicker.delegate = self;
            datePicker.headerView.centerItem.textColor = [UIColor whiteColor];
            datePicker.headerView.leftItem.textColor = [UIColor whiteColor];
            datePicker.headerView.rightItem.textColor = [UIColor whiteColor];
            datePicker.pickHeaderHeight = 40;
            datePicker.pickType = LYSDatePickerTypeTime;
            datePicker.minuteLoop = YES;
            datePicker.headerView.showTimeLabel = NO;
            datePicker.weakDayType = LYSDatePickerWeakDayTypeUSDefault;
            datePicker.showWeakDay = YES;
            [datePicker setDidSelectDatePicker:^(NSDate *date) {
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy/MM/dd/HH/mm"];
                NSString *currentDate = [dateFormat stringFromDate:date];
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                cell.detailTextLabel.text = currentDate;
            }];
            [datePicker showDatePickerWithController:self];
        }
            break;
        default:
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}


@end
