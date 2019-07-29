//
//  ViewController.m
//  ZJ-ControlArrangement
//
//  Created by 志杰 on 2019/7/26.
//  Copyright © 2019 志杰. All rights reserved.
//

#import "ViewController.h"
#import "ZJUIHelper.h"
#import "SelectAddressVC.h"
#import "SelectDataVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"控件列表实现";
    self.datasArray = [[NSMutableArray alloc] initWithObjects:@"toast实现",@"loading显示",@"地址选择器",@"时间选择器",@"弹框控件",@"左滑控件",@"引导页实现", nil];
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
        [ZJUIHelper showToast:@"ZJ ZJ 你好👋,欢迎大家来到ZJ控件集合"];
    } else if (indexPath.row == 1) {
        [ZJUIHelper showLoadingViewWith:@"ZJ欢迎大家使用"];
    } else if (indexPath.row == 2) {
        SelectAddressVC *vc = [[SelectAddressVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 3) {
        SelectDataVC *vc = [[SelectDataVC alloc] init];
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
