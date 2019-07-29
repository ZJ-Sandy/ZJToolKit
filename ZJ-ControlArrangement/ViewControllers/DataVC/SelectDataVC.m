//
//  SelectDataVC.m
//  ZJ-ControlArrangement
//
//  Created by 志杰 on 2019/7/29.
//  Copyright © 2019 志杰. All rights reserved.
//

#import "SelectDataVC.h"
#import "LZCustomLimitDatePicker.h"
#import "ZJDatePickerView.h"
#import "SelectDataDemoVC.h"
#import "SelectDataTimePickerVC.h"

@interface SelectDataVC ()

@end

@implementation SelectDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"时间选择器";
    self.datasArray = [[NSMutableArray alloc] initWithObjects:@"可以设置开始和结束时间，设置显示指定时间",@"时间显示",@"日期选择第三方demo",@"time Picker", nil];
    [self setupUI];
}

- (void)setupUI{
    [self setupSignleTableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [UITableViewCell mk_cellWithDefaultStyleTableView:tableView];
    cell.textLabel.text = self.datasArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        //开始时间：
        NSString *startData = @"2008-3-4";
        //结束时间：
        NSString *endData = @"2019-8-7";
        //显示当前时间：
        NSString *currentData = @"2018-5-4";
        //tittle显示
        NSString *title = @"时间选择";
        //左边按钮
        NSString *cancelString = @"取消";
        //右边按钮
        NSString *okString = @"确定";
        [[LZCustomLimitDatePicker initCustomLimitDatePicker] showWithMaxDateString:endData withMinDateString:startData withCurrentDateString:currentData leftTitle:cancelString rightTitle:okString mainTitle:title didSeletedDateStringBlock:^(NSString *dateString) {
            NSArray *currentDataArray = [dateString componentsSeparatedByString:@"-"];
            NSString *yearDateStr = currentDataArray[0];
            NSString *monthDateStr = currentDataArray[1];
            NSString *dayDateStr = currentDataArray[2];
            NSLog(@"year=%@，month=%@，day=%@",yearDateStr,monthDateStr,dayDateStr);
        }];
    } else if (indexPath.row == 1) {
        ZJDatePickerView *pickerView = [[ZJDatePickerView alloc] init];
        [pickerView showWithBlock:^(ZJDatePickerView *datePickerView, NSDate *date) {
            NSLog(@"data ===== %@",date);
        }];
    } else if (indexPath.row == 2) {
        SelectDataDemoVC *vc = [[SelectDataDemoVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 3) {
        SelectDataTimePickerVC *vc = [[SelectDataTimePickerVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasArray.count;
}



@end
