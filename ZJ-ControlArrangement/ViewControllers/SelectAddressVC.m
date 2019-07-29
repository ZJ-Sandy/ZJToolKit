//
//  SelectAddressVC.m
//  ZJ-ControlArrangement
//
//  Created by 志杰 on 2019/7/26.
//  Copyright © 2019 志杰. All rights reserved.
//

#import "SelectAddressVC.h"
#import "ZJSelectAdView.h"
#import "GDRCCitySelectViewController.h"
#import "GDRCAddressPickerView.h"

@interface SelectAddressVC ()

@end

@implementation SelectAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地址选择控件";
    self.datasArray = [[NSMutableArray alloc] initWithObjects:@"上拉三级联动",@"二级地址选择",@"五级联动", nil];
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
        NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"aiai_area.txt" ofType:nil]];
        ZJSelectAdView *selectAdView = [[ZJSelectAdView alloc] initWithLastContent:@[@"2",@"2",@"2"] withData:data withTitle:@"ZJ"];
        selectAdView.confirmSelect = ^(NSArray *address) {
            NSLog(@"address ----- %@",address);
        };
    } else if (indexPath.row == 1) {
        GDRCCitySelectViewController *vc = [[GDRCCitySelectViewController alloc] init];
        vc.finishBlock = ^(NSDictionary *addressDic) {
            NSLog(@"addressDic ----- %@",addressDic);
        };
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 2) {
        GDRCAddressPickerView *addressPickView = [[GDRCAddressPickerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        addressPickView.callBack = ^(NSDictionary * _Nonnull dict) {
            NSLog(@"addressPickView ------- %@",dict);
        };
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:addressPickView];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasArray.count;
}

@end
